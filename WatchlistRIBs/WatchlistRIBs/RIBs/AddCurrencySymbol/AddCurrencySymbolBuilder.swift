import RIBs

protocol AddCurrencySymbolDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class AddCurrencySymbolComponent: Component<AddCurrencySymbolDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol AddCurrencySymbolBuildable: Buildable {
    func build(withListener listener: AddCurrencySymbolListener) -> AddCurrencySymbolRouting
}

final class AddCurrencySymbolBuilder: Builder<AddCurrencySymbolDependency>, AddCurrencySymbolBuildable {

    override init(dependency: AddCurrencySymbolDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: AddCurrencySymbolListener) -> AddCurrencySymbolRouting {
        let component = AddCurrencySymbolComponent(dependency: dependency)
        let viewController = AddCurrencySymbolViewController()
        let interactor = AddCurrencySymbolInteractor(presenter: viewController)
        interactor.listener = listener
        return AddCurrencySymbolRouter(interactor: interactor, viewController: viewController)
    }
}
