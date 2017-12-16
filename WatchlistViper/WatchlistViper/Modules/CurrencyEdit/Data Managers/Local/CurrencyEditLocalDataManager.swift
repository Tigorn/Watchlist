import Foundation
import Domain

class CurrencyEditLocalDataManager {
    var outputEventHandler: CurrencyEditLocalDataManagerOutputProtocol?
    var localPersistenceService: LocalPersistenceServiceProtocol? = LocalPersistenceService.instance
}

extension CurrencyEditLocalDataManager: CurrencyEditLocalDataManagerInputProtocol {
    func getCurrencies() {
        localPersistenceService?.getCurrencySymbols { [weak self] currencySymbols in
            self?.outputEventHandler?.didGet(currencySymbols: currencySymbols)
        }
    }
}
