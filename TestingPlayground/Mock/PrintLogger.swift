//
//  PrintLogger.swift
//  TestingPlayground
//
//  Created by Дмитрий Тримонов on 18.07.2021.
//

import Foundation

class PrintLogger: ILogger {
    func log(_ message: String, scope: LogScope) {
        debugPrint("[\(scope)]: \(message)")
    }
}
