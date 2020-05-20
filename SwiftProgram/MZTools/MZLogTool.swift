//
//  MZLogTool.swift
//  SwiftProgram
//
//  Created by Mr.Z on 2020/5/14.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

import UIKit

class MZLogTool: NSObject {
    
    /// 日志
    static func debugLog <T> (_ message: T, file: String = #file, function: String = #function, line: Int = #line) {
        #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("[FileName:\(fileName)][Line:\(line)][Func:\(function)]\(message)")
        #endif
    }
}
