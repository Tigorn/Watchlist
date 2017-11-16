import UIKit
import LocalService

class CurrencyListLocalDataManager {
    var outputEventHandler: CurrencyListLocalDataManagerOutputProtocol?
    var localPersistenceService: LocalPersistenceServiceProtocol? = LocalPersistenceService.instance
}

extension CurrencyListLocalDataManager: CurrencyListLocalDataManagerInputProtocol {
    func getCurrencies() {
        localPersistenceService?.getCurrencySymbols { [weak self] symbols in
            self?.outputEventHandler?.didGet(currencySymbols: symbols)
        }
    }
}
