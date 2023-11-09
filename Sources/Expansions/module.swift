//
// Copyright (c) Vatsal Manot
//

@_exported import Foundation

@attached(member, names: arbitrary)
public macro AddCaseBoolean() = #externalMacro(
    module: "ExpansionsMacros",
    type: "AddCaseBooleanMacro"
)

@attached(member, names: named(hash), named(==))
@attached(extension, conformances: Hashable)
public macro Hashable() = #externalMacro(module: "ExpansionsMacros", type: "HashableMacro")

@attached(peer, names: suffixed(_RuntimeTypeDiscovery))
public macro RuntimeDiscoverable() = #externalMacro(
    module: "ExpansionsMacros",
    type: "RuntimeDiscoverableMacro"
)

@attached(member, names: named(init), named(shared))
public macro Singleton() = #externalMacro(module: "ExpansionsMacros", type: "SingletonMacro")

// MARK: - Debug

@attached(peer, names: arbitrary)
public macro duplicate(as: String) = #externalMacro(
    module: "ExpansionsMacros",
    type: "GenerateDuplicateMacro"
)
