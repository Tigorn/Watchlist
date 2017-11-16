import UIKit
import Domain

class CurrencyListPresenter {
    weak var view: CurrencyListViewProtocol?
    var interactor: CurrencyListInteractorInputProtocol?
    var router: CurrencyListRouterProtocol?
}

extension CurrencyListPresenter: CurrencyListPresenterProtocol {
    func getCurrencies() {
        interactor?.getCurrencies()
    }
}

extension CurrencyListPresenter: CurrencyListInteractorOutputProtocol {
    func getCurrenciesDidFail() {
        self.view?.requestFailed()
    }

    func didGet(currencies: [Currency]) {
        DispatchQueue.main.async {
            self.view?.show(currencies: currencies)
        }
    }
}
