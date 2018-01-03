import RIBs
import Domain

protocol BootstrapRouting: ViewableRouting {}

protocol BootstrapPresentable: Presentable {
    weak var listener: BootstrapPresentableListener? { get set }
}

protocol BootstrapListener: class {
    func didFinishInitialization()
}

final class BootstrapInteractor: PresentableInteractor<BootstrapPresentable>, BootstrapInteractable, BootstrapPresentableListener {
    weak var router: BootstrapRouting?
    weak var listener: BootstrapListener?

    init(presenter: BootstrapPresentable, localFileService: LocalFileServiceProtocol, localDefaultsService: LocalDefaultsServiceProtocol, localPersistenceService: LocalPersistenceServiceProtocol) {
        self.localFileService = localFileService
        self.localPersistenceService = localPersistenceService
        self.localDefaultsService = localDefaultsService
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        initialize()
    }

    //MARK: - Private

    private let localPersistenceService: LocalPersistenceServiceProtocol
    private let localFileService: LocalFileServiceProtocol
    private var localDefaultsService: LocalDefaultsServiceProtocol

    private func initialize() {
        localPersistenceService.initialize { [weak self] in
            self?.setDefaultCurrencies()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self?.listener?.didFinishInitialization()
            }
        }
    }

    private func setDefaultCurrencies() {
        guard !localDefaultsService.didSetDefaultCurrencies else {
            return
        }

        let symbols = localFileService.defaultCurrencySymbols()
        symbols.forEach { localPersistenceService.put(currencySymbol: $0) }
        localDefaultsService.didSetDefaultCurrencies = true
    }
}
