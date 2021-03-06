import Domain
import PromiseKit
import UIKit

protocol CurrencyListRemoteDataManagerInputProtocol: class {
    func getCurrencyList(forCurrencySymbols symbols: [String])
}

protocol CurrencyListRemoteDataManagerOutputProtocol: class {
    func didGet(currencies: [Currency])
    func getCurrenciesDidFail()
}

class CurrencyListRemoteDataManager {
    weak var listener: CurrencyListRemoteDataManagerOutputProtocol?
    var remoteService: SecuritiesServiceProtocol?
}

extension CurrencyListRemoteDataManager: CurrencyListRemoteDataManagerInputProtocol {
    func getCurrencyList(forCurrencySymbols symbols: [String]) {
        guard let remoteService = remoteService else {
            return
        }

        firstly {
            remoteService.getTickers(forCurrencySymbols: symbols)
        }.then { [weak self] currencies -> Void in
            self?.listener?.didGet(currencies: currencies)
        }.catch { [weak self] _ in
            self?.listener?.getCurrenciesDidFail()
        }
    }
}
