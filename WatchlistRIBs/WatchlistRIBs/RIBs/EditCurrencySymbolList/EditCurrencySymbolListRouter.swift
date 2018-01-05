import RIBs

protocol EditCurrencySymbolListInteractable: Interactable {
    weak var router: EditCurrencySymbolListRouting? { get set }
    weak var listener: EditCurrencySymbolListListener? { get set }
}

protocol EditCurrencySymbolListViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class EditCurrencySymbolListRouter: ViewableRouter<EditCurrencySymbolListInteractable, EditCurrencySymbolListViewControllable>, EditCurrencySymbolListRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: EditCurrencySymbolListInteractable, viewController: EditCurrencySymbolListViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
