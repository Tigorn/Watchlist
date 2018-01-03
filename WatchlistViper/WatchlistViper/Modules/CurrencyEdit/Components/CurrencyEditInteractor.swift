import Domain
import Foundation

protocol CurrencyEditInteractorInputProtocol: class {
    func getCurrencies()
}

protocol CurrencyEditInteractorOutputProtocol: class {
    func didGet(currencySymbols: [CurrencySymbol])
}

class CurrencyEditInteractor {
    weak var listener: CurrencyEditInteractorOutputProtocol?
    var localDataManager: CurrencyEditLocalDataManagerInputProtocol?
}

extension CurrencyEditInteractor: CurrencyEditInteractorInputProtocol {
    func getCurrencies() {
        localDataManager?.getCurrencies()
    }
}

extension CurrencyEditInteractor: CurrencyEditLocalDataManagerOutputProtocol {
    func didGet(currencySymbols: [CurrencySymbol]) {
        listener?.didGet(currencySymbols: currencySymbols)
    }
}
