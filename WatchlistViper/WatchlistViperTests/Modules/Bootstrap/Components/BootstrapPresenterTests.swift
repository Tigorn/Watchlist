import Nimble
import Quick
@testable import WatchlistViper

class BootstrapPresenterTests: QuickSpec {
    override func spec() {
        describe("BootstrapPresenter") {
            var presenter: BootstrapPresenter!
            var router: MockRouter!
            var interactor: MockInteractor!

            beforeEach {
                presenter = BootstrapPresenter()
                router = MockRouter()
                interactor = MockInteractor()

                presenter.router = router
                presenter.interactor = interactor
            }

            it("bootstraps window") {
                let window = UIWindow()
                window.rootViewController = UIViewController()
                presenter.bootstrap(window: window)
                expect(router.didSetRootViewController).to(beTrue())
                expect(router.didMakeKeyAndVisible).to(beTrue())
                expect(router.didShowLoading).to(beTrue())
                expect(interactor.didBootstrap).to(beTrue())
            }

            it("dismiss loading on didFinishBootstrap") {
                presenter.didFinishBootstrap()
                expect(router.didDismissLoading).toEventually(beTrue())
            }
        }
    }
}

private class MockRouter: BootstrapRouterInputProtocol {
    var didSetRootViewController = false
    var didMakeKeyAndVisible = false
    var didShowLoading = false
    var didDismissLoading = false

    func setRootviewController(window: UIWindow) {
        didSetRootViewController = true
    }

    func makeWindowKeyAndVisible(window: UIWindow) {
        didMakeKeyAndVisible = true
    }

    func showLoading(from viewController: UIViewController) {
        didShowLoading = true
    }

    func dismissLoading() {
        didDismissLoading = true
    }
}

private class MockInteractor: BootstrapInteractorInputProtocol {
    var didBootstrap = false
    func bootstrap() {
        didBootstrap = true
    }
}
