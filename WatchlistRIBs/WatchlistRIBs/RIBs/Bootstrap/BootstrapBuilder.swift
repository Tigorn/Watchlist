import RIBs

protocol BootstrapDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class BootstrapComponent: Component<BootstrapDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol BootstrapBuildable: Buildable {
    func build(withListener listener: BootstrapListener) -> BootstrapRouting
}

final class BootstrapBuilder: Builder<BootstrapDependency>, BootstrapBuildable {

    override init(dependency: BootstrapDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: BootstrapListener) -> BootstrapRouting {
        let component = BootstrapComponent(dependency: dependency)
        let viewController = BootstrapViewController()
        let interactor = BootstrapInteractor(presenter: viewController)
        interactor.listener = listener
        return BootstrapRouter(interactor: interactor, viewController: viewController)
    }
}
