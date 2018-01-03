import Domain
import Nimble
import Quick
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
                interactor.localDataManager = localDataManager
                interactor.listener = presenter
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
                    expect(localDataManager.putSymbols).to(equal([CurrencySymbol(symbol: "btc", index: 0), CurrencySymbol(symbol: "ltc", index: 1)]))
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

private class MockPresenter: BootstrapInteractorOutputProtocol {
    var didBootstrap = false
    func didFinishBootstrap() {
        didBootstrap = true
    }
}

private class MockLocalDataManager: BootstrapLocalDataManagerInputProtocol {
    var outputEventHandler: BootstrapLocalDataManagerOutputProtocol?
    private var didSetDefaultCurrencies = false
    var didInitialize = false
    var putSymbols = [CurrencySymbol]()

    func setDidSetDefaultCurrencies(value: Bool) {
        didSetDefaultCurrencies = value
    }

    func getDidSetDefaultCurrencies() -> Bool {
        return didSetDefaultCurrencies
    }

    func getDefaultCurrencies() -> [CurrencySymbol] {
        return [CurrencySymbol(symbol: "btc", index: 0), CurrencySymbol(symbol: "ltc", index: 1)]
    }

    func put(currencySymbol: CurrencySymbol) {
        putSymbols.append(currencySymbol)
    }

    func initialize() {
        didInitialize = true
    }
}
