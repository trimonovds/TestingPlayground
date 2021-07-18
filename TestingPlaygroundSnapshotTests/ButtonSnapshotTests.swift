//
//  ButtonTests.swift
//  TestingPlaygroundSnapshotTests
//
//  Created by Дмитрий Тримонов on 18.07.2021.
//

import XCTest
import SnapshotTesting
@testable import TestingPlayground

class ButtonSnapshotTests: XCTestCase {
    private let frame: CGRect = .init(x: 0, y: 0, width: 128, height: 48)
    
    func testButtonDefaultState() {
        let button = Button(frame: frame)
        button.setTitle("Login", for: .normal)
        let result = verifySnapshot(matching: button, as: .image, named: "Default", testName: "Button")
        XCTAssertNil(result)
    }
    
    func testButtonLoadingState() {
        let button = Button(frame: frame)
        button.setTitle("Login", for: .normal)
        button.isLoading = true
        let result = verifySnapshot(matching: button, as: .image, named: "Loading", testName: "Button")
        XCTAssertNil(result)
    }
}
