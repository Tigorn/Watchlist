import RIBs

protocol BaseDependency: Dependency {}

final class BaseComponent: Component<BaseDependency> {}

// MARK: - Builder

protocol BaseBuildable: Buildable {
    func build(withListener listener: BaseListener) -> BaseRouting
}

final class BaseBuilder: Builder<BaseDependency>, BaseBuildable {
    func build(withListener listener: BaseListener) -> BaseRouting {
        let component = BaseComponent(dependency: dependency)
        let viewController = BaseViewController()
        let interactor = BaseInteractor(presenter: viewController)
        interactor.listener = listener
        return BaseRouter(interactor: interactor, viewController: viewController)
    }
}
