import Quick
import Nimble
import PromiseKit
@testable import RemoteService

class TaskTests: QuickSpec {
    override func spec() {
        describe("Task") {
            var task: Task!
            var webService: MockWebService!
            var dataTaskComponents: DataTaskComponents!

            beforeEach {
                dataTaskComponents = DataTaskComponents(route: MockRoute())
                webService = MockWebService()
                webService.resource = RemoteResource(statusCode: nil, data: nil, error: nil)
                webService.urlSessionTask = MockURLSessionTask()
                task = Task(webService: webService)
            }

            it("cancels its task") {
                let urlSessionTask = MockURLSessionTask()
                task.task = urlSessionTask
                task.cancel()
                expect(urlSessionTask.didCancel).toEventually(beTrue())
            }

            context("decodable task promise") {
                it("resumes its task") {
                    let urlSessionTask = MockURLSessionTask()
                    webService.urlSessionTask = urlSessionTask
                    _ = task.decodableTaskPromise(dataTaskComponents: dataTaskComponents, forType: MockDecodable.self)
                    expect(urlSessionTask.didResume).toEventually(beTrue())
                }

                it("rejects promise if status code is invalid") {
                    webService.resource = RemoteResource(statusCode: 500, data: nil, error: nil)
                    var didReject = false
                    task.decodableTaskPromise(dataTaskComponents: dataTaskComponents, forType: MockDecodable.self).catch { error in
                        if case DataServiceError.requestFailed(_) = error {
                            didReject = true
                        }
                    }
                    expect(didReject).toEventually(beTrue())
                }

                it("rejects promise if decode fails") {
                    webService.resource = RemoteResource(statusCode: 200, data: Data(), error: nil)
                    var didReject = false
                    task.decodableTaskPromise(dataTaskComponents: dataTaskComponents, forType: MockDecodable.self).catch { error in
                        if case DecodingError.dataCorrupted(_) = error {
                            didReject = true
                        }
                    }
                    expect(didReject).toEventually(beTrue())
                }

                it("fulfills promise if decode succeeds") {
                    let data = try! JSONEncoder().encode(MockDecodable())
                    webService.resource = RemoteResource(statusCode: 200, data: data, error: nil)
                    var didFulfill = false
                    task.decodableTaskPromise(dataTaskComponents: dataTaskComponents, forType: MockDecodable.self).then { _ -> Void in
                        didFulfill = true
                    }
                    expect(didFulfill).toEventually(beTrue())
                }
            }
        }
    }
}

fileprivate class MockDecodable: Codable {
    
}

fileprivate class MockURLSessionTask: URLSessionTaskProtocol {
    var didCancel = false
    var didResume = true

    func resume() {
        didResume = true
    }

    func cancel() {
        didCancel = true
    }
}

fileprivate class MockWebService: WebServiceProtocol {
    var urlSessionTask: MockURLSessionTask!
    var resource: RemoteResource!

    func dataTask(dataTaskComponents: DataTaskComponents, completion: @escaping (RemoteResource) -> ()) -> URLSessionTaskProtocol {
        completion(resource)
        return urlSessionTask
    }
}

fileprivate class MockRoute: Routable {
    var path: String = "/path"
    var host: String = "host.com"
    var port: Int? = 80
}
