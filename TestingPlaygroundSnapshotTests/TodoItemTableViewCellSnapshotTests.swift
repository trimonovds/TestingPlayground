//
//  TodoItemTableViewCellTests.swift
//  TestingPlaygroundSnapshotTests
//
//  Created by Дмитрий Тримонов on 30.07.2021.
//

import XCTest
import SnapshotTesting
@testable import TestingPlayground

class TodoItemTableViewCellSnapshotTests: XCTestCase {
    private let frame: CGRect = .init(x: 0, y: 0, width: 128, height: 0)
    
    func testCell() {
        let cell = TodoItemTableViewCell(frame: frame)
        cell.render(TodoItemTableViewCell.ViewState(title: "Hello", image: UIImage(systemName: "multiply.circle.fill")!))
        let result = verifySnapshot(matching: cell, as: .image, named: "Default", record: false, testName: "TodoItemCell")
        XCTAssertNil(result)
    }
}
