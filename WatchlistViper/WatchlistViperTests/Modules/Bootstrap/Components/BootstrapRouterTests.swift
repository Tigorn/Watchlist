import Nimble
import Quick
@testable import WatchlistViper

class BootstrapRouterTests: QuickSpec {
    override func spec() {
        describe("BootstrapRouter") {
            var router: BootstrapRouter!
            var builder: MockBuilder!

            beforeEach {
                router = BootstrapRouter()
                builder = MockBuilder()
                router.builder = builder
            }

            it("sets the rootViewController") {
                let window = UIWindow()
                router.setRootviewController(window: window)
                expect(window.rootViewController).toNot(beNil())
            }

            it("makes window keyAndVisible") {
                let mockWindow = MockWindow()
                router.makeWindowKeyAndVisible(window: mockWindow)
                expect(mockWindow.didMakeKeyAndVisible).to(beTrue())
            }

            it("dismisses loading") {
                let viewController = MockViewController()
                router.presentedViewController = viewController
                router.dismissLoading()
                expect(viewController.didDismiss).to(beTrue())
            }

            it("shows loading") {
                let viewController = MockViewController()
                router.routeToLoading(from: viewController)
                expect(viewController.didPresent).to(beTrue())
            }
        }
    }
}

private class MockViewController: UIViewController {
    var didDismiss = false
    var didPresent = false
    override func dismiss(animated _: Bool, completion _: (() -> Void)? = nil) {
        didDismiss = true
    }

    override func present(_: UIViewController, animated _: Bool, completion _: (() -> Void)? = nil) {
        didPresent = true
    }
}

private class MockWindow: UIWindow {
    var didMakeKeyAndVisible = false
    override func makeKeyAndVisible() {
        didMakeKeyAndVisible = true
    }
}

private class MockPresenter: BootstrapViewOutputProtocol {
    func bootstrap(window _: UIWindow) {
    }
}

private class MockBuilder: BootstrapBuilderProtocol {
    func makeRootViewController() -> UIViewController {
        return UIViewController()
    }

    func makeLoadingViewController() -> UIViewController {
        return UIViewController()
    }

    func makeBootstrapModule() -> BootstrapViewOutputProtocol {
        return MockPresenter()
    }
}
