import Foundation

public struct DataTaskComponents {
    public let route: Routable
    let httpMethod: HTTPMethod
    let scheme: String
    let queryItems: [URLQueryItem]?
    let localeType: String?

    public init(route: Routable, httpMethod: HTTPMethod = .get, queryItems: [URLQueryItem]? = nil, scheme: String = "https", localeType: String? = nil) {
        self.route = route
        self.httpMethod = httpMethod
        self.scheme = scheme
        self.queryItems = queryItems
        self.localeType = localeType
    }

    var urlRequest: URLRequest? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = route.host
        components.path = route.path
        components.queryItems = queryItems

        guard let url = components.url else {
            return nil
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        if let localeType = localeType {
            urlRequest.setValue(localeType, forHTTPHeaderField: "Accept-Language")
        }

        return urlRequest
    }
}

extension DataTaskComponents: Equatable {
    public static func == (lhs: DataTaskComponents, rhs: DataTaskComponents) -> Bool {
        return lhs.route.host == rhs.route.host &&
            lhs.route.path == rhs.route.path &&
            lhs.scheme == rhs.scheme &&
            (lhs.queryItems ?? []) == (rhs.queryItems ?? []) &&
            lhs.localeType == rhs.localeType
    }
}
