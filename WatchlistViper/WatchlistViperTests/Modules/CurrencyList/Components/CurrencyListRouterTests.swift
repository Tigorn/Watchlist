import Quick
import Nimble
import Domain
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

fileprivate class MockView: UIViewController {
    var didShow = false
    
    override func show(_ vc: UIViewController, sender: Any?) {
        didShow = true
    }
}
