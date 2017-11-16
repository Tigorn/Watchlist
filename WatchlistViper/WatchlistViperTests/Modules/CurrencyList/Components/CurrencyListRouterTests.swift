import Quick
import Nimble
@testable import WatchlistViper

class CurrencyListRouterTests: QuickSpec {
    override func spec() {
        describe("CurrencyListRouter") {
            it("returns a CurrencyListViewController on create") {
                expect(CurrencyListRouter.createCurrencyListModule()).to(beAKindOf(CurrencyListViewController.self))
            }

            it("builds on create") {
                let viewController = CurrencyListRouter.createCurrencyListModule() as! CurrencyListViewController
                let presenter = viewController.presenter
                let interactor = viewController.presenter?.interactor

                expect(presenter?.view === viewController).to(beTrue())
                expect(presenter?.router).toNot(beNil())
                expect(interactor?.presenter === presenter).to(beTrue())
                expect(interactor?.localInputDataManager?.outputEventHandler).toNot(beNil())
                expect(interactor?.remoteInputDataManager?.outputEventHandler).toNot(beNil())
            }
        }
    }
}
