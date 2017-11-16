import UIKit

enum TaskError: Error {
    case requestFailed(statusCode: Int?)
    case parsingFailed
    case cancelled
}

class Task<Observer: ServiceObserverProtocol> {
    let webService: WebServiceProtocol
    let dataTaskComponents: DataTaskComponents
    let observers: [Observer]

    init(webService: WebServiceProtocol, dataTaskComponents: DataTaskComponents, observers: [Observer]) {
        self.webService = webService
        self.dataTaskComponents = dataTaskComponents
        self.observers = observers
    }

    func executeJSONTask<T>(forType type: T.Type) where T: Decodable, T == Observer.Object {
        observers.forEach { $0.didStart() }
        let task  = webService.dataTask(dataTaskComponents: dataTaskComponents) { remoteResource in
            defer {
                self.observers.forEach { $0.didFinish() }
            }

            guard remoteResource.isStatusCodeValid,
                let data = remoteResource.data else {
                    self.observers.forEach { $0.didFail(errors: [TaskError.requestFailed(statusCode: remoteResource.statusCode)]) }
                    return
            }

            guard !remoteResource.isErrorCancelled else {
                self.observers.forEach { $0.didFail(errors: [TaskError.cancelled]) }
                return
            }

            if let object = try? JSONDecoder().decode(type, from: data) {
                self.observers.forEach { $0.didSucceed(value: object) }
            } else {
                self.observers.forEach { $0.didFail(errors: [TaskError.parsingFailed]) }
            }
        }

        task.resume()
    }
}
