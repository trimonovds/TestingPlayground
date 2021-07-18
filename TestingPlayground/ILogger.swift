//
//  ILogger.swift
//  TestingPlayground
//
//  Created by Дмитрий Тримонов on 18.07.2021.
//

import Foundation

public enum LogScope {
    case info
    case debug
    case error
}

//sourcery: AutoMockable
public protocol ILogger {
    func log(_ message: String, scope: LogScope)
}
