import RIBs
import Domain

protocol BootstrapDependency: Dependency {
    var localPersistenceService: LocalPersistenceServiceProtocol { get }
}

final class BootstrapComponent: Component<BootstrapDependency> {
    fileprivate var localPersistenceService: LocalPersistenceServiceProtocol {
        return dependency.localPersistenceService
    }
}

// MARK: - Builder

protocol BootstrapBuildable: Buildable {
    func build(withListener listener: BootstrapListener) -> BootstrapRouting
}

final class BootstrapBuilder: Builder<BootstrapDependency>, BootstrapBuildable {
    func build(withListener listener: BootstrapListener) -> BootstrapRouting {
        let component = BootstrapComponent(dependency: dependency)
        let viewController = BootstrapViewController()
        let localFileService = LocalFileService()
        let localDefaultsService = LocalDefaultsService()
        let interactor = BootstrapInteractor(presenter: viewController, localFileService: localFileService, localDefaultsService: localDefaultsService, localPersistenceService: component.localPersistenceService)
        interactor.listener = listener
        return BootstrapRouter(interactor: interactor, viewController: viewController)
    }
}
