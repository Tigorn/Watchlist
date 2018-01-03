import RxSwift
import Domain

protocol CurrencySymbolStreamProtocol: class {
    var symbols: Observable<[CurrencySymbol]> { get }
}

protocol MutableCurrencySymbolStreamProtocol: CurrencySymbolStreamProtocol {
    func update(currencySymbols: [CurrencySymbol])
}

class CurrencySymbolStream: MutableCurrencySymbolStreamProtocol {
    var symbols: Observable<[CurrencySymbol]> {
        return variable.asObservable()
    }

    func update(currencySymbols: [CurrencySymbol]) {
        variable.value = currencySymbols
    }

    //MARK: - Private

    private let variable = Variable<[CurrencySymbol]>([])
}
