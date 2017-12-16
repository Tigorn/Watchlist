import Foundation
import PromiseKit
import RemoteService

public protocol SecuritiesServiceProtocol {
    func getTickers(forCurrencySymbols symbols: [String]) -> Promise<[Currency]>
}

public class SecuritiesService {
    var task: TaskProtocol

    public init() {
        task = Task(webService: WebService())
    }
}

extension SecuritiesService: SecuritiesServiceProtocol {
    public func getTickers(forCurrencySymbols symbols: [String]) -> Promise<[Currency]> {
        let queryValue = symbols.joined(separator: ",")
        let queryItem = URLQueryItem(name: "symbols", value: queryValue)
        let dataTaskComponents = DataTaskComponents(route: Route.tickers, queryItems: [queryItem])
        return task.decodableTaskPromise(dataTaskComponents: dataTaskComponents, forType: [Currency].self)
    }
}
