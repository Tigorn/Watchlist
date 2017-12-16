import UIKit

class CurrencyEditPresenter {
    weak var view: CurrencyEditViewInputProtocol?
    var interactor: CurrencyEditInteractorInputProtocol?
}

extension CurrencyEditPresenter: CurrencyEditViewOutputProtocol {
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
