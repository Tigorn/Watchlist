import RIBs

/// The dependencies needed from the parent scope of List to provide for the EditCurrencySymbolList scope.
// TODO: Update ListDependency protocol to inherit this protocol.
protocol ListDependencyEditCurrencySymbolList: Dependency {
    // TODO: Declare dependencies needed from the parent scope of List to provide dependencies
    // for the EditCurrencySymbolList scope.
}

extension ListComponent: EditCurrencySymbolListDependency {

    // TODO: Implement properties to provide for EditCurrencySymbolList scope.
}
