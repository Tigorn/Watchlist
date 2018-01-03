import RIBs

protocol BaseInteractable: Interactable, ListListener {
    weak var router: BaseRouting? { get set }
    weak var listener: BaseListener? { get set }
}

protocol BaseViewControllable: ViewControllable {
    func set(viewControllers: [ViewControllable])
}

final class BaseRouter: ViewableRouter<BaseInteractable, BaseViewControllable>, BaseRouting {
    init(interactor: BaseInteractable, viewController: BaseViewControllable, listBuildable: ListBuildable) {
        listBuilder = listBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    override func didLoad() {
        super.didLoad()
        setViewControllers()
    }

    //MARK: - Private
    
    private let listBuilder: ListBuildable

    private func setViewControllers() {
        let listRouter = listBuilder.build(withListener: interactor)
        viewController.set(viewControllers: [listRouter.viewControllable])
        attachChild(listRouter)
    }
}
