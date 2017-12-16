import CoreData
import LocalService

class CurrencySymbol: NSManagedObject, Managed {
    @NSManaged var symbol: String

    static func defaultPredicate(forSymbol symbolKey: String) -> NSPredicate {
        return NSPredicate(format: "%K == %@", #keyPath(symbol), symbolKey)
    }
}
