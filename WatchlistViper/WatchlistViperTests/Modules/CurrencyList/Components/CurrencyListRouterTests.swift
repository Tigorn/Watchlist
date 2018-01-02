import Domain
import Nimble
import Quick
@testable import WatchlistViper

class CurrencyListRouterTests: QuickSpec {
    override func spec() {
        var router: CurrencyListRouter!

        beforeEach {
            router = CurrencyListRouter()
        }

        describe("CurrencyListRouter") {
            it("shows edit") {
                let viewController = MockView()
                router.routeToEdit(from: viewController)
                expect(viewController.didShow).to(beTrue())
            }
        }
    }
}

private class MockView: UIViewController {
    var didShow = false

    override func show(_: UIViewController, sender _: Any?) {
        didShow = true
    }
}
