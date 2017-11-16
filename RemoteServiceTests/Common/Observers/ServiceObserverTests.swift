import Quick
import Nimble
@testable import RemoteService

class ServiceObserverTests: QuickSpec {
    override func spec() {
        describe("ServiceObserver") {
            var observer: ServiceObserver<Int>!

            beforeEach {
                observer = ServiceObserver()
            }

            it("executes on didStart") {
                var value = false
                observer.onStart = {
                    value = true
                }
                observer.didStart()
                expect(value).toEventually(beTrue())
            }

            it("executes on didFail") {
                var value = false
                let error = TaskError.parsingFailed
                observer.onFailure = { errors in
                    if errors.first is TaskError {
                        value = true
                    }
                }
                observer.didFail(errors: [error])
                expect(value).toEventually(beTrue())
            }

            it("executes on didSucceed") {
                var value = false
                let result = 100
                observer.onSuccess = { object in
                    if result == object {
                        value = true
                    }
                }
                observer.didSucceed(value: result)
                expect(value).toEventually(beTrue())
            }

            it("executes on didFinish") {
                var value = false
                observer.onFinish = {
                    value = true
                }
                observer.didFinish()
                expect(value).toEventually(beTrue())
            }
        }
    }
}
