import Foundation

class CurrencyEditInteractor {
    weak var presenter: CurrencyEditInteractorOutputProtocol?
    var localInputDataManager: CurrencyEditLocalDataManagerInputProtocol?
}

extension CurrencyEditInteractor: CurrencyEditInteractorInputProtocol {
    func getCurrencies() {
        localInputDataManager?.getCurrencies()
    }
}

extension CurrencyEditInteractor: CurrencyEditLocalDataManagerOutputProtocol {
    func didGet(currencySymbols: [String]) {
        presenter?.didGet(currencySymbols: currencySymbols)
    }
}
