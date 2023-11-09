//
// Copyright (c) Vatsal Manot
//

import Swift
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

enum CustomError {
    struct _CustomErrorMessage: DiagnosticMessage, Error {
        let message: String
        let diagnosticID: MessageID
        let severity: DiagnosticSeverity
    }
    
    enum ErrorMacroUsage: Error, CustomStringConvertible {
        case message(String)
        
        var description: String {
            switch self {
                case .message(let text): return text
            }
        }
    }
    
    static func diagnostic(
        node: Syntax,
        position: AbsolutePosition? = nil,
        message: _CustomErrorMessage,
        highlights: [Syntax]? = nil,
        notes: [Note] = [],
        fixIts: [FixIt] = []
    ) -> Diagnostic {
        Diagnostic(
            node: node,
            message: message
        )
    }
    
    static func message(_ message: String) -> ErrorMacroUsage {
        .message(message)
    }
}

extension CustomError._CustomErrorMessage: FixItMessage {
    var fixItID: MessageID {
        diagnosticID
    }
}
