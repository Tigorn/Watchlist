import CoreData
@testable import Domain
import LocalService
import Nimble
import Quick

class LocalPersistenceServiceTests: QuickSpec {
    override func spec() {
        describe("LocalPersistenceService") {
            var localService: LocalPersistenceService!
            var objectContext: NSManagedObjectContext!

            beforeEach {
                localService = LocalPersistenceService()
                objectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
                objectContext.persistentStoreCoordinator = NSPersistentStoreCoordinator.dataSQLiteTestCoordinator()
                localService.syncContext = objectContext
            }

            it("refreshes all objects on didEnterBackground") {
                let mockContext = MockContext(concurrencyType: .mainQueueConcurrencyType)
                localService.syncContext = mockContext
                NotificationCenter.default.post(name: .UIApplicationDidEnterBackground, object: nil)
                expect(mockContext.didRefreshAllObjects).to(beTrue())
            }

            it("sets syncContext on initialize") {
                localService.initialize(completion: {})
                expect(localService.syncContext).toEventuallyNot(beNil())
            }

            it("gets and puts currency symbols") {
                localService.put(currencySymbol: "abc")
                localService.put(currencySymbol: "btc")
                var result = [String]()
                localService.getCurrencySymbols(completion: { currencySymbols in
                    result = currencySymbols
                })
                expect(result.sorted()).toEventually(equal(["abc", "btc"]))
            }
        }
    }
}

private class MockContext: NSManagedObjectContext {
    var didRefreshAllObjects = false
    override func refreshAllObjects() {
        didRefreshAllObjects = true
    }
}
