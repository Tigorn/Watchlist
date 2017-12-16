import UIKit
import LocalService

protocol CurrencyListLocalDataManagerInputProtocol: class {
    func getCurrencies()
}

protocol CurrencyListLocalDataManagerOutputProtocol: class {
    func didGet(currencySymbols: [String])
}

class CurrencyListLocalDataManager {
    var listener: CurrencyListLocalDataManagerOutputProtocol?
    var localPersistenceService: LocalPersistenceServiceProtocol?
}

extension CurrencyListLocalDataManager: CurrencyListLocalDataManagerInputProtocol {
    func getCurrencies() {
        localPersistenceService?.getCurrencySymbols { [weak self] symbols in
            self?.listener?.didGet(currencySymbols: symbols)
        }
    }
}
