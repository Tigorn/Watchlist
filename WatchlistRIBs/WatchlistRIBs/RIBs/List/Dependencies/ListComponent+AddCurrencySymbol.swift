import RIBs

/// The dependencies needed from the parent scope of List to provide for the AddCurrencySymbol scope.
// TODO: Update ListDependency protocol to inherit this protocol.
protocol ListDependencyAddCurrencySymbol: Dependency {
    // TODO: Declare dependencies needed from the parent scope of List to provide dependencies
    // for the AddCurrencySymbol scope.
}

extension ListComponent: AddCurrencySymbolDependency {

    // TODO: Implement properties to provide for AddCurrencySymbol scope.
}
