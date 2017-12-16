import UIKit

class BootstrapRouter: BootstrapRouterProtocol {
    static func createBootstrapModule(in view: BootstrapViewProtocol) -> BootstrapPresenterProtocol {
        let presenter = BootstrapPresenter()
        let interactor = BootstrapInteractor()
        let localDataManager = BootstrapLocalDataManager()

        presenter.interactor = interactor
        presenter.router = BootstrapRouter()
        presenter.view = view
        interactor.presenter = presenter
        interactor.localInputDataManager = localDataManager
        localDataManager.outputEventHandler = interactor
        return presenter
    }

    func rootViewController() -> UIViewController {
        let tabBarController = UITabBarController()
        let currencyListViewController = UINavigationController(rootViewController: CurrencyListBuilder().makeModule())
        tabBarController.viewControllers = [currencyListViewController]
        return tabBarController
    }
}
