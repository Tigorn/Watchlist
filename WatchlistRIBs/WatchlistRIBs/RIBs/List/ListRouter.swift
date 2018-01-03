import RIBs

protocol ListInteractable: Interactable {
    weak var router: ListRouting? { get set }
    weak var listener: ListListener? { get set }
}

protocol ListViewControllable: ViewControllable {}

final class ListRouter: ViewableRouter<ListInteractable, ListViewControllable>, ListRouting {
    override init(interactor: ListInteractable, viewController: ListViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
