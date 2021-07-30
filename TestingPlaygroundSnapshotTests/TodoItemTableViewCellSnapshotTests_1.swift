//
//  TodoItemTableViewCellSnapshotTests_1.swift
//  TestingPlaygroundSnapshotTests
//
//  Created by Dmitry Trimonov on 30.07.2021.
//

import XCTest
import SnapshotTesting
@testable import TestingPlayground

class TodoItemTableViewCellSnapshotTests_1: XCTestCase {
    
    let record = false
    
    func testAllCellStates() {
        let tableViewController = TableViewController()
        tableViewController.viewStates = [
            TodoItemTableViewCell.ViewState(
                title: "ASdmnasmdqw;elqm asldmnqkwjnekqjnwema sdqweqwbeqkwjebq",
                image: UIImage(systemName: "multiply.circle.fill")!,
                titleNumOfLines: 1
            ),
            TodoItemTableViewCell.ViewState(
                title: "ASdmnasmdqw;elqm asldmnqkwjnekqjnwema sdqweqwbeqkwjebq",
                image: UIImage(systemName: "multiply.circle.fill")!,
                titleNumOfLines: 0
            )
        ]
        assertSnapshot(matching: tableViewController, as: .image(on: .iPhoneSe), named: "AllStates", record: record, testName: "TodoItemCell")
    }

}

class TableViewController: UITableViewController {
    var viewStates: [TodoItemTableViewCell.ViewState] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.backgroundColor = .clear
        tableView.register(TodoItemTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewStates.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TodoItemTableViewCell
        cell.render(viewStates[indexPath.row])
        cell.backgroundColor = .clear
        return cell
    }
}
