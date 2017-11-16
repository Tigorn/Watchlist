import Quick
import Nimble
@testable import WatchlistViper

class BootstrapInteractorTests: QuickSpec {
    override func spec() {
        describe("BootstrapInteractor") {
            var interactor: BootstrapInteractor!
            var localDataManager: MockLocalDataManager!
            var presenter: MockPresenter!

            beforeEach {
                presenter = MockPresenter()
                localDataManager = MockLocalDataManager()
                interactor = BootstrapInteractor()
                interactor.localInputDataManager = localDataManager
                interactor.presenter = presenter
            }

            it("initializes local data manager on bootstrap") {
                interactor.bootstrap()
                expect(localDataManager.didInitialize).to(beTrue())
            }

            context("has not set default currencies") {
                beforeEach {
                    localDataManager.setDidSetDefaultCurrencies(value: false)
                }

                it("puts default symbols on didInitialize") {
                    interactor.didInitialize()
                    expect(localDataManager.putSymbols).to(equal(["btc", "ltc"]))
                }

                it("finishes bootstrap") {
                    interactor.didInitialize()
                    expect(presenter.didBootstrap).to(beTrue())
                }
            }

            context("has set default currencies") {
                beforeEach {
                    localDataManager.setDidSetDefaultCurrencies(value: true)
                }

                it("finishes bootstrap") {
                    interactor.didInitialize()
                    expect(presenter.didBootstrap).to(beTrue())
                }
            }
        }
    }
}

fileprivate class MockPresenter: BootstrapInteractorOutputProtocol {
    var didBootstrap = false
    func didFinishBootstrap() {
        didBootstrap = true
    }
}

fileprivate class MockLocalDataManager: BootstrapLocalDataManagerInputProtocol {
    var outputEventHandler: BootstrapLocalDataManagerOutputProtocol?
    private var didSetDefaultCurrencies = false
    var didInitialize = false
    var putSymbols = [String]()

    func setDidSetDefaultCurrencies(value: Bool) {
        didSetDefaultCurrencies = value
    }
    
    func getDidSetDefaultCurrencies() -> Bool {
        return didSetDefaultCurrencies
    }
    
    func getDefaultCurrencies() -> [String] {
        return ["btc", "ltc"]
    }
    
    func put(currencySymbol symbol: String) {
        putSymbols.append(symbol)
    }
    
    func initialize() {
        didInitialize = true
    }
}
