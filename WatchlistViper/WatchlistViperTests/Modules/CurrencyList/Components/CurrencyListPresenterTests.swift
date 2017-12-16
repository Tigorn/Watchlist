import Quick
import Nimble
import Domain
@testable import WatchlistViper

class CurrencyListPresenterTests: QuickSpec {
    override func spec() {
        var presenter: CurrencyListPresenter!
        var view: MockView!
        var router: MockRouter!
        var interactor: MockInteractor!

        beforeEach {
            presenter = CurrencyListPresenter()
            view = MockView()
            router = MockRouter()
            interactor = MockInteractor()

            presenter.router = router
            presenter.view = view
            presenter.interactor = interactor
        }

        describe("CurrencyListPresenter") {
            it("gets ticker list from remote service") {
                presenter.didGet(currencies: [])
                expect(view.didShowCurrencies).toEventually(beTrue())
            }

            it("gets currencies") {
                presenter.getCurrencies()
                expect(interactor.didGetCurrencies).to(beTrue())
            }

            it("updates view when get currencies fails") {
                presenter.getCurrenciesDidFail()
                expect(view.didFailRequest).toEventually(beTrue())
            }

            it("routes edit action to router") {
                presenter.didEditAction()
                expect(router.didRouteToEdit).toEventually(beTrue())
            }
        }
    }
}

fileprivate class MockRouter: CurrencyListRouterProtocol {
    var didRouteToEdit = false
    static func makeModule() -> UIViewController {
        return UIViewController()
    }

    func showEdit(from view: UIViewController) {
        didRouteToEdit = true
    }
}

fileprivate class MockInteractor: CurrencyListInteractorInputProtocol {
    var didGetCurrencies = false

    func getCurrencies() {
        didGetCurrencies = true
    }
}

fileprivate class MockView: UIViewController, CurrencyListViewInputProtocol {
    var didShowCurrencies = false
    var didFailRequest = true
    
    func show(currencies: [Currency]) {
        didShowCurrencies = true
    }

    func requestFailed() {
        didFailRequest = true
    }
}
