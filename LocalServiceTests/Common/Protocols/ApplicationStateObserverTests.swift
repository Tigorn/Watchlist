import CoreData
@testable import LocalService
import Nimble
import Quick

class ApplicationStateObserverTests: QuickSpec {
    override func spec() {
        describe("ApplicationStateObserver") {
            var observer: MockApplicationStateObserver!

            beforeEach {
                observer = MockApplicationStateObserver()
            }

            context("didStart observing") {
                beforeEach {
                    observer.startObservingApplicationState()
                }

                it("observes didBecomeActive") {
                    NotificationCenter.default.post(name: .UIApplicationDidBecomeActive, object: nil)
                    expect(observer.didBecomeActive).toEventually(beTrue())
                }

                it("observes didEnterBackground") {
                    NotificationCenter.default.post(name: .UIApplicationDidEnterBackground, object: nil)
                    expect(observer.didEnterBackground).toEventually(beTrue())
                }
            }

            context("didStop observing") {
                beforeEach {
                    observer.stopObservingApplicationState()
                }

                it("does not observe didBecomeActive") {
                    NotificationCenter.default.post(name: .UIApplicationDidBecomeActive, object: nil)
                    expect(observer.didBecomeActive).toNotEventually(beTrue())
                }

                it("does not observe didEnterBackground") {
                    NotificationCenter.default.post(name: .UIApplicationDidEnterBackground, object: nil)
                    expect(observer.didEnterBackground).toNotEventually(beTrue())
                }
            }
        }
    }
}

private class MockApplicationStateObserver: ApplicationStateObserver {
    var didBecomeActive = false
    var didEnterBackground = false

    func applicationDidBecomeActive() {
        didBecomeActive = true
    }

    func applicationDidEnterBackground() {
        didEnterBackground = true
    }
}
