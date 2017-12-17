import Nimble
import Quick
@testable import WatchlistViper

class BootstrapPresenterTests: QuickSpec {
    override func spec() {
        describe("BootstrapPresenter") {
            var presenter: BootstrapPresenter!

            beforeEach {
                presenter = BootstrapPresenter()
            }

            it("delegates bootstrap to interactor") {
                let interactor = MockInteractor()
                presenter.interactor = interactor
                presenter.bootstrap()
                expect(interactor.didBootstrap).to(beTrue())
            }

            it("sets view window on didFinishBootstrap") {
                let view = MockBootstrapView()
                presenter.view = view
                presenter.router = MockRouter()
                presenter.didFinishBootstrap()
                expect(view.didSetKeyWindow).toEventually(beTrue())
            }
        }
    }
}

private class MockRouter: BootstrapRouterProtocol {
    static func createBootstrapModule(in _: BootstrapViewInputProtocol) -> BootstrapViewOutputProtocol {
        return BootstrapPresenter()
    }

    func rootViewController() -> UIViewController {
        return UIViewController()
    }
}

private class MockInteractor: BootstrapInteractorInputProtocol {
    var presenter: BootstrapInteractorOutputProtocol?
    var localInputDataManager: BootstrapLocalDataManagerInputProtocol?

    var didBootstrap = false
    func bootstrap() {
        didBootstrap = true
    }
}

private class MockBootstrapView: BootstrapViewInputProtocol {
    var presenter: BootstrapViewOutputProtocol?
    var didSetKeyWindow = false

    func set(window: UIWindow) {
        if window.isKeyWindow && window.rootViewController != nil {
            didSetKeyWindow = true
        }
    }
}
