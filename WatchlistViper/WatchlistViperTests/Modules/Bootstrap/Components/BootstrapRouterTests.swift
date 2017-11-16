import Quick
import Nimble
@testable import WatchlistViper

class BootstrapRouterTests: QuickSpec {
    override func spec() {
        describe("BootstrapRouter") {
            var router: BootstrapRouter!

            beforeEach {
                router = BootstrapRouter()
            }
            
            it("builds module") {
                let view = MockBootstrapView()
                let presenter = BootstrapRouter.createBootstrapModule(in: view)
                let interactor = presenter.interactor
                expect(interactor).toNot(beNil())
                expect(presenter.router).toNot(beNil())
                expect(presenter.view === view).to(beTrue())
                expect(interactor?.presenter === presenter).to(beTrue())
                expect(interactor?.localInputDataManager).toNot(beNil())
                expect(interactor?.localInputDataManager?.outputEventHandler).toNot(beNil())
            }

            it("creates the rootViewController") {
                expect(router.rootViewController()).to(beAKindOf(UITabBarController.self))
            }
        }
    }
}

fileprivate class MockBootstrapView: BootstrapViewProtocol {
    var presenter: BootstrapPresenterProtocol?
    func set(window: UIWindow) { }
}
