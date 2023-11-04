//
// Copyright (c) Vatsal Manot
//

import Swallow
import SwiftSyntax

extension AnyCodable {
    public init(_ exprList: LabeledExprListSyntax) throws {
        self = .dictionary(
            Dictionary(
                try exprList.map {
                    let key = try AnyCodingKey(stringLiteral: $0.labelText.unwrap())
                    let value = try $0.expression.decodeLiteral()
                    
                    return (key, value)
                },
                uniquingKeysWith: { lhs, rhs in
                    assertionFailure()
                    
                    return rhs
                }
            )
            .compactMapValues({ $0 })
        )
    }
}

extension LabeledExprSyntax {
    public var labelText: String? {
        label?.trimmed.text
    }
}

extension ExprSyntax {
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
        } else if let expression = self.as(NilLiteralExprSyntax.self.self) {
            _ = expression
            
            return nil
        } else if let expression = self.as(StringLiteralExprSyntax.self.self) {
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
            fatalError()
        }
    }
}
