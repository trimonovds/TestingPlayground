//
//  TodoItemTableViewCellTests_2.swift
//  TestingPlaygroundSnapshotTests
//
//  Created by Дмитрий Тримонов on 30.07.2021.
//

import XCTest
import SnapshotTesting
@testable import TestingPlayground

class TodoItemTableViewCellSnapshotTests_2: XCTestCase {
    
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
        let container = TableViewCellSnapshotContainer<TodoItemTableViewCell>(width: 375, configureCell: { cell in
            cell.render(viewState)
        })
        assertSnapshot(matching: container, as: .image, named: named, record: record, testName: testName)
    }
}


// https://osinski.dev/posts/snapshot-testing-self-sizing-table-view-cells/
final class TableViewCellSnapshotContainer<Cell: UITableViewCell>: UIView, UITableViewDataSource, UITableViewDelegate {
    typealias CellConfigurator = (_ cell: Cell) -> ()
    typealias HeightResolver = ((_ width: CGFloat) -> (CGFloat))

    private let tableView = SnapshotTableView()
    private let configureCell: (Cell) -> ()
    private let heightForWidth: ((CGFloat) -> CGFloat)?
    
    /// Initializes container view for cell testing.
    ///
    /// - Parameters:
    ///   - width: Width of cell
    ///   - configureCell: closure which is passed to `tableView:cellForRowAt:` method to configure cell with content.
    ///   - cell: Instance of `Cell` dequeued in `tableView:cellForRowAt:`
    ///   - heightForWidth: closure which is passed to `tableView:heightForRowAt:` method to determine cell's height. When `nil` then `UITableView.automaticDimension` is used as cell's height. Defaults to `nil`.
    init(width: CGFloat, configureCell: @escaping CellConfigurator, heightForWidth: HeightResolver? = nil) {
        self.configureCell = configureCell
        self.heightForWidth = heightForWidth
        
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        tableView.separatorStyle = .none
        tableView.contentInset = .zero
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = .clear
        
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            widthAnchor.constraint(equalToConstant: width),
            heightAnchor.constraint(greaterThanOrEqualToConstant: 1.0)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        configureCell(cell)
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForWidth?(frame.width) ?? UITableView.automaticDimension
    }
}

/// `UITableView` subclass for snapshot testing. Automatically resizes to its content size.
final class SnapshotTableView: UITableView {
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
