//
// Copyright (c) Vatsal Manot
//

import SwiftCompilerPlugin
import SwiftSyntaxMacros
import Expansions

public protocol MacrosProviding: CompilerPlugin {
    
}

// MARK: - Implementation

extension MacrosProviding {
    public var providingMacros: [Macro.Type] {
        RuntimeDiscoverableTypes.enumerate((any Macro).self)
    }
}
