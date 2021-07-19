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

    func testWhenAddItemItemsCountTestIs1() throws {
        app.buttons[AccessibilityIdentifiers.StartScreen.addButton].tap()
        XCTAssertTrue(app.staticTexts[AccessibilityIdentifiers.StartScreen.itemsCountLabel].exists)
        XCTAssertTrue(app.staticTexts[AccessibilityIdentifiers.StartScreen.itemsCountLabel].label == "1")
    }
    
    func testWhenAddSomeItemsAndRemoveAllYouCanSeeZero() throws {
        let addButton: XCUIElement = app.buttons[AccessibilityIdentifiers.StartScreen.addButton]
        addButton.tap()
        addButton.tap()
        app.buttons[AccessibilityIdentifiers.StartScreen.removeButton].tap()
        XCTAssertTrue(app.staticTexts[AccessibilityIdentifiers.StartScreen.itemsCountLabel].label == "0")
    }
    
}
