import Quick
import Nimble
import Domain
@testable import RemoteService

class SecuritiesServiceTests: QuickSpec {
    override func spec() {
        describe("SecuritiesService") {
            var webService: MockWebService!
            var securitiesService: SecuritiesService!

            beforeEach {
                webService = MockWebService()
                securitiesService = SecuritiesService()
                securitiesService.webService = webService
            }

            it("executes a command for digital currencies") {
                let observer = ServiceObserver<[Currency]>()
                let command = securitiesService.getTickers(forCurrencySymbols: [""], observers: [observer])
                command.execute()
                expect(webService.didExecutetask).toEventually(beTrue())
            }
        }
    }
}

fileprivate class MockURLSessionTask: URLSessionTaskProtocol {
    func resume() { }
}

fileprivate class MockWebService: WebServiceProtocol {
    var didExecutetask = false
    func dataTask(dataTaskComponents: DataTaskComponents, completion: @escaping (RemoteResource) -> ()) -> URLSessionTaskProtocol {
        didExecutetask = true
        return MockURLSessionTask()
    }
}
