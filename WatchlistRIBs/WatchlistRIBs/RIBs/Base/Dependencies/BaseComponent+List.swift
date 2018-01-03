import RIBs

protocol BaseDependencyList: Dependency {}

extension BaseComponent: ListDependency {
    var currencySymbolStream: CurrencySymbolStreamProtocol {
        return mutableCurrencySymbolStream
    }
}
