import UIKit
import Domain

protocol CurrencyListLocalDataManagerInputProtocol: class {
    func getCurrencies()
}

protocol CurrencyListLocalDataManagerOutputProtocol: class {
    func didGet(currencySymbols: [String])
}

class CurrencyListLocalDataManager {
    var listener: CurrencyListLocalDataManagerOutputProtocol?
    var localService: LocalPersistenceServiceProtocol?
}

extension CurrencyListLocalDataManager: CurrencyListLocalDataManagerInputProtocol {
    func getCurrencies() {
        localService?.getCurrencySymbols { [weak self] symbols in
            self?.listener?.didGet(currencySymbols: symbols)
        }
    }
}
