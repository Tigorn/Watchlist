import CoreData
import LocalService

public protocol LocalPersistenceServiceProtocol {
    func initialize(completion: @escaping () -> Void)
    func getSortedCurrencySymbols(completion: @escaping ([CurrencySymbol]) -> Void)
    func put(currencySymbol: CurrencySymbol)
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
    public func initialize(completion: @escaping () -> Void) {
        let modelName = "CurrencyData"
        let modelURL = Bundle.domain.url(forResource: modelName, withExtension: "momd")!
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

    public func getSortedCurrencySymbols(completion: @escaping ([CurrencySymbol]) -> Void) {
        syncContext.perform {
            let symbols = MOCurrencySymbol.fetch(in: self.syncContext).map { CurrencySymbol(symbol: $0.symbol, index: Int($0.index)) }
            completion(symbols.sorted())
        }
    }

    public func put(currencySymbol: CurrencySymbol) {
        syncContext.performChanges {
            _ = MOCurrencySymbol.findOrCreate(in: self.syncContext, matching: MOCurrencySymbol.defaultPredicate(forSymbol: currencySymbol.symbol)) { fetchedCurrencySymbol in
                fetchedCurrencySymbol.symbol = currencySymbol.symbol
                fetchedCurrencySymbol.index = Int64(currencySymbol.index)
            }
        }
    }
}

extension LocalPersistenceService: ApplicationStateObserver {
    public func applicationDidEnterBackground() {
        syncContext.refreshAllObjects()
    }
}
