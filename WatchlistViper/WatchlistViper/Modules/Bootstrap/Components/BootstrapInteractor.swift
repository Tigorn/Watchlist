import Foundation

class BootstrapInteractor {
    weak var presenter: BootstrapInteractorOutputProtocol?
    var localInputDataManager: BootstrapLocalDataManagerInputProtocol?
}

extension BootstrapInteractor: BootstrapInteractorInputProtocol {
    func bootstrap() {
        localInputDataManager?.initialize()
    }
}

extension BootstrapInteractor: BootstrapLocalDataManagerOutputProtocol {
    func didInitialize() {
        if let localInputDataManager = localInputDataManager, !localInputDataManager.getDidSetDefaultCurrencies() {
            let symbols = localInputDataManager.getDefaultCurrencies()
            symbols.forEach { localInputDataManager.put(currencySymbol: $0) }
            localInputDataManager.setDidSetDefaultCurrencies(value: true)
        }

        presenter?.didFinishBootstrap()
    }
}
