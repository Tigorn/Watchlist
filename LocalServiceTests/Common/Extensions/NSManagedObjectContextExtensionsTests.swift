import CoreData
@testable import LocalService
import Nimble
import Quick

class NSManagedObjectContextExtensionsTests: QuickSpec {
    override func spec() {
        describe("NSManagedObjectContextExtensions") {
            var objectContext: MockContext!

            beforeEach {
                objectContext = MockContext(concurrencyType: .privateQueueConcurrencyType)
            }

            context("saveOrRollback") {
                it("returns true if doesn't have changes") {
                    objectContext._hasChanges = false
                    expect(objectContext.saveOrRollback()).to(beTrue())
                }

                it("returns true if saved successfully") {
                    objectContext.throwOnSave = false
                    expect(objectContext.saveOrRollback()).to(beTrue())
                }

                it("returns false if save fails") {
                    objectContext.throwOnSave = true
                    expect(objectContext.saveOrRollback()).to(beFalse())
                }

                it("rollsback if save fails") {
                    objectContext.throwOnSave = true
                    _ = objectContext.saveOrRollback()
                    expect(objectContext.didRollback).to(beTrue())
                }
            }

            it("performs changes") {
                objectContext.performChanges {}
                expect(objectContext.didSave).toEventually(beTrue())
            }
        }
    }
}

fileprivate enum ContextError: Error {
    case saveError
}

fileprivate class MockContext: NSManagedObjectContext {
    var throwOnSave = false
    var _hasChanges = true
    var didRollback = false
    var didSave = false

    override func save() throws {
        if throwOnSave {
            throw ContextError.saveError
        }
        didSave = true
    }

    override func rollback() {
        didRollback = true
    }

    override var hasChanges: Bool {
        return _hasChanges
    }
}
