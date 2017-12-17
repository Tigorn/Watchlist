import Domain
import LocalService
import UIKit

protocol CurrencyListBuilderProtocol {
    func makeModule() -> UIViewController
}

class CurrencyListBuilder: CurrencyListBuilderProtocol {
    func makeModule() -> UIViewController {
        guard let viewController = UIStoryboard.list.instantiateViewController(withIdentifier: .currencyListViewController) as? CurrencyListViewController else {
            fatalError("Could not instantiate view controller with identifier: \(UIViewControllerIdentifier.currencyEditViewController.rawValue)")
        }

        let localDataManager = CurrencyListLocalDataManager()
        let remoteDataManager = CurrencyListRemoteDataManager()
        let interactor = CurrencyListInteractor()
        let presenter = CurrencyListPresenter()
        let dataSource = CurrencyListDataSource()

        viewController.listener = presenter
        viewController.dataSource = dataSource

        localDataManager.listener = interactor
        localDataManager.localService = LocalPersistenceService.instance

        remoteDataManager.listener = interactor
        remoteDataManager.remoteService = SecuritiesService()

        interactor.listener = presenter
        interactor.localDataManager = localDataManager
        interactor.remoteDataManager = remoteDataManager

        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = CurrencyListRouter()

        return viewController
    }
}
