import UIKit

class CurrencyEditPresenter {
    weak var view: CurrencyEditViewProtocol?
    var interactor: CurrencyEditInteractorInputProtocol?
}

extension CurrencyEditPresenter: CurrencyEditPresenterProtocol {
    func getCurrencies() {
        interactor?.getCurrencies()
    }
}

extension CurrencyEditPresenter: CurrencyEditInteractorOutputProtocol {
    func didGet(currencySymbols: [String]) {
        DispatchQueue.main.async {
            self.view?.set(currencySymbols: currencySymbols)
        }
    }
}
