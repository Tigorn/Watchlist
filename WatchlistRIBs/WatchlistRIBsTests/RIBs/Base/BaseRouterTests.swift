import Quick
import Nimble
import RIBs
@testable import WatchlistRIBs

class BaseRouterTests: QuickSpec {
    override func spec() {
        describe("BaseRouter") {
            var router: BaseRouter!
            var viewController: MockBaseViewController!

            beforeEach {
                viewController = MockBaseViewController()
                router = BaseRouter(interactor: BaseInteractor(presenter: viewController), viewController: viewController, listBuildable: ListBuilder(dependency: MockListDependency()))
            }

            it("sets view controllers") {
                router.didLoad()
                expect(viewController.didSetViewControllers).to(beTrue())
            }
        }
    }
}

private class MockBaseViewController: UIViewController, BasePresentable, BaseViewControllable {
    var listener: BasePresentableListener?
    var didSetViewControllers = false

    func set(viewControllers: [ViewControllable]) {
        didSetViewControllers = true
    }
}

private class MockListDependency: ListDependency {}
