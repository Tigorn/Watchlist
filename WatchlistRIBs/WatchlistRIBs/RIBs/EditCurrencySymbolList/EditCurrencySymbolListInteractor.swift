import RIBs
import RxSwift

protocol EditCurrencySymbolListRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol EditCurrencySymbolListPresentable: Presentable {
    weak var listener: EditCurrencySymbolListPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol EditCurrencySymbolListListener: class {
    func editCurrencyMovingFromParent()
}

final class EditCurrencySymbolListInteractor: PresentableInteractor<EditCurrencySymbolListPresentable>, EditCurrencySymbolListInteractable, EditCurrencySymbolListPresentableListener {

    weak var router: EditCurrencySymbolListRouting?
    weak var listener: EditCurrencySymbolListListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: EditCurrencySymbolListPresentable) {
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

    //MARK: - EditCurrencySymbolListPresentableListener

    func movingFromParent() {
        listener?.editCurrencyMovingFromParent()
    }
}
