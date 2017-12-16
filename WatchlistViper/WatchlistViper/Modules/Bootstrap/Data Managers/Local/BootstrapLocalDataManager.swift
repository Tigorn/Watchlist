import Foundation
import Domain

protocol BootstrapLocalDataManagerInputProtocol: class {
    func setDidSetDefaultCurrencies(value: Bool)
    func getDidSetDefaultCurrencies() -> Bool
    func getDefaultCurrencies() -> [String]
    func put(currencySymbol symbol: String)
    func initialize()
}

protocol BootstrapLocalDataManagerOutputProtocol {
    func didInitialize()
}

class BootstrapLocalDataManager {
    var listener: BootstrapLocalDataManagerOutputProtocol?
    var localDefaultsService: LocalDefaultsServiceProtocol?
    var localPersistenceService: LocalPersistenceServiceProtocol?
    var localFileService: LocalFileServiceProtocol?
}

extension BootstrapLocalDataManager: BootstrapLocalDataManagerInputProtocol {

    func setDidSetDefaultCurrencies(value: Bool) {
        localDefaultsService?.didSetDefaultCurrencies = value
    }

    func initialize() {
        localPersistenceService?.initialize {
            self.listener?.didInitialize()
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
