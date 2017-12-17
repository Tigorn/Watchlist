import Quick
import Nimble
import PromiseKit
import RemoteService
@testable import Domain

class SecuritiesServiceTests: QuickSpec {
    override func spec() {
        describe("SecuritiesService") {
            var securitiesService: SecuritiesService!
            var task: MockTask!

            beforeEach {
                securitiesService = SecuritiesService()
                task = MockTask()
                securitiesService.task = task
            }

            it("configures promise for tickers") {
                let queryItem = URLQueryItem(name: "symbols", value: "abc,def")
                let dataTaskComponents = DataTaskComponents(route: Route.tickers, queryItems: [queryItem])
                task.expectedDataTaskComponents = dataTaskComponents
                _  = securitiesService.getTickers(forCurrencySymbols: ["abc", "def"])
                expect(task.didConfigurePromise).to(beTrue())
            }
        }
    }
}

private class MockTask: TaskProtocol {
    var expectedDataTaskComponents: DataTaskComponents!
    var didConfigurePromise = false

    func decodableTaskPromise<Type>(dataTaskComponents: DataTaskComponents, forType type: Type.Type) -> Promise<Type> where Type: Decodable {
        if dataTaskComponents == expectedDataTaskComponents {
            didConfigurePromise = true
        }

        return Promise<Type> { _, reject in
            reject(DataServiceError.cancelled)
        }
    }
}
