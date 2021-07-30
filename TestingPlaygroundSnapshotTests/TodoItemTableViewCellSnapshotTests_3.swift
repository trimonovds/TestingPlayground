//
//  TodoItemTableViewCellSnapshotTests_3.swift
//  TestingPlaygroundSnapshotTests
//
//  Created by Dmitry Trimonov on 30.07.2021.
//

import XCTest
import SnapshotTesting
@testable import TestingPlayground

class TodoItemTableViewCellSnapshotTests_3: XCTestCase {

    let record = false

    func testOnelineCell() {
        let viewState = TodoItemTableViewCell.ViewState(
            title: "ASdmnasmdqw;elqm asldmnqkwjnekqjnwema sdqweqwbeqkwjebq",
            image: UIImage(systemName: "multiply.circle.fill")!,
            titleNumOfLines: 1
        )
        assertCellSnapshot(viewState: viewState, named: "Oneline", testName: "TodoItemCell")
    }
    
    func testMultilineCell() {
        let viewState = TodoItemTableViewCell.ViewState(
            title: "ASdmnasmdqw;elqm asldmnqkwjnekqjnwema sdqweqwbeqkwjebq",
            image: UIImage(systemName: "multiply.circle.fill")!,
            titleNumOfLines: 0
        )
        assertCellSnapshot(viewState: viewState, named: "Multiline", testName: "TodoItemCell")
    }
    
    private func assertCellSnapshot(viewState: TodoItemTableViewCell.ViewState, named: String, testName: String) {
        let cell = TodoItemTableViewCell()
        cell.render(viewState)
        let fixedWidth: CGFloat = 375
        let systemLayoutSize = cell.systemLayoutSizeFitting(CGSize(width: fixedWidth, height: 0), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        cell.frame = CGRect(origin: .zero, size: CGSize(width: fixedWidth, height: systemLayoutSize.height))
        assertSnapshot(matching: cell, as: .image, named: named, record: record, testName: testName)
    }
}
