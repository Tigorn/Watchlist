import RIBs

protocol BootstrapInteractable: Interactable {
    weak var router: BootstrapRouting? { get set }
    weak var listener: BootstrapListener? { get set }
}

protocol BootstrapViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class BootstrapRouter: ViewableRouter<BootstrapInteractable, BootstrapViewControllable>, BootstrapRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: BootstrapInteractable, viewController: BootstrapViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
