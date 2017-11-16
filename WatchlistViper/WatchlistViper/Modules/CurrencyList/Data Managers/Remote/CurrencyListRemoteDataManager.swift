import UIKit
import RemoteService

class CurrencyListRemoteDataManager {
    var outputEventHandler: CurrencyListRemoteDataManagerOutputProtocol?
    var remoteService: SecuritiesServiceProtocol = SecuritiesService()
}

extension CurrencyListRemoteDataManager: CurrencyListRemoteDataManagerInputProtocol {
    func getCurrencyList(forCurrencySymbols symbols: [String]) {
        let observer = ServiceObserver(
        onSuccess: { [weak self] currencies in
            self?.outputEventHandler?.didGet(currencies: currencies)},
        onFailure: { [weak self] _ in
            self?.outputEventHandler?.getCurrenciesDidFail()
        })
        
        remoteService.getTickers(forCurrencySymbols: symbols, observers: [observer]).execute()
    }
}
