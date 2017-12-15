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
            it("returns a CurrencyListViewController on create") {
                expect(CurrencyListRouter.makeModule()).to(beAKindOf(CurrencyListViewController.self))
            }

            it("builds on create") {
                let viewController = CurrencyListRouter.makeModule() as! CurrencyListViewController
                let presenter = viewController.presenter
                let interactor = viewController.presenter?.interactor

                expect(presenter?.view === viewController).to(beTrue())
                expect(presenter?.router).toNot(beNil())
                expect(interactor?.presenter === presenter).to(beTrue())
                expect(interactor?.localInputDataManager?.outputEventHandler).toNot(beNil())
                expect(interactor?.remoteInputDataManager?.outputEventHandler).toNot(beNil())
            }

            it("shows edit") {
                let viewController = MockView()
                router.showEdit(from: viewController)
                expect(viewController.didShow).to(beTrue())
            }
        }
    }
}

fileprivate class MockView: UIViewController, CurrencyListViewProtocol {
    var didShow = false
    var presenter: CurrencyListPresenterProtocol?
    func show(currencies: [Currency]) { }
    func requestFailed() { }

    override func show(_ vc: UIViewController, sender: Any?) {
        didShow = true
    }
}
