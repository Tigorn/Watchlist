import Foundation

protocol BootstrapInteractorInputProtocol: class {
    func bootstrap()
}

protocol BootstrapInteractorOutputProtocol: class {
    func didFinishBootstrap()
}

class BootstrapInteractor {
    weak var listener: BootstrapInteractorOutputProtocol?
    var localInputDataManager: BootstrapLocalDataManagerInputProtocol?
}

extension BootstrapInteractor: BootstrapInteractorInputProtocol {
    func bootstrap() {
        localInputDataManager?.initialize()
    }
}

extension BootstrapInteractor: BootstrapLocalDataManagerOutputProtocol {
    func didInitialize() {
        if let localInputDataManager = localInputDataManager,
            !localInputDataManager.getDidSetDefaultCurrencies() {
            let symbols = localInputDataManager.getDefaultCurrencies()
            symbols.forEach { localInputDataManager.put(currencySymbol: $0) }
            localInputDataManager.setDidSetDefaultCurrencies(value: true)
        }

        listener?.didFinishBootstrap()
    }
}
