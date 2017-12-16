import CoreData
import LocalService

public protocol LocalPersistenceServiceProtocol {
    func initialize(completion: @escaping () -> ())
    func getCurrencySymbols(completion: @escaping ([String]) -> ())
    func put(currencySymbol: String)
}

public class LocalPersistenceService {
    public static var instance: LocalPersistenceServiceProtocol = LocalPersistenceService()
    var syncContext: NSManagedObjectContext!
    var observerTokens = [NSObjectProtocol]()

    init() {
        startObservingApplicationState()
    }
}

extension LocalPersistenceService: LocalPersistenceServiceProtocol {
    public func initialize(completion: @escaping () -> ()) {
        let modelName = "CurrencyData"
        let modelURL = Bundle.domain.url(forResource: modelName, withExtension:"momd")!
        let model = NSManagedObjectModel(contentsOf: modelURL)!
        let container = NSPersistentContainer(name: modelName, managedObjectModel: model)
        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Failed to load store, \(String(describing: error))")
            }
            
            self.syncContext = container.newBackgroundContext()
            completion()
        }
    }

    public func getCurrencySymbols(completion: @escaping ([String]) -> ()) {
        syncContext.perform {
            let smybols = CurrencySymbol.fetch(in: self.syncContext).map({ $0.symbol })
            completion(smybols)
        }
    }

    public func put(currencySymbol symbol: String) {
        syncContext.performChanges {
            _ = CurrencySymbol.findOrCreate(in: self.syncContext,
                                            matching: CurrencySymbol.defaultPredicate(forSymbol: symbol)) { currencySymbol in
                currencySymbol.symbol = symbol
            }
        }
    }
}

extension LocalPersistenceService: ApplicationStateObserver {
    public func applicationDidEnterBackground() {
        syncContext.refreshAllObjects()
    }
}
