import UIKit

class BootstrapPresenter {
    weak var view: BootstrapViewInputProtocol?
    var interactor: BootstrapInteractorInputProtocol?
    var router: BootstrapRouterProtocol?
}

extension BootstrapPresenter: BootstrapViewOutputProtocol {
    func bootstrap() {
        interactor?.bootstrap()
    }
}

extension BootstrapPresenter: BootstrapInteractorOutputProtocol {
    func didFinishBootstrap() {
        DispatchQueue.main.async {
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = self.router?.rootViewController()
            window.makeKeyAndVisible()
            self.view?.set(window: window)
        }
    }
}
