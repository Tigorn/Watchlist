import Foundation
import Domain

protocol BootstrapLocalDataManagerInputProtocol: class {
    func setDidSetDefaultCurrencies(value: Bool)
    func getDidSetDefaultCurrencies() -> Bool
    func getDefaultCurrencies() -> [CurrencySymbol]
    func put(currencySymbol: CurrencySymbol)
    func initialize()
}

protocol BootstrapLocalDataManagerOutputProtocol: class {
    func didInitialize()
}

class BootstrapLocalDataManager {
    weak var listener: BootstrapLocalDataManagerOutputProtocol?
    var localDefaultsService: LocalDefaultsServiceProtocol?
    var localPersistenceService: LocalPersistenceServiceProtocol?
    var localFileService: LocalFileServiceProtocol?
}

extension BootstrapLocalDataManager: BootstrapLocalDataManagerInputProtocol {
    func setDidSetDefaultCurrencies(value: Bool) {
        localDefaultsService?.didSetDefaultCurrencies = value
    }

    func initialize() {
        localPersistenceService?.initialize { [weak self] in
            self?.listener?.didInitialize()
        }
    }

    func getDidSetDefaultCurrencies() -> Bool {
        return localDefaultsService?.didSetDefaultCurrencies ?? false
    }

    func getDefaultCurrencies() -> [CurrencySymbol] {
        return localFileService?.defaultCurrencySymbols() ?? []
    }

    func put(currencySymbol: CurrencySymbol) {
        localPersistenceService?.put(currencySymbol: currencySymbol)
    }
}
