import RIBs

protocol RootInteractable: Interactable, BootstrapListener, BaseListener {
    weak var router: RootRouting? { get set }
    weak var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func add(childViewController: ViewControllable)
    func remove(childViewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    init(interactor: RootInteractable, viewController: RootViewControllable, bootstrapBuilder: BootstrapBuildable, baseBuilder: BaseBuildable) {
        self.bootstrapBuilder = bootstrapBuilder
        self.baseBuilder = baseBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    func routeToBootstrap() {
        let bootstrapRouter = bootstrapBuilder.build(withListener: interactor)
        viewController.add(childViewController: bootstrapRouter.viewControllable)
        self.bootstrapRouter = bootstrapRouter
        attachChild(bootstrapRouter)
    }

    func routeToBase() {
        if let bootstrapRouter = bootstrapRouter {
            detachChild(bootstrapRouter)
            viewController.remove(childViewController: bootstrapRouter.viewControllable)
            self.bootstrapRouter = nil
        }

        let baseRouter = baseBuilder.build(withListener: interactor)
        attachChild(baseRouter)
        viewController.add(childViewController: baseRouter.viewControllable)
        self.baseRouter = baseRouter
    }

    // MARK: - Private

    private let baseBuilder: BaseBuildable
    private let bootstrapBuilder: BootstrapBuildable
    private var bootstrapRouter: BootstrapRouting?
    private var baseRouter: BaseRouting?
}
