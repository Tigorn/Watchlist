import RIBs
import RxSwift
import Domain

protocol BaseRouting: ViewableRouting {}

protocol BasePresentable: Presentable {
    weak var listener: BasePresentableListener? { get set }
}

protocol BaseListener: class {}

final class BaseInteractor: PresentableInteractor<BasePresentable>, BaseInteractable, BasePresentableListener {
    weak var router: BaseRouting?
    weak var listener: BaseListener?

    init(presenter: BasePresentable, mutableCurrencySymbolStream: MutableCurrencySymbolStreamProtocol, localPersistenceService: LocalPersistenceServiceProtocol) {
        self.localPersistenceService = localPersistenceService
        self.mutableCurrencySymbolStream = mutableCurrencySymbolStream
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        updateCurrencySymbols()
    }

    //MARK: - Private

    private let mutableCurrencySymbolStream: MutableCurrencySymbolStreamProtocol
    private let localPersistenceService: LocalPersistenceServiceProtocol

    private func updateCurrencySymbols() {
        localPersistenceService.getSortedCurrencySymbols { [weak self] symbols in
            self?.mutableCurrencySymbolStream.update(currencySymbols: symbols)
        }
    }
}
