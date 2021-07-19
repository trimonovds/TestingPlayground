//
//  ModelTests.swift
//  TestingPlaygroundTests
//
//  Created by Дмитрий Тримонов on 18.07.2021.
//

import XCTest
@testable import TestingPlayground

class ManualLoggerMock: ILogger {
    var logInvoked: Int = 0
    var lastLogScope: LogScope?
    
    func log(_ message: String, scope: LogScope) {
        logInvoked += 1
        lastLogScope = scope
    }
}

class ManualMockModelTests: XCTestCase {

    func testFetchPerformsLoggingWithInfoScope() {
        // Arrange
        let loggerMock = ManualLoggerMock()
        let sut = Model(logger: loggerMock)
        
        // Act
        sut.fetch()
        
        // Asssert
        XCTAssert(loggerMock.logInvoked == 1)
        XCTAssert(loggerMock.lastLogScope == .info)
    }

}
