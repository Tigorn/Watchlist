import Domain
import UIKit

protocol BootstrapBuilderProtocol: class {
    func makeRootViewController() -> UIViewController
    func makeLoadingViewController() -> UIViewController
    func makeBootstrapModule() -> BootstrapViewOutputProtocol
}

class BootstrapBuilder: BootstrapBuilderProtocol {
    func makeLoadingViewController() -> UIViewController {
        return UIStoryboard.bootstrap.instantiateViewController(withIdentifier: .loadingViewController)
    }

    func makeRootViewController() -> UIViewController {
        let tabBarController = UITabBarController()
        let currencyListViewController = UINavigationController(rootViewController: CurrencyListBuilder().makeModule())
        tabBarController.viewControllers = [currencyListViewController]
        return tabBarController
    }

    func makeBootstrapModule() -> BootstrapViewOutputProtocol {
        let presenter = BootstrapPresenter()
        let interactor = BootstrapInteractor()
        let localDataManager = BootstrapLocalDataManager()
        let router = BootstrapRouter()

        router.builder = BootstrapBuilder()

        presenter.interactor = interactor
        presenter.router = router

        interactor.listener = presenter
        interactor.localDataManager = localDataManager

        localDataManager.listener = interactor
        localDataManager.localDefaultsService = LocalDefaultsService()
        localDataManager.localPersistenceService = LocalPersistenceService.instance
        localDataManager.localFileService = LocalFileService()

        return presenter
    }
}
