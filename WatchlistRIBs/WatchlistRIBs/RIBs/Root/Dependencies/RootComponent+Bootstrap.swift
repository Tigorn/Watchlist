import RIBs

protocol RootDependencyBootstrap: Dependency {}

extension RootComponent: BootstrapDependency {}
