import RIBs
import Domain

protocol RootDependency: Dependency {}

final class RootComponent: Component<RootDependency> {
    var localPersistenceService: LocalPersistenceServiceProtocol {
        return shared { LocalPersistenceService.instance }
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {
    func build() -> LaunchRouting {
        let component = RootComponent(dependency: dependency)
        let viewController = RootViewController()
        let interactor = RootInteractor(presenter: viewController)
        let bootstrapBuilder = BootstrapBuilder(dependency: component)
        let baseBuilder = BaseBuilder(dependency: component)
        return RootRouter(interactor: interactor, viewController: viewController, bootstrapBuilder: bootstrapBuilder, baseBuilder: baseBuilder)
    }
}
