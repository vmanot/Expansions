//
// Copyright (c) Vatsal Manot
//

import Swift

@main
struct module: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        AddCaseBooleanMacro.self
    ]
}
