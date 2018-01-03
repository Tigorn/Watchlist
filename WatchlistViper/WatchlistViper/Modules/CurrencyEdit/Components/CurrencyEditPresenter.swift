import Domain
import UIKit
import UIComponents

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
    func didGet(currencySymbols: [CurrencySymbol]) {
        DispatchQueue.main.async {
            let data = CurrencyEditListData(currencySymbols: currencySymbols)
            self.view?.set(data: data)
        }
    }
}
