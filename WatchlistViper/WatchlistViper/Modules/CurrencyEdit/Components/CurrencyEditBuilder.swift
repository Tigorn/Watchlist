import Domain
import UIKit

protocol CurrencyEditBuilderProtocol: class {
    func makeModule() -> UIViewController
}

class CurrencyEditBuilder: CurrencyEditBuilderProtocol {
    func makeModule() -> UIViewController {
        guard let viewController = UIStoryboard.edit.instantiateViewController(withIdentifier: .currencyEditViewController) as? CurrencyEditViewController else {
            fatalError("Coulnd not instantiate view controller with identifier: \(UIViewControllerIdentifier.currencyEditViewController.rawValue)")
        }

        let presenter = CurrencyEditPresenter()
        let interactor = CurrencyEditInteractor()
        let localDataManager = CurrencyEditLocalDataManager()
        let dataSource = CurrencyEditDataSource()

        viewController.listener = presenter
        viewController.dataSource = dataSource

        presenter.interactor = interactor
        presenter.view = viewController

        interactor.listener = presenter
        interactor.localDataManager = localDataManager

        localDataManager.listener = interactor
        localDataManager.localService = LocalPersistenceService.instance

        dataSource.listener = viewController

        return viewController
    }
}
