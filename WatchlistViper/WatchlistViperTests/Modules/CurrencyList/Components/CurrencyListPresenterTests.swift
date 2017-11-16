import Quick
import Nimble
import Domain
@testable import WatchlistViper

class CurrencyListPresenterTests: QuickSpec {
    override func spec() {
        var presenter: CurrencyListPresenter!

        beforeEach {
            presenter = CurrencyListPresenter()
        }

        describe("CurrencyListPresenter") {
            it("gets ticker list from remote service") {
                let view = MockView()
                presenter.view = view
                presenter.didGet(currencies: [])
                expect(view.didShowCurrencies).toEventually(beTrue())
            }

            it("gets currencies") {
                let interactor = MockInteractor()
                presenter.interactor = interactor
                presenter.getCurrencies()
                expect(interactor.didGetCurrencies).to(beTrue())
            }

            it("updates view when get currencies fails") {
                let view = MockView()
                presenter.view = view
                presenter.getCurrenciesDidFail()
                expect(view.didFailRequest).toEventually(beTrue())
            }
        }
    }
}

fileprivate class MockInteractor: CurrencyListInteractorInputProtocol {
    var presenter: CurrencyListInteractorOutputProtocol?
    var localInputDataManager: CurrencyListLocalDataManagerInputProtocol?
    var remoteInputDataManager: CurrencyListRemoteDataManagerInputProtocol?
    var didGetCurrencies = false

    func getCurrencies() {
        didGetCurrencies = true
    }
}

fileprivate class MockView: CurrencyListViewProtocol {
    var presenter: CurrencyListPresenterProtocol?
    var didShowCurrencies = false
    var didFailRequest = true
    
    func show(currencies: [Currency]) {
        didShowCurrencies = true
    }

    func requestFailed() {
        didFailRequest = true
    }
}
