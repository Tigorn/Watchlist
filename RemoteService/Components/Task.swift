import PromiseKit
import UIKit

public enum DataServiceError: Error {
    case requestFailed(statusCode: Int?)
    case cancelled
}

public protocol TaskProtocol {
    func decodableTaskPromise<Type>(dataTaskComponents: DataTaskComponents, forType type: Type.Type) -> Promise<Type> where Type: Decodable
}

public class Task: TaskProtocol {
    let webService: WebServiceProtocol
    var task: URLSessionTaskProtocol?

    public init(webService: WebServiceProtocol) {
        self.webService = webService
    }

    public func decodableTaskPromise<Type>(dataTaskComponents: DataTaskComponents, forType type: Type.Type) -> Promise<Type> where Type: Decodable {
        return Promise<Type> { fulfill, reject in
            let task = webService.dataTask(dataTaskComponents: dataTaskComponents) { remoteResource in
                guard remoteResource.isStatusCodeValid,
                    let data = remoteResource.data else {
                    reject(DataServiceError.requestFailed(statusCode: remoteResource.statusCode))
                    return
                }

                guard !remoteResource.isErrorCancelled else {
                    reject(DataServiceError.cancelled)
                    return
                }

                do {
                    let object = try JSONDecoder().decode(type, from: data)
                    fulfill(object)
                } catch {
                    reject(error)
                }
            }

            task.resume()
            self.task = task
        }
    }

    func cancel() {
        task?.cancel()
        task = nil
    }
}
