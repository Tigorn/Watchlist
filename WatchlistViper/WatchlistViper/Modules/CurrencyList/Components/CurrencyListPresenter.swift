import UIKit
import Domain

protocol CurrencyListPresenterInputProtocol: class {
    func getCurrencies()
    func didEditAction()
}

class CurrencyListPresenter {
    weak var view: CurrencyListViewInputProtocol?
    var interactor: CurrencyListInteractorInputProtocol?
    var router: CurrencyListRouterProtocol?
}

extension CurrencyListPresenter: CurrencyListPresenterInputProtocol {
    func didEditAction() {
        if let view = view as? UIViewController {
            DispatchQueue.main.async {
                self.router?.showEdit(from: view)
            }
        }
    }

    func getCurrencies() {
        interactor?.getCurrencies()
    }
}

extension CurrencyListPresenter: CurrencyListInteractorOutputProtocol {    
    func getCurrenciesDidFail() {
        DispatchQueue.main.async {
            self.view?.requestFailed()
        }
    }

    func didGet(currencies: [Currency]) {
        DispatchQueue.main.async {
            self.view?.show(currencies: currencies)
        }
    }
}
