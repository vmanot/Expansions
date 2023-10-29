//
// Copyright (c) Vatsal Manot
//

import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
public struct module: CompilerPlugin {
    public let providingMacros: [Macro.Type] = [
        AddCaseBooleanMacro.self,
        RuntimeDiscoverableMacro.self
    ]
    
    public init() {
        
    }
}
