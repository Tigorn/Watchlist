import Foundation

struct DataTaskComponents {
    let route: Routable
    let httpMethod: HTTPMethod
    let scheme: String
    let queryItems: [URLQueryItem]?

    init(route: Routable, httpMethod: HTTPMethod = .get, queryItems: [URLQueryItem]? = nil, scheme: String = "https") {
        self.route = route
        self.httpMethod = httpMethod
        self.scheme = scheme
        self.queryItems = queryItems
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

        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        return request
    }
}
