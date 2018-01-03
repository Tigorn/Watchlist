import RIBs
import RxSwift
import UIComponents
import Domain
import PromiseKit

protocol ListRouting: ViewableRouting {}

protocol ListPresentable: Presentable {
    weak var listener: ListPresentableListener? { get set }
    func requestFailed()
    func show(data: CurrencyListCurrencyDisplayData)
}

protocol ListListener: class {}

final class ListInteractor: PresentableInteractor<ListPresentable>, ListInteractable, ListPresentableListener {
    weak var router: ListRouting?
    weak var listener: ListListener?

    init(presenter: ListPresentable, currencySymbolStream: CurrencySymbolStreamProtocol, securitiesService: SecuritiesServiceProtocol) {
        self.securitiesService = securitiesService
        self.currencySymbolStream = currencySymbolStream
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        updateSymbols()
    }

    //MARK: - ListPresentableListener

    func refresh() {
        guard let symbols = symbols else {
            return
        }

        firstly {
            securitiesService.getTickers(forCurrencySymbols: symbols.map { $0.symbol })
        }.then { [weak self] currencies -> Void in
            let data = CurrencyListCurrencyDisplayData(currencies: currencies)
            self?.presenter.show(data: data)
        }.catch { [weak self] _ in
            self?.presenter.requestFailed()
        }
    }

    //MARK: - Private

    private var symbols: [CurrencySymbol]?
    private let currencySymbolStream: CurrencySymbolStreamProtocol
    private let securitiesService: SecuritiesServiceProtocol

    private func updateSymbols() {
        currencySymbolStream.symbols.subscribe(onNext: { symbols in
            self.symbols = symbols
            self.refresh()
        }).disposeOnDeactivate(interactor: self)
    }
}
