import Domain
import UIKit

protocol BootstrapBuilderProtocol: class {
    func createBootstrapModule(in view: BootstrapViewInputProtocol) -> BootstrapViewOutputProtocol
}

class BootstrapBuilder: BootstrapBuilderProtocol {
    func createBootstrapModule(in view: BootstrapViewInputProtocol) -> BootstrapViewOutputProtocol {
        let presenter = BootstrapPresenter()
        let interactor = BootstrapInteractor()
        let localDataManager = BootstrapLocalDataManager()

        presenter.interactor = interactor
        presenter.router = BootstrapRouter()
        presenter.view = view

        interactor.listener = presenter
        interactor.localDataManager = localDataManager

        localDataManager.listener = interactor
        localDataManager.localDefaultsService = LocalDefaultsService()
        localDataManager.localPersistenceService = LocalPersistenceService.instance
        localDataManager.localFileService = LocalFileService()

        return presenter
    }
}
