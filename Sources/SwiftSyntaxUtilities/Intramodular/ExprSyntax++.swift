//
// Copyright (c) Vatsal Manot
//

import Swallow
import SwiftSyntax

extension ExprSyntax {
    func _decodeLiteralValueOrAsString() throws -> AnyCodable? {
        do {
            return try decodeLiteral()
        } catch {
            if let decl = self.as(MemberAccessExprSyntax.self.self)?.base?
                .as(DeclReferenceExprSyntax.self) {
                return .string(decl.baseName.text)
            } else {
                throw _PlaceholderError()
            }
        }
    }
    
    public func decodeLiteral() throws -> AnyCodable? {
        // TODO: Improve this.
        enum _Error: Swift.Error {
            case failure
        }
        
        if let expression = self.as(BooleanLiteralExprSyntax.self) {
            switch expression.literal.tokenKind {
                case .keyword(.true):
                    return .bool(true)
                case .keyword(.false):
                    return .bool(false)
                default:
                    throw _Error.failure
            }
        } else if let _ = self.as(DictionaryExprSyntax.self) {
            fatalError()
        } else if let expression = self.as(NilLiteralExprSyntax.self) {
            _ = expression
            
            return nil
        } else if let expression = self.as(StringLiteralExprSyntax.self) {
            let segment = try expression.segments
                .toCollectionOfOne()
                .value
                .as(StringSegmentSyntax.self)
                .unwrap()
            
            switch segment.content.tokenKind {
                case .stringSegment(let text):
                    return .string(text)
                default:
                    throw _Error.failure
            }
        } else {
            throw CustomStringError(description: "Unsupported")
        }
    }
}
