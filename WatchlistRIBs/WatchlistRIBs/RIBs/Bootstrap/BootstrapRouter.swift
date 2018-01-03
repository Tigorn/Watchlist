import RIBs

protocol BootstrapInteractable: Interactable {
    weak var router: BootstrapRouting? { get set }
    weak var listener: BootstrapListener? { get set }
}

protocol BootstrapViewControllable: ViewControllable {}

final class BootstrapRouter: ViewableRouter<BootstrapInteractable, BootstrapViewControllable>, BootstrapRouting {
    override init(interactor: BootstrapInteractable, viewController: BootstrapViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
