import Nimble
import Quick
import RIBs
@testable import WatchlistRIBs

class RootInteractorTests: QuickSpec {
    override func spec() {
        var interactor: RootInteractor!
        var viewController: RootViewController!
        var router: MockRootRouter!

        beforeEach {
            viewController = RootViewController()
            interactor = RootInteractor(presenter: viewController)
            router = MockRootRouter(interactor: interactor, viewController: viewController)
            interactor.router = router
        }

        describe("RootInteractor") {
            it("routes to bootstrap on viewDidLoad") {
                _ = viewController.view
                expect(router.didRouteToBootstrap).to(beTrue())
            }
        }
    }
}

private class MockRootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    var didRouteToBootstrap = false
    func routeToBootstrap() {
        didRouteToBootstrap = true
    }
}
