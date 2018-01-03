import Domain
import UIKit

protocol CurrencyListLocalDataManagerInputProtocol: class {
    func getCurrencies()
}

protocol CurrencyListLocalDataManagerOutputProtocol: class {
    func didGet(currencySymbols: [CurrencySymbol])
}

class CurrencyListLocalDataManager {
    weak var listener: CurrencyListLocalDataManagerOutputProtocol?
    var localService: LocalPersistenceServiceProtocol?
}

extension CurrencyListLocalDataManager: CurrencyListLocalDataManagerInputProtocol {
    func getCurrencies() {
        localService?.getSortedCurrencySymbols { [weak self] symbols in
            self?.listener?.didGet(currencySymbols: symbols)
        }
    }
}
