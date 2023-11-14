//
// Copyright (c) Vatsal Manot
//

import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
public struct module: CompilerPlugin {
    public let providingMacros: [Macro.Type] = [
        GenerateDuplicateMacro.self,
        AddCaseBooleanMacro.self,
        HashableMacro.self,
        OptionSetMacro.self,
        RuntimeDiscoverableMacro.self,
        SingletonMacro.self,
    ]
    
    public init() {
        
    }
}
