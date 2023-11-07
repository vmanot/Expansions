//
// Copyright (c) Vatsal Manot
//

import Swift
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

enum MacroDiagnostics {
    struct Message: DiagnosticMessage, Error {
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
        message: Message,
        highlights: [Syntax]? = nil,
        notes: [Note] = [],
        fixIts: [FixIt] = []
    ) -> Diagnostic {
        Diagnostic(
            node: node,
            message: message
        )
    }
    
    static func errorMacroUsage(message: String) -> ErrorMacroUsage {
        .message(message)
    }
}

extension MacroDiagnostics.Message: FixItMessage {
    var fixItID: MessageID {
        diagnosticID
    }
}
