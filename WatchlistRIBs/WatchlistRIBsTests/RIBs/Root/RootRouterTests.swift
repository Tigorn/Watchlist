import Nimble
import Quick
import RIBs
import Domain
@testable import WatchlistRIBs

class RootRouterTests: QuickSpec {
    override func spec() {
        var router: RootRouter!
        var rootViewController: MockRootViewController!

        beforeEach {
            rootViewController = MockRootViewController()
            router = RootRouter(interactor: RootInteractor(presenter: rootViewController), viewController: rootViewController, bootstrapBuilder: BootstrapBuilder(dependency: MockBootstrapDependency()), baseBuilder: BaseBuilder(dependency: MockBaseDependency()))
        }

        describe("RootRouter") {
            it("routes to Bootstrap") {
                router.routeToBootstrap()
                expect(rootViewController.didAddChildViewController).to(beTrue())
                expect(router.children.first).to(beAKindOf(BootstrapRouting.self))
            }

            it("routes to base") {
                router.routeToBootstrap()
                rootViewController.didAddChildViewController = false
                router.routeToBase()
                expect(rootViewController.didAddChildViewController).to(beTrue())
                expect(rootViewController.didRemoveChildViewController).to(beTrue())
                expect(router.children.first).to(beAKindOf(BaseRouting.self))
            }
        }
    }
}

private class MockBaseDependency: BaseDependency {}

private class MockBootstrapDependency: BootstrapDependency {
    var localPersistenceService: LocalPersistenceServiceProtocol = LocalPersistenceService.instance
}

private class MockRootViewController: UIViewController, RootPresentable, RootViewControllable {
    var listener: RootPresentableListener?
    var didAddChildViewController = false
    var didRemoveChildViewController = false

    func add(childViewController _: ViewControllable) {
        didAddChildViewController = true
    }

    func remove(childViewController: ViewControllable) {
        didRemoveChildViewController = true
    }
}
