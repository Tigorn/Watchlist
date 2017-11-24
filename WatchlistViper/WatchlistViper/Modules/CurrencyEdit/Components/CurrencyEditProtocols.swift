import UIKit

protocol CurrencyEditViewProtocol: class {
    var presenter: CurrencyEditPresenterProtocol? { get set }

    func set(currencySymbols: [String])
}

protocol CurrencyEditRouterProtocol: class {
    static func makeModule() -> UIViewController
}

protocol CurrencyEditPresenterProtocol: class {
    var view: CurrencyEditViewProtocol? { get set }
    var interactor: CurrencyEditInteractorInputProtocol? { get set }

    func getCurrencies()
}

protocol CurrencyEditInteractorInputProtocol: class {
    var presenter: CurrencyEditInteractorOutputProtocol? { get set }
    var localInputDataManager: CurrencyEditLocalDataManagerInputProtocol? { get set }

    func getCurrencies()
}

protocol CurrencyEditInteractorOutputProtocol: class {
    func didGet(currencySymbols: [String])
}

protocol CurrencyEditLocalDataManagerInputProtocol: class {
    var outputEventHandler: CurrencyEditLocalDataManagerOutputProtocol? { get set }
    
    func getCurrencies()
}

protocol CurrencyEditLocalDataManagerOutputProtocol: class {
    func didGet(currencySymbols: [String])
}

protocol CurrencyEditDataSourceInputProtocol: class {
    func set(currencySymbols: [String])
}

protocol CurrencyEditDataSourceOutputProtocol: class {
    func moveRowAt(sourceIndexPath: IndexPath, destinationIndexPath: IndexPath)
    func delete(rowAt indexPath: IndexPath)
}
