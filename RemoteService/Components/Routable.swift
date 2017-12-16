import Foundation

public protocol Routable {
    var path: String { get }
    var host: String { get }
}
