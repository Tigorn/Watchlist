import UIKit

class BootstrapPresenter {
    var interactor: BootstrapInteractorInputProtocol?
    var router: BootstrapRouterInputProtocol?
}

extension BootstrapPresenter: BootstrapViewOutputProtocol {
    func bootstrap(window: UIWindow) {
        router?.setRootviewController(window: window)
        router?.makeWindowKeyAndVisible(window: window)

        if let viewController = window.rootViewController {
            router?.showLoading(from: viewController)
        }

        interactor?.bootstrap()
    }
}

extension BootstrapPresenter: BootstrapInteractorOutputProtocol {
    func didFinishBootstrap() {
        DispatchQueue.main.async {
            self.router?.dismissLoading()
        }
    }
}
