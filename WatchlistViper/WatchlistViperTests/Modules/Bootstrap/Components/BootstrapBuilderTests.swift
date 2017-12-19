import Nimble
import Quick
@testable import WatchlistViper

// swiftlint:disable force_cast
class BootstrapBuilderTests: QuickSpec {
    override func spec() {
        describe("BootstrapBuilder") {
            var builder: BootstrapBuilder!

            beforeEach {
                builder = BootstrapBuilder()
            }

            it("builds module") {
                let presenter = builder.makeBootstrapModule() as! BootstrapPresenter
                let router = presenter.router as! BootstrapRouter
                let interactor = presenter.interactor as! BootstrapInteractor
                let localDataManager = interactor.localDataManager as! BootstrapLocalDataManager
                expect(router.builder).toNot(beNil())
                expect(interactor.listener).toNot(beNil())
                expect(localDataManager.listener).toNot(beNil())
                expect(localDataManager.localDefaultsService).toNot(beNil())
                expect(localDataManager.localPersistenceService).toNot(beNil())
                expect(localDataManager.localFileService).toNot(beNil())
            }

            it("makes rootViewController") {
                expect(builder.makeRootViewController()).to(beAKindOf(UITabBarController.self))
            }

            it("makes loadingViewController") {
                expect(builder.makeLoadingViewController()).to(beAKindOf(LoadingViewController.self))
            }
        }
    }
}
