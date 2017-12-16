import Foundation
import Domain

protocol BootstrapInteractorInputProtocol: class {
    func bootstrap()
}

protocol BootstrapInteractorOutputProtocol: class {
    func didFinishBootstrap()
}

class BootstrapInteractor {
    weak var listener: BootstrapInteractorOutputProtocol?
    var localDataManager: BootstrapLocalDataManagerInputProtocol?
}

extension BootstrapInteractor: BootstrapInteractorInputProtocol {
    func bootstrap() {
        localDataManager?.initialize()
    }
}

extension BootstrapInteractor: BootstrapLocalDataManagerOutputProtocol {
    func didInitialize() {
        if let localInputDataManager = localDataManager,
            !localInputDataManager.getDidSetDefaultCurrencies() {
            let symbols = localInputDataManager.getDefaultCurrencies()
            symbols.forEach { localInputDataManager.put(currencySymbol: $0) }
            localInputDataManager.setDidSetDefaultCurrencies(value: true)
        }

        listener?.didFinishBootstrap()
    }
}
