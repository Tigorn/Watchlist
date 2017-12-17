import CoreData
@testable import Domain

extension NSPersistentStoreCoordinator {
    static func dataSQLiteTestCoordinator() -> NSPersistentStoreCoordinator {
        return dataTestCoordinator { $0.addSQLiteTestStore() }
    }

    fileprivate func addSQLiteTestStore() {
        let storeURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true).appendingPathComponent("Data-test")
        if FileManager.default.fileExists(atPath: storeURL.path) {
            try? destroyPersistentStore(at: storeURL, ofType: NSSQLiteStoreType, options: nil)
        }
        try! addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
    }

    fileprivate static func dataTestCoordinator(_ addStore: (NSPersistentStoreCoordinator) -> Void) -> NSPersistentStoreCoordinator {
        let url = Bundle.domain.url(forResource: "CurrencyData", withExtension: "momd")!
        let model = NSManagedObjectModel(contentsOf: url)!
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        addStore(coordinator)
        return coordinator
    }
}
