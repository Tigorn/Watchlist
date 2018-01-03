import RIBs
import RxSwift

protocol BaseRouting: ViewableRouting {}

protocol BasePresentable: Presentable {
    weak var listener: BasePresentableListener? { get set }
}

protocol BaseListener: class {}

final class BaseInteractor: PresentableInteractor<BasePresentable>, BaseInteractable, BasePresentableListener {
    weak var router: BaseRouting?
    weak var listener: BaseListener?

    override init(presenter: BasePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
}
