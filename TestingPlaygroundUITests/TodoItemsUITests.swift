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
        let itemTextInput = app.textFields[AccessibilityIdentifiers.StartScreen.itemTextInputField]
        let addButton: XCUIElement = app.buttons[AccessibilityIdentifiers.StartScreen.addButton]
        let itemsCountLabel = app.staticTexts[AccessibilityIdentifiers.StartScreen.itemsCountLabel]
        itemTextInput.tap()
        itemTextInput.typeText("Finish iOS course")
        addButton.tap()
        XCTAssertTrue(itemsCountLabel.label == "1")
    }
    
    func testWhenTypeSomeTextAndClearThenAddItemButtonIsDisabled() {
        let itemTextInput = app.textFields[AccessibilityIdentifiers.StartScreen.itemTextInputField]
        let addButton: XCUIElement = app.buttons[AccessibilityIdentifiers.StartScreen.addButton]
        itemTextInput.tap()
        let inputText = "Asdaasd"
        itemTextInput.typeText(inputText)
        itemTextInput.typeText(String(repeating: XCUIKeyboardKey.delete.rawValue, count: inputText.count))
        XCTAssertFalse(addButton.isEnabled)
    }
    
    func testWhenTypeSomeTextThenAddItemButtonIsEnabled() {
        let itemTextInput = app.textFields[AccessibilityIdentifiers.StartScreen.itemTextInputField]
        let addButton: XCUIElement = app.buttons[AccessibilityIdentifiers.StartScreen.addButton]
        itemTextInput.tap()
        itemTextInput.typeText("Asdaasd")
        XCTAssertTrue(addButton.isEnabled)
    }
}
