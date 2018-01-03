import RIBs

protocol BaseInteractable: Interactable {
    weak var router: BaseRouting? { get set }
    weak var listener: BaseListener? { get set }
}

protocol BaseViewControllable: ViewControllable {}

final class BaseRouter: ViewableRouter<BaseInteractable, BaseViewControllable>, BaseRouting {
    override init(interactor: BaseInteractable, viewController: BaseViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
