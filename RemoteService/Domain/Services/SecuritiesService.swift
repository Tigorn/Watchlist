import Foundation
import Domain

public protocol SecuritiesServiceProtocol {
    func getTickers<Type>(forCurrencySymbols symbols: [String], observers: [Type]) -> Command where Type : ServiceObserverProtocol, Type.Object == [Currency]
}

public class SecuritiesService: SecuritiesServiceProtocol {
    var webService: WebServiceProtocol = WebService()

    public init() { }

    public func getTickers<Type>(forCurrencySymbols symbols: [String], observers: [Type]) -> Command where Type : ServiceObserverProtocol, Type.Object == [Currency] {
        return Command {
            let queryValue = symbols.joined(separator: ",")
            let queryItem = URLQueryItem(name: "symbols", value: queryValue)
            let dataTaskComponents = DataTaskComponents(route: Route.tickers, queryItems: [queryItem])
            let task = Task(webService: self.webService, dataTaskComponents: dataTaskComponents, observers: observers)
            task.executeJSONTask(forType: [Currency].self)
        }
    }
}
