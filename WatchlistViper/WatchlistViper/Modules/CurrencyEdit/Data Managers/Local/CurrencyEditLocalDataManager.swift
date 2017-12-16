import Foundation
import Domain

protocol CurrencyEditLocalDataManagerInputProtocol: class {
    func getCurrencies()
}

protocol CurrencyEditLocalDataManagerOutputProtocol: class {
    func didGet(currencySymbols: [String])
}

class CurrencyEditLocalDataManager {
    weak var listener: CurrencyEditLocalDataManagerOutputProtocol?
    var localService: LocalPersistenceServiceProtocol?
}

extension CurrencyEditLocalDataManager: CurrencyEditLocalDataManagerInputProtocol {
    func getCurrencies() {
        localService?.getCurrencySymbols { [weak self] currencySymbols in
            self?.listener?.didGet(currencySymbols: currencySymbols)
        }
    }
}
