import Foundation
import LocalService

class BootstrapLocalDataManager {
    var outputEventHandler: BootstrapLocalDataManagerOutputProtocol?
    var localDefaultsService: LocalDefaultsServiceProtocol? = LocalDefaultsService()
    var localPersistenceService: LocalPersistenceServiceProtocol? = LocalPersistenceService.instance
    var localFileService: LocalFileServiceProtocol? = LocalFileService()
}

extension BootstrapLocalDataManager: BootstrapLocalDataManagerInputProtocol {

    func setDidSetDefaultCurrencies(value: Bool) {
        localDefaultsService?.didSetDefaultCurrencies = value
    }

    func initialize() {
        localPersistenceService?.initialize {
            self.outputEventHandler?.didInitialize()
        }
    }

    func getDidSetDefaultCurrencies() -> Bool {
        return localDefaultsService?.didSetDefaultCurrencies ?? false
    }

    func getDefaultCurrencies() -> [String] {
        return localFileService?.defaultCurrencySymbols() ?? []
    }

    func put(currencySymbol symbol: String) {
        localPersistenceService?.put(currencySymbol: symbol)
    }
}
