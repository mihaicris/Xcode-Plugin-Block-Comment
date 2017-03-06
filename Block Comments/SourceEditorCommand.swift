//
//  SourceEditorCommand.swift
//  Block Comments
//
//  Created by Mihai Cristescu on 06/03/2017.
//  Copyright © 2017 Mihai Cristescu. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {

        let lines: NSMutableArray = invocation.buffer.lines
        
        for selection in invocation.buffer.selections {
            
            let startLineIndex = (selection as! XCSourceTextRange).start.line
            let endLineIndex = (selection as! XCSourceTextRange).end.line
            
            if lines[startLineIndex-1] as! String == "/*\u{A}" && lines[endLineIndex+1] as! String == "*/\u{A}" {
                lines.removeObject(at: endLineIndex + 1)
                lines.removeObject(at: startLineIndex - 1)
            } else {
                lines.insert("*/\n", at: endLineIndex + 1)
                lines.insert("/*\n", at: startLineIndex )
            }
        }
        
        completionHandler(nil)
    }
    
}
