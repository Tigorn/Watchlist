import Foundation

public protocol ServiceObserverProtocol {
    associatedtype Object
    func didStart()
    func didSucceed(value: Object)
    func didFail(errors: [Error])
    func didFinish()
}

public class ServiceObserver<Object>: ServiceObserverProtocol {
    var onStart:    (() -> ())?
    var onSuccess:  ((Object) -> ())?
    var onFailure:  (([Error]) -> ())?
    var onFinish:   (() -> ())?

    public init(onStart:    (() -> ())? = nil,
                onSuccess:  ((Object) ->())? = nil,
                onFailure:  (([Error]) -> ())? = nil,
                onFinish:   (() -> ())? = nil) {
        self.onStart = onStart
        self.onSuccess = onSuccess
        self.onFailure = onFailure
        self.onFinish = onFinish
    }

    public func didStart() {
        onStart?()
    }

    public func didFail(errors: [Error]) {
        onFailure?(errors)
    }

    public func didFinish() {
        onFinish?()
    }

    public func didSucceed(value: Object) {
        onSuccess?(value)
    }
}
