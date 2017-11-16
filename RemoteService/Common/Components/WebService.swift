import Foundation

protocol URLSessionTaskProtocol {
    func resume()
}

extension URLSessionTask: URLSessionTaskProtocol { }

protocol URLSessionProtocol {
    init(configuration: URLSessionConfiguration)
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }

protocol WebServiceProtocol {
    func dataTask(dataTaskComponents: DataTaskComponents, completion: @escaping (RemoteResource) -> ()) -> URLSessionTaskProtocol
}

class WebService: WebServiceProtocol {
    var session: URLSessionProtocol = URLSession(configuration: .default)

    func dataTask(dataTaskComponents: DataTaskComponents, completion: @escaping (RemoteResource) -> ()) -> URLSessionTaskProtocol {
        guard let urlRequest = dataTaskComponents.urlRequest else {
            fatalError("Could not form URL request for path: \(dataTaskComponents.route.path)")
        }

        let dataTask = session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            let remoteResource = RemoteResource(statusCode: statusCode, data: data, error: error)
            completion(remoteResource)
        })

        return dataTask
    }
}
