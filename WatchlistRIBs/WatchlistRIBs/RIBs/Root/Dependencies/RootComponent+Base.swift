import RIBs

/// The dependencies needed from the parent scope of Root to provide for the Base scope.
// TODO: Update RootDependency protocol to inherit this protocol.
protocol RootDependencyBase: Dependency {}

extension RootComponent: BaseDependency {
    
}
