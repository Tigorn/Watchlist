import Quick
import Nimble
@testable import WatchlistViper

class BootstrapBuilderTests: QuickSpec {
    override func spec() {
        describe("BootstrapBuilder") {
            it("builds module") {
                let view = MockBootstrapView()
                let presenter = BootstrapBuilder().createBootstrapModule(in: view) as! BootstrapPresenter
                let interactor = presenter.interactor as! BootstrapInteractor
                let localInputDataManager = interactor.localInputDataManager as! BootstrapLocalDataManager
                expect(interactor).toNot(beNil())
                expect(presenter.router).toNot(beNil())
                expect(presenter.view === view).to(beTrue())
                expect(interactor.listener === presenter).to(beTrue())
                expect(interactor.localInputDataManager).toNot(beNil())
                expect(localInputDataManager.listener).toNot(beNil())
            }
        }
    }
}

fileprivate class MockBootstrapView: BootstrapViewInputProtocol {
    func set(window: UIWindow) { }
}
