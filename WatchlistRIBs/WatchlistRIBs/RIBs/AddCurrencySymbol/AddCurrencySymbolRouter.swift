import RIBs

protocol AddCurrencySymbolInteractable: Interactable {
    weak var router: AddCurrencySymbolRouting? { get set }
    weak var listener: AddCurrencySymbolListener? { get set }
}

protocol AddCurrencySymbolViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class AddCurrencySymbolRouter: ViewableRouter<AddCurrencySymbolInteractable, AddCurrencySymbolViewControllable>, AddCurrencySymbolRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: AddCurrencySymbolInteractable, viewController: AddCurrencySymbolViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
