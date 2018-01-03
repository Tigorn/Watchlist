import RIBs

protocol RootInteractable: Interactable, BootstrapListener {
    weak var router: RootRouting? { get set }
    weak var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func add(childViewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    init(interactor: RootInteractable, viewController: RootViewControllable, bootstrapBuilder: BootstrapBuildable) {
        self.bootstrapBuilder = bootstrapBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    func routeToBootstrap() {
        let bootstrapRouter = bootstrapBuilder.build(withListener: interactor)
        attachChild(bootstrapRouter)
        viewController.add(childViewController: bootstrapRouter.viewControllable)
        self.bootstrapRouter = bootstrapRouter
    }

    // MARK: - Private

    private var bootstrapBuilder: BootstrapBuildable
    private var bootstrapRouter: BootstrapRouting?
}
