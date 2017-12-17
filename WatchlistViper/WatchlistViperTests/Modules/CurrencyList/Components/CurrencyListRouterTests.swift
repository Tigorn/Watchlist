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
                router.showEdit(from: viewController)
                expect(viewController.didShow).to(beTrue())
            }
        }
    }
}

private class MockView: UIViewController {
    var didShow = false

    // swiftlint:disable:next identifier_name
    override func show(_: UIViewController, sender _: Any?) {
        didShow = true
    }
}
