import UIKit
import Domain
import LocalService

protocol CurrencyListViewProtocol: class {
    var presenter: CurrencyListPresenterProtocol? { get set }

    func show(currencies: [Currency])
    func requestFailed()
}

protocol CurrencyListRouterProtocol: class {
    static func makeModule() -> UIViewController
    func showEdit(from view: CurrencyListViewProtocol)
}

protocol CurrencyListPresenterProtocol: class {
    var view: CurrencyListViewProtocol? { get set }
    var interactor: CurrencyListInteractorInputProtocol? { get set }
    var router: CurrencyListRouterProtocol? { get set }

    func getCurrencies()
    func didEditAction()
}

protocol CurrencyListInteractorInputProtocol: class {
    var presenter: CurrencyListInteractorOutputProtocol? { get set }
    var localInputDataManager: CurrencyListLocalDataManagerInputProtocol? { get set }
    var remoteInputDataManager: CurrencyListRemoteDataManagerInputProtocol? { get set }

    func getCurrencies()
}

protocol CurrencyListInteractorOutputProtocol: class {
    func didGet(currencies: [Currency])
    func getCurrenciesDidFail()
}

protocol CurrencyListRemoteDataManagerInputProtocol: class {
    var outputEventHandler: CurrencyListRemoteDataManagerOutputProtocol? { get set }

    func getCurrencyList(forCurrencySymbols symbols: [String]) 
}

protocol CurrencyListRemoteDataManagerOutputProtocol: class {
    func didGet(currencies: [Currency])
    func getCurrenciesDidFail()
}

protocol CurrencyListLocalDataManagerInputProtocol: class {
    var outputEventHandler: CurrencyListLocalDataManagerOutputProtocol? { get set }

    func getCurrencies()
}

protocol CurrencyListLocalDataManagerOutputProtocol: class {
    func didGet(currencySymbols: [String])
}

protocol CurrencyListDataSourceProtocol: class {
    func set(currencies: [Currency])
}
