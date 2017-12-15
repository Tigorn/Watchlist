import UIKit

class CurrencyEditRouter: CurrencyEditRouterProtocol {
    static func makeModule() -> UIViewController {
        let viewController = UIStoryboard.edit.instantiateViewController(withIdentifier: .currencyEditViewController) as! CurrencyEditViewController
        let presenter = CurrencyEditPresenter()
        let interactor = CurrencyEditInteractor()
        let localDataManager = CurrencyEditLocalDataManager()

        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.view = viewController
        interactor.presenter = presenter
        interactor.localInputDataManager = localDataManager
        localDataManager.outputEventHandler = interactor
        
        return viewController
    }
}
