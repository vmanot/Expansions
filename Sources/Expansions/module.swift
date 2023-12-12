//
// Copyright (c) Vatsal Manot
//

@_exported import _ExpansionsRuntime
@_exported import Foundation
@_exported import Swallow

@attached(member, names: arbitrary)
public macro AddCaseBoolean() = #externalMacro(
    module: "ExpansionsMacros",
    type: "AddCaseBooleanMacro"
)

@attached(peer, names: arbitrary)
public macro duplicate(as: String) = #externalMacro(
    module: "ExpansionsMacros",
    type: "GenerateDuplicateMacro"
)

@attached(member, names: named(hash), named(==))
@attached(extension, conformances: Hashable)
public macro Hashable() = #externalMacro(
    module: "ExpansionsMacros",
    type: "HashableMacro"
)

@attached(member, names: arbitrary)
@attached(extension, conformances: OptionSet)
public macro OptionSet<RawType>() = #externalMacro(
    module: "ExpansionsMacros",
    type: "OptionSetMacro"
)

@attached(peer, names: suffixed(_RuntimeTypeDiscovery))
public macro RuntimeDiscoverable() = #externalMacro(
    module: "ExpansionsMacros",
    type: "RuntimeDiscoverableMacro"
)

@attached(member, names: named(init), named(shared))
public macro Singleton() = #externalMacro(
    module: "ExpansionsMacros",
    type: "SingletonMacro"
)

@attached(member, names: arbitrary)
// @attached(extension, names: arbitrary)
public macro _StaticProtocolMember<T>(
    named: String,
    type: T.Type
) = #externalMacro(
    module: "ExpansionsMacros",
    type: "_StaticProtocolMember"
)
