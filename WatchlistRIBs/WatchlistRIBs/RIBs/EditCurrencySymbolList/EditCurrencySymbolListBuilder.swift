import RIBs

protocol EditCurrencySymbolListDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class EditCurrencySymbolListComponent: Component<EditCurrencySymbolListDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol EditCurrencySymbolListBuildable: Buildable {
    func build(withListener listener: EditCurrencySymbolListListener) -> EditCurrencySymbolListRouting
}

final class EditCurrencySymbolListBuilder: Builder<EditCurrencySymbolListDependency>, EditCurrencySymbolListBuildable {

    override init(dependency: EditCurrencySymbolListDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: EditCurrencySymbolListListener) -> EditCurrencySymbolListRouting {
        let component = EditCurrencySymbolListComponent(dependency: dependency)
        let viewController = EditCurrencySymbolListViewController()
        let interactor = EditCurrencySymbolListInteractor(presenter: viewController)
        interactor.listener = listener
        return EditCurrencySymbolListRouter(interactor: interactor, viewController: viewController)
    }
}
