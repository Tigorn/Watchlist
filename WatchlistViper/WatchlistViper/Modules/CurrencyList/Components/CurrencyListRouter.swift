import UIKit

class CurrencyListRouter: CurrencyListRouterProtocol {
    static func createCurrencyListModule() -> UIViewController {
        let viewController = UIStoryboard.list.instantiateViewController(withIdentifier: .currencyListViewController) as! CurrencyListViewController
        let localDataManager = CurrencyListLocalDataManager()
        let remoteDataManager = CurrencyListRemoteDataManager()
        let interactor = CurrencyListInteractor()
        let presenter = CurrencyListPresenter()

        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = CurrencyListRouter()
        interactor.presenter = presenter
        interactor.localInputDataManager = localDataManager
        interactor.remoteInputDataManager = remoteDataManager
        remoteDataManager.outputEventHandler = interactor
        localDataManager.outputEventHandler = interactor
        
        return viewController
    }
}
