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
    
    func testWhenAddItemThenItemAppearsInTable() {
        let addButton = app.buttons[AccessibilityIdentifiers.StartScreen.addItemButton]
        addButton.tap()
        
        let itemTextInput = app.textFields[AccessibilityIdentifiers.EditorScreen.inputTextField]
        let inputText = "First Item"
        itemTextInput.tap()
        itemTextInput.typeText(inputText)
        
        let saveButton: XCUIElement = app.buttons[AccessibilityIdentifiers.EditorScreen.saveButton]
        saveButton.tap()
        
        let table = app.tables[AccessibilityIdentifiers.StartScreen.tableView]
        XCTAssertTrue(table.cells.element(boundBy: 0).label.contains(inputText))
    }
    
    func testScenario1() {
        let addButton = app.buttons[AccessibilityIdentifiers.StartScreen.addItemButton]
        addButton.tap()
        
        let itemTextInput = app.textFields[AccessibilityIdentifiers.EditorScreen.inputTextField]
        let inputText = "First Item"
        itemTextInput.tap()
        itemTextInput.typeText(inputText)
        
        let saveButton: XCUIElement = app.buttons[AccessibilityIdentifiers.EditorScreen.saveButton]
        saveButton.tap()
        
        let table = app.tables[AccessibilityIdentifiers.StartScreen.tableView]
        table.cells.element(boundBy: 0).tap()
        
        let editedText = "some text"
        itemTextInput.tap()
        itemTextInput.typeText(String(repeating: XCUIKeyboardKey.delete.rawValue, count: inputText.count))
        itemTextInput.typeText(editedText)
        saveButton.tap()
        
        XCTAssertTrue(table.cells.element(boundBy: 0).label.contains(editedText))
    }
}
