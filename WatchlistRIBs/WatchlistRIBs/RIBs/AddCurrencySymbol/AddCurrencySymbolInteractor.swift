import RIBs
import RxSwift

protocol AddCurrencySymbolRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol AddCurrencySymbolPresentable: Presentable {
    weak var listener: AddCurrencySymbolPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol AddCurrencySymbolListener: class {
    func addCurrencyMovingFromParent()
}

final class AddCurrencySymbolInteractor: PresentableInteractor<AddCurrencySymbolPresentable>, AddCurrencySymbolInteractable, AddCurrencySymbolPresentableListener {

    weak var router: AddCurrencySymbolRouting?
    weak var listener: AddCurrencySymbolListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: AddCurrencySymbolPresentable) {
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

    func movingFromParent() {
        listener?.addCurrencyMovingFromParent()
    }
}
