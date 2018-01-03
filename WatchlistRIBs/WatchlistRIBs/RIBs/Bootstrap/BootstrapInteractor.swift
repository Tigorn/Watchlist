import RIBs
import RxSwift

protocol BootstrapRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol BootstrapPresentable: Presentable {
    weak var listener: BootstrapPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol BootstrapListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class BootstrapInteractor: PresentableInteractor<BootstrapPresentable>, BootstrapInteractable, BootstrapPresentableListener {

    weak var router: BootstrapRouting?
    weak var listener: BootstrapListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: BootstrapPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
