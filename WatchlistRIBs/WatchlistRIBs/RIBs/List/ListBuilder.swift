import RIBs
import Domain

protocol ListDependency: Dependency {
    var currencySymbolStream: CurrencySymbolStreamProtocol { get }
}

final class ListComponent: Component<ListDependency> {
    fileprivate var securitiesService = SecuritiesService()

    var currencySymbolStream: CurrencySymbolStreamProtocol {
        return dependency.currencySymbolStream
    }
}

// MARK: - Builder

protocol ListBuildable: Buildable {
    func build(withListener listener: ListListener) -> ListRouting
}

final class ListBuilder: Builder<ListDependency>, ListBuildable {
    override init(dependency: ListDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ListListener) -> ListRouting {
        let component = ListComponent(dependency: dependency)
        let viewController = ListViewController()
        let interactor = ListInteractor(presenter: viewController, currencySymbolStream: component.currencySymbolStream, securitiesService: component.securitiesService)
        interactor.listener = listener
        return ListRouter(interactor: interactor, viewController: viewController)
    }
}
