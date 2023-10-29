//
// Copyright (c) Vatsal Manot
//

import Runtime
import Swift

public final class RuntimeDiscoverableTypes {
    private static var cache: [Any.Type]?

    public static func enumerate() -> [Any.Type] {
        if let cache = cache {
            return cache
        }
        
        let allClasses = Array(ObjCClass.allCases)
        let superclass = ObjCClass(_RuntimeTypeDiscovery.self)
        
        let result = allClasses
            .filter({ $0.superclass == superclass })
            .map({ $0.value as! _RuntimeTypeDiscovery.Type })
            .map({ $0.type })
        
        cache = result
        
        return result
    }
    
    public static func _enumerateConformingTypes<T, U>(
        conformingTo type: T.Type = T.self,
        as resultType: Array<U>.Type = Array<U>.self
    ) -> [U] {
        enumerate().filter({ TypeMetadata($0).conforms(to: type) }).map({ $0 as! U })
    }
}

@propertyWrapper
public struct RuntimeDiscoveredTypes<T, U> {
    public let type: T.Type
    public let wrappedValue: [U]
    
    public init(type: T.Type) {
        self.type = type
        self.wrappedValue = RuntimeDiscoverableTypes._enumerateConformingTypes(conformingTo: type)
    }
}

@objc open class _RuntimeTypeDiscovery: NSObject {
    open class var type: Any.Type {
        assertionFailure()
        
        return Never.self
    }
}
