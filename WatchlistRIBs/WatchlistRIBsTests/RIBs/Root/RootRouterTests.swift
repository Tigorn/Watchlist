import Nimble
import Quick
import RIBs
@testable import WatchlistRIBs

class RootRouterTests: QuickSpec {
    override func spec() {
        var router: RootRouter!
        var rootViewController: MockRootViewController!

        beforeEach {
            rootViewController = MockRootViewController()
            router = RootRouter(interactor: RootInteractor(presenter: rootViewController), viewController: rootViewController, bootstrapBuilder: BootstrapBuilder(dependency: MockBootstrapComponent()))
        }

        describe("RootRouter") {
            it("routes to Bootstrap") {
                router.routeToBootstrap()
                expect(rootViewController.didAddChildViewController).to(beTrue())
                expect(router.children.first).to(beAKindOf(BootstrapRouter.self))
            }
        }
    }
}

private class MockBootstrapComponent: BootstrapDependency {}

private class MockRootViewController: UIViewController, RootPresentable, RootViewControllable {
    var listener: RootPresentableListener?
    var didAddChildViewController = false
    func add(childViewController _: ViewControllable) {
        didAddChildViewController = true
    }
}
