import CoreData
import LocalService

class MOCurrencySymbol: NSManagedObject, Managed {
    @NSManaged var symbol: String
    @NSManaged var index: Int64

    static func defaultPredicate(forSymbol symbolKey: String) -> NSPredicate {
        return NSPredicate(format: "%K == %@", #keyPath(symbol), symbolKey)
    }
}
