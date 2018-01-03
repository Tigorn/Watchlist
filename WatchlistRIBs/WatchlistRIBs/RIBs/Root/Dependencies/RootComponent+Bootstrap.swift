//
//  RootComponent+Bootstrap.swift
//  WatchlistRIBs
//
//  Created by Eric Drew on 1/2/18.
//  Copyright © 2018 Eric Drew. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of Root to provide for the Bootstrap scope.
// TODO: Update RootDependency protocol to inherit this protocol.
protocol RootDependencyBootstrap: Dependency {
    // TODO: Declare dependencies needed from the parent scope of Root to provide dependencies
    // for the Bootstrap scope.
}

extension RootComponent: BootstrapDependency {

    // TODO: Implement properties to provide for Bootstrap scope.
}
