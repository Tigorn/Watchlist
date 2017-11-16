import Foundation

protocol Routable {
    var path: String { get }
    var host: String { get }
}

enum Route {
    case tickers
}

extension Route: Routable {
    var path: String {
        switch self {
        case .tickers:
            return "/v2/tickers/"
        }
    }

    var host: String {
        switch self {
        case .tickers:
            return "api.bitfinex.com"
        }
    }
}
