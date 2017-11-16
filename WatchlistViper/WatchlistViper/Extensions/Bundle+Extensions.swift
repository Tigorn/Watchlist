import Foundation

extension Bundle {
    static var viper: Bundle {
        let identifier = "com.ericdrew.WatchlistViper"
        guard let bundle = Bundle(identifier: identifier) else {
            fatalError("Could not bundle with identifier: \(identifier)")
        }

        return bundle
    }
}
