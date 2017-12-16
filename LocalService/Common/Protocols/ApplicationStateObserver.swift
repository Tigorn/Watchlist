import Foundation

@objc public protocol ApplicationStateObserver: class {
    @objc optional func applicationDidBecomeActive()
    @objc optional func applicationDidEnterBackground()
}

public extension ApplicationStateObserver {
    func startObservingApplicationState() {
        NotificationCenter.default.addObserver(forName: .UIApplicationDidEnterBackground, object: nil, queue: nil) { [weak self] _ in
            self?.applicationDidEnterBackground?()
        }

        NotificationCenter.default.addObserver(forName: .UIApplicationDidBecomeActive, object: nil, queue: nil) { [weak self] _ in
            self?.applicationDidBecomeActive?()
        }
    }

    func stopObservingApplicationState() {
        NotificationCenter.default.removeObserver(self, name: .UIApplicationDidBecomeActive, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIApplicationDidEnterBackground, object: nil)
    }
}
