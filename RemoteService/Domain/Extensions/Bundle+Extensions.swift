import Foundation

extension Bundle {
    static var remoteService: Bundle {
        let identifier = "com.ericdrew.RemoteService"
        guard let bundle = Bundle(identifier: identifier) else {
            fatalError("Could not find bundle with identifier: \(identifier)")
        }

        return bundle
    }
}
