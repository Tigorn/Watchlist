import UIKit

protocol BootstrapViewProtocol: class {
    var presenter: BootstrapPresenterProtocol? { get set }
    
    func set(window: UIWindow)
}

protocol BootstrapPresenterProtocol: class {
    var view: BootstrapViewProtocol? { get set }
    var interactor: BootstrapInteractorInputProtocol? { get set }
    var router: BootstrapRouterProtocol? { get set }
    
    func bootstrap()
}

protocol BootstrapInteractorInputProtocol: class {
    var presenter: BootstrapInteractorOutputProtocol? { get set }
    var localInputDataManager: BootstrapLocalDataManagerInputProtocol? { get set }

    func bootstrap()
}

protocol BootstrapInteractorOutputProtocol: class {
    func didFinishBootstrap()
}

protocol BootstrapLocalDataManagerInputProtocol: class {
    var outputEventHandler: BootstrapLocalDataManagerOutputProtocol? { get set }

    func setDidSetDefaultCurrencies(value: Bool)
    func getDidSetDefaultCurrencies() -> Bool
    func getDefaultCurrencies() -> [String]
    func put(currencySymbol symbol: String)
    func initialize()
}

protocol BootstrapLocalDataManagerOutputProtocol {
    func didInitialize()
}

protocol BootstrapRouterProtocol: class {
    static func createBootstrapModule(in view: BootstrapViewProtocol) -> BootstrapPresenterProtocol
    func rootViewController() -> UIViewController
}
