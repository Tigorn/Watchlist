import RIBs
import Domain

protocol BaseDependency: Dependency {
    var localPersistenceService: LocalPersistenceServiceProtocol { get }
}

final class BaseComponent: Component<BaseDependency> {
    fileprivate var localPersistenceService: LocalPersistenceServiceProtocol {
        return dependency.localPersistenceService
    }

    var mutableCurrencySymbolStream: MutableCurrencySymbolStreamProtocol {
        return shared { CurrencySymbolStream() }
    }
}

// MARK: - Builder

protocol BaseBuildable: Buildable {
    func build(withListener listener: BaseListener) -> BaseRouting
}

final class BaseBuilder: Builder<BaseDependency>, BaseBuildable {
    func build(withListener listener: BaseListener) -> BaseRouting {
        let component = BaseComponent(dependency: dependency)
        let viewController = BaseViewController()
        let interactor = BaseInteractor(presenter: viewController, mutableCurrencySymbolStream: component.mutableCurrencySymbolStream, localPersistenceService: component.localPersistenceService)
        interactor.listener = listener
        let listBuilder = ListBuilder(dependency: component)
        return BaseRouter(interactor: interactor, viewController: viewController, listBuildable: listBuilder)
    }
}
