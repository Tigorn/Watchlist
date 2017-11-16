import Quick
import Nimble
import CoreData
@testable import LocalService

class ManagedTests: QuickSpec {
    override func spec() {
        describe("ManagedTests") {
            var managedObject: CurrencySymbol!
            var objectContext: NSManagedObjectContext!

            beforeEach {
                objectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
                objectContext.persistentStoreCoordinator = NSPersistentStoreCoordinator.MOBDataSQLiteTestCoordinator()
                objectContext.performAndWait {
                    managedObject = CurrencySymbol.insert(into: objectContext)
                    managedObject.symbol = "btc"
                }
            }

            it("has an entity name") {
                objectContext.performAndWait {
                    expect(CurrencySymbol.entityName).to(equal("CurrencySymbol"))
                }
            }

            it("can be inserted into a context") {
                objectContext.performAndWait {
                    expect(managedObject.managedObjectContext).toNot(beNil())
                }
            }

            context("findOrCreate") {
                it("can be found") {
                    objectContext.performAndWait {
                        _ = CurrencySymbol.findOrCreate(in: objectContext, matching: NSPredicate(format: "symbol == %@", "btc"), configure: { currencySymbol in
                            expect(currencySymbol.symbol).to(equal("btc"))
                        })
                    }
                }

                it("can be created") {
                    objectContext.performAndWait {
                        let object = CurrencySymbol.findOrCreate(in: objectContext, matching: NSPredicate(format: "symbol == %@", "abc"), configure: { currencySymbol in
                            currencySymbol.symbol = "abc"
                        })
                        expect(object.symbol).to(equal("abc"))
                    }
                }
            }

            context("findOrFetch") {
                it("can be found") {
                    objectContext.performAndWait {
                        let object = CurrencySymbol.findOrFetch(in: objectContext, matching: NSPredicate(format: "symbol == %@", "btc"))
                        expect(object).toNot(beNil())
                    }
                }

                it("can be not found") {
                    objectContext.performAndWait {
                        let object = CurrencySymbol.findOrFetch(in: objectContext, matching: NSPredicate(format: "symbol == %@", "abc"))
                        expect(object).to(beNil())
                    }
                }
            }

            it("can be fetched") {
                objectContext.performAndWait {
                    let objects = CurrencySymbol.fetch(in: objectContext, configurationBlock: { request in
                        request.predicate = NSPredicate(format: "symbol == %@", "btc")
                    })
                    expect(objects.count).to(equal(1))
                }
            }
        }
    }
}
