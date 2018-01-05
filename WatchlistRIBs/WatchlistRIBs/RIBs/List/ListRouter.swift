import RIBs

protocol ListInteractable: Interactable, AddCurrencySymbolListener, EditCurrencySymbolListListener {
    weak var router: ListRouting? { get set }
    weak var listener: ListListener? { get set }
}

protocol ListViewControllable: ViewControllable {
    func show(viewController: ViewControllable)
}

final class ListRouter: ViewableRouter<ListInteractable, ListViewControllable>, ListRouting {

    init(interactor: ListInteractable, viewController: ListViewControllable, editCurrencySymbolListBuilder: EditCurrencySymbolListBuildable, addCurrencySymbolBuilder: AddCurrencySymbolBuildable) {
        self.addCurrencySymbolBuilder = addCurrencySymbolBuilder
        self.editCurrencySymbolListBuilder = editCurrencySymbolListBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    func routeToAddCurrencySymbol() {
        let router = addCurrencySymbolBuilder.build(withListener: interactor)
        attachChild(router)
        viewController.show(viewController: router.viewControllable)
        self.addCurrencySymbolRouter = router
    }

    func routeToEditCurrencySymbolList() {
        let router = editCurrencySymbolListBuilder.build(withListener: interactor)
        viewController.show(viewController: router.viewControllable)
        attachChild(router)
        self.editCurrencySymbolListRouter = router
    }

    func removeEditCurrencySymbolList() {
        guard let editCurrencySymbolListRouter = editCurrencySymbolListRouter else {
            return
        }

        detachChild(editCurrencySymbolListRouter)
        self.editCurrencySymbolListRouter = nil
    }

    func removeAddCurrencySymbol() {
        guard let addCurrencySymbolRouter = addCurrencySymbolRouter else {
            return
        }

        detachChild(addCurrencySymbolRouter)
        self.addCurrencySymbolRouter = nil
    }

    //MARK: - Private
    private let editCurrencySymbolListBuilder: EditCurrencySymbolListBuildable
    private let addCurrencySymbolBuilder: AddCurrencySymbolBuildable
    private var editCurrencySymbolListRouter: EditCurrencySymbolListRouting?
    private var addCurrencySymbolRouter: AddCurrencySymbolRouting?
}
