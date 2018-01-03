import Domain
import UIKit

protocol CurrencyListInteractorInputProtocol: class {
    func getCurrencies()
}

protocol CurrencyListInteractorOutputProtocol: class {
    func didGet(currencies: [Currency])
    func getCurrenciesDidFail()
}

class CurrencyListInteractor {
    weak var listener: CurrencyListInteractorOutputProtocol?
    var localDataManager: CurrencyListLocalDataManagerInputProtocol?
    var remoteDataManager: CurrencyListRemoteDataManagerInputProtocol?
}

extension CurrencyListInteractor: CurrencyListInteractorInputProtocol {
    func getCurrencies() {
        localDataManager?.getCurrencies()
    }
}

extension CurrencyListInteractor: CurrencyListLocalDataManagerOutputProtocol {
    func didGet(currencySymbols: [CurrencySymbol]) {
        remoteDataManager?.getCurrencyList(forCurrencySymbols: currencySymbols.map { $0.symbol })
    }
}

extension CurrencyListInteractor: CurrencyListRemoteDataManagerOutputProtocol {
    func getCurrenciesDidFail() {
        listener?.getCurrenciesDidFail()
    }

    func didGet(currencies: [Currency]) {
        listener?.didGet(currencies: currencies)
    }
}
