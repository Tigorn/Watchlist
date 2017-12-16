import UIKit
import LocalService
import Domain

protocol CurrencyListBuilderProtocol {
    func makeModule() -> UIViewController
}

class CurrencyListBuilder: CurrencyListBuilderProtocol {
    func makeModule() -> UIViewController {
        let viewController = UIStoryboard.list.instantiateViewController(withIdentifier: .currencyListViewController) as! CurrencyListViewController
        let localDataManager = CurrencyListLocalDataManager()
        let remoteDataManager = CurrencyListRemoteDataManager()
        let interactor = CurrencyListInteractor()
        let presenter = CurrencyListPresenter()
        let dataSource = CurrencyListDataSource()

        viewController.presenter = presenter
        viewController.dataSource = dataSource

        localDataManager.listener = interactor
        localDataManager.localPersistenceService = LocalPersistenceService.instance

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
