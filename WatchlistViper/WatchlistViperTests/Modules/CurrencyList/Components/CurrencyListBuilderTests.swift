import Quick
import Nimble
@testable import WatchlistViper

class CurrencyListBuilderTests: QuickSpec {
    override func spec() {
        describe("") {
            var builder: CurrencyListBuilder!

            beforeEach {
                builder = CurrencyListBuilder()
            }

            it("builds on create") {
                let viewController = builder.makeModule() as! CurrencyListViewController
                let presenter = viewController.listener as! CurrencyListPresenter
                let interactor = presenter.interactor as! CurrencyListInteractor
                let localDataManager = interactor.localDataManager as! CurrencyListLocalDataManager
                let remoteDataManager = interactor.remoteDataManager as! CurrencyListRemoteDataManager

                expect(viewController.dataSource).toNot(beNil())
                expect(localDataManager.listener).toNot(beNil())
                expect(localDataManager.localService).toNot(beNil())
                expect(remoteDataManager.listener).toNot(beNil())
                expect(remoteDataManager.remoteService).toNot(beNil())
                expect(interactor.listener).toNot(beNil())
                expect(presenter.view).toNot(beNil())
                expect(presenter.router).toNot(beNil())
            }
        }
    }
}
