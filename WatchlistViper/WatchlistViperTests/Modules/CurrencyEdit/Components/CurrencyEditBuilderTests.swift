import Quick
import Nimble
@testable import WatchlistViper

class CurrencyEditBuilderTests: QuickSpec {
    override func spec() {
        describe("CurrencyEditBuilder") {
            it("returns a CurrencyEditBuilder on create") {
                let viewController = CurrencyEditBuilder().makeModule() as! CurrencyEditViewController
                let presenter = viewController.listener as! CurrencyEditPresenter
                let interactor = presenter.interactor as! CurrencyEditInteractor
                let dataSource = viewController.dataSource as! CurrencyEditDataSource
                let localDataManager = interactor.localDataManager as! CurrencyEditLocalDataManager

                expect(dataSource.listener).toNot(beNil())
                expect(presenter.view).toNot(beNil())
                expect(interactor.listener).toNot(beNil())
                expect(localDataManager.listener).toNot(beNil())
                expect(localDataManager.localService).toNot(beNil())
            }
        }
    }
}
