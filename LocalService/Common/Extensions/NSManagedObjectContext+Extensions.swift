import CoreData

public extension NSManagedObjectContext {
    func insertObject<T: NSManagedObject>() -> T where T: Managed {
        guard let object = NSEntityDescription.insertNewObject(forEntityName: T.entityName, into: self) as? T else {
            fatalError("invalid object type")
        }
        
        return object
    }

    func saveOrRollback() -> Bool {
        guard hasChanges else {
            return true
        }

        do {
            try save()
            return true
        } catch {
            rollback()
            return false
        }
    }

    func performChanges(block: @escaping () -> ()) {
        perform {
            block()
            _ = self.saveOrRollback()
        }
    }
}
