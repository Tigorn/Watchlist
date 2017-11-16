import UIKit
import Domain

class CurrencyListInteractor {
    weak var presenter: CurrencyListInteractorOutputProtocol?
    var localInputDataManager: CurrencyListLocalDataManagerInputProtocol?
    var remoteInputDataManager: CurrencyListRemoteDataManagerInputProtocol?
}

extension CurrencyListInteractor: CurrencyListInteractorInputProtocol {
    func getCurrencies() {
        localInputDataManager?.getCurrencies()
    }
}

extension CurrencyListInteractor: CurrencyListLocalDataManagerOutputProtocol {
    func didGet(currencySymbols: [String]) {
        remoteInputDataManager?.getCurrencyList(forCurrencySymbols: currencySymbols)
    }
}

extension CurrencyListInteractor: CurrencyListRemoteDataManagerOutputProtocol {
    func getCurrenciesDidFail() {
        presenter?.getCurrenciesDidFail()
    }

    func didGet(currencies: [Currency]) {
        presenter?.didGet(currencies: currencies)
    }
}
