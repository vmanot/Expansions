//
// Copyright (c) Vatsal Manot
//

@_exported import Foundation

/// A macro that generate `var isCaseNmae: Bool` computed properties per enum cases that have asociated value.
///
/// for example below source code
///
///    ```swift
///     @AddCaseBoolean
///     enum E {
///         case simple
///         case foo(Int)
///     }
///    ```
///
/// will generate `isFoo` computed property.
///
///    ```swift
///    var isFoo: Bool {
///        if case .foo = self {
///            return true
///        }
///        return false
///    }
///    ```
///
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
