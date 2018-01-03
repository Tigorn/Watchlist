import RIBs

protocol RootRouting: ViewableRouting {
    func routeToBootstrap()
    func routeToBase()
}

protocol RootPresentable: Presentable {
    weak var listener: RootPresentableListener? { get set }
}

protocol RootListener: class {}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {
    weak var router: RootRouting?
    weak var listener: RootListener?

    override init(presenter: RootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    //MARK: - BootstrapListener

    func didFinishInitialization() {
        router?.routeToBase()
    }

    // MARK: - RootPresentableListener

    func viewDidLoad() {
        router?.routeToBootstrap()
    }
}
