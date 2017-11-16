import Quick
import Nimble
import Domain
@testable import RemoteService

class TaskTests: QuickSpec {
    override func spec() {
        describe("Task") {
            var webService: MockWebService!
            var observer: ServiceObserver<MockCodeable>!
            var dataTaskComponents: DataTaskComponents!

            beforeEach {
                dataTaskComponents = DataTaskComponents(route: Route.tickers)
                observer = ServiceObserver()
                webService = MockWebService()
            }

            context("status code is invalid") {
                beforeEach {
                    webService.remoteResource = RemoteResource()
                }

                it("sends didStart to observers") {
                    var result = false
                    observer.onStart = {
                        result = true
                    }
                    let task = Task(webService: webService, dataTaskComponents: dataTaskComponents, observers: [observer])
                    task.executeJSONTask(forType: MockCodeable.self)
                    expect(result).toEventually(beTrue())
                }

                it("sends didFail to observers") {
                    var result = false
                    observer.onFailure = { _ in
                        result = true
                    }
                    let task = Task(webService: webService, dataTaskComponents: dataTaskComponents, observers: [observer])
                    task.executeJSONTask(forType: MockCodeable.self)
                    expect(result).toEventually(beTrue())
                }

                it("does not send succeed to observers") {
                    var result = false
                    observer.onSuccess = { _ in
                        result = true
                    }
                    let task = Task(webService: webService, dataTaskComponents: dataTaskComponents, observers: [observer])
                    task.executeJSONTask(forType: MockCodeable.self)
                    expect(result).toNotEventually(beTrue())
                }

                it("sends didFinish to observers") {
                    var result = false
                    observer.onFinish = {
                        result = true
                    }
                    let task = Task(webService: webService, dataTaskComponents: dataTaskComponents, observers: [observer])
                    task.executeJSONTask(forType: MockCodeable.self)
                    expect(result).toEventually(beTrue())
                }
            }

            context("status code is valid") {
                context("data is valid") {
                    beforeEach {
                        let value = MockCodeable(value: 100)
                        let data = try! JSONEncoder().encode(value)
                        webService.remoteResource = RemoteResource(statusCode: 200, data: data, error: nil)
                    }

                    it("sends didStart to observers") {
                        var result = false
                        observer.onStart = {
                            result = true
                        }
                        let task = Task(webService: webService, dataTaskComponents: dataTaskComponents, observers: [observer])
                        task.executeJSONTask(forType: MockCodeable.self)
                        expect(result).toEventually(beTrue())
                    }

                    it("does not send didFail to observers") {
                        var result = false
                        observer.onFailure = { _ in
                            result = true
                        }
                        let task = Task(webService: webService, dataTaskComponents: dataTaskComponents, observers: [observer])
                        task.executeJSONTask(forType: MockCodeable.self)
                        expect(result).toNotEventually(beTrue())
                    }

                    it("sends succeed to observers") {
                        var result = false
                        observer.onSuccess = { object in
                            if object.value == 100 {
                                result = true
                            }
                        }
                        let task = Task(webService: webService, dataTaskComponents: dataTaskComponents, observers: [observer])
                        task.executeJSONTask(forType: MockCodeable.self)
                        expect(result).toEventually(beTrue())
                    }

                    it("sends didFinish to observers") {
                        var result = false
                        observer.onFinish = {
                            result = true
                        }
                        let task = Task(webService: webService, dataTaskComponents: dataTaskComponents, observers: [observer])
                        task.executeJSONTask(forType: MockCodeable.self)
                        expect(result).toEventually(beTrue())
                    }
                }

                context("data is invalid") {
                    beforeEach {
                        webService.remoteResource = RemoteResource(statusCode: 200, data: Data(), error: nil)
                    }

                    it("sends didStart to observers") {
                        var result = false
                        observer.onStart = {
                            result = true
                        }
                        let task = Task(webService: webService, dataTaskComponents: dataTaskComponents, observers: [observer])
                        task.executeJSONTask(forType: MockCodeable.self)
                        expect(result).toEventually(beTrue())
                    }

                    it("sends didFail to observers") {
                        var result = false
                        observer.onFailure = { _ in
                            result = true
                        }
                        let task = Task(webService: webService, dataTaskComponents: dataTaskComponents, observers: [observer])
                        task.executeJSONTask(forType: MockCodeable.self)
                        expect(result).toEventually(beTrue())
                    }

                    it("does not send succeed to observers") {
                        var result = false
                        observer.onSuccess = { _ in
                            result = true
                        }
                        let task = Task(webService: webService, dataTaskComponents: dataTaskComponents, observers: [observer])
                        task.executeJSONTask(forType: MockCodeable.self)
                        expect(result).toNotEventually(beTrue())
                    }

                    it("sends didFinish to observers") {
                        var result = false
                        observer.onFinish = {
                            result = true
                        }
                        let task = Task(webService: webService, dataTaskComponents: dataTaskComponents, observers: [observer])
                        task.executeJSONTask(forType: MockCodeable.self)
                        expect(result).toEventually(beTrue())
                    }
                }
            }
        }
    }
}

fileprivate struct MockCodeable: Codable {
    let value: Int
}

fileprivate class MockURLSessionTask: URLSessionTaskProtocol {
    let task: () -> ()

    init(execute: @escaping () -> ()) {
        task = execute
    }

    func resume() {
        task()
    }
}

fileprivate class MockWebService: WebServiceProtocol {
    var remoteResource = RemoteResource()

    func dataTask(dataTaskComponents: DataTaskComponents, completion: @escaping (RemoteResource) -> ()) -> URLSessionTaskProtocol {
        return MockURLSessionTask {
            completion(self.remoteResource)
        }
    }
}
