//
//  TestingPlaygroundUITests.swift
//  TestingPlaygroundUITests
//
//  Created by Дмитрий Тримонов on 18.07.2021.
//

import XCTest

class TodoItemsUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testWhenTypeSomeTextAndAddItemThenVisibleTextIs1() throws {
        
    }
    
    func testWhenTypeSomeTextAndClearThenAddItemButtonIsDisabled() {
        
    }
    
    func testWhenTypeSomeTextThenAddItemButtonIsEnabled() {
        
    }
}
