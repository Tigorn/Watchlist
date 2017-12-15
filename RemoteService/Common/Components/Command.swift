import Foundation

public class Command {
    public let execute: () -> ()

    init(execute: @escaping () -> ()) {
        self.execute = execute
    }
}
