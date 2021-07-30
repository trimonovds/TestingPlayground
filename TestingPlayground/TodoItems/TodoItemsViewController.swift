//
//  TodoItemsViewController.swift
//  TestingPlayground
//
//  Created by Dmitry Trimonov on 19.07.2021.
//

import UIKit

class TodoItemsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.accessibilityLabel = AccessibilityIdentifiers.StartScreen.tableView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Self.cellRi)
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(addItemButton)
        addItemButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            addItemButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            addItemButton.widthAnchor.constraint(equalToConstant: Self.addButtonSize.width),
            addItemButton.heightAnchor.constraint(equalToConstant: Self.addButtonSize.height),
            addItemButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        token = model.addListener(self)
        refresh()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.itemsCount
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editor = TodoItemEditorViewController()
        editor.mode = .update(item: model.items[indexPath.row])
        editor.delegate = self
        present(editor, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellRi, for: indexPath)
        let item = model.items[indexPath.row]
        cell.textLabel?.text = item.text
        cell.accessibilityLabel = item.text
        return cell
    }
    
    deinit {
        model.removeListener(token: token)
    }
    
    private lazy var addItemButton: UIButton = {
        let res = UIButton(type: .system)
        res.accessibilityIdentifier = AccessibilityIdentifiers.StartScreen.addItemButton
        res.setTitle("+", for: .normal)
        res.setTitleColor(.white, for: .normal)
        res.backgroundColor = .systemBlue
        res.layer.cornerRadius = Self.addButtonSize.height / 2
        res.addTarget(self, action: #selector(onAddButtonTouchUpInside), for: .touchUpInside)
        return res
    }()
    
    private let tableView = UITableView()
    private let model = TodoItemsModel()
    private var token: TodoItemsModel.Token!
    
    private static let cellRi = "Cell"
    private static let addButtonSize = CGSize(width: 64, height: 64)
}

extension TodoItemsViewController: TodoItemsModelListener {
    func onModelDidUpdateItems() {
        refresh()
    }
}

extension TodoItemsViewController: TodoItemEditorViewControllerDelegate {
    func editorDidFinish(_ editor: TodoItemEditorViewController, withResult result: TodoItemEditorViewController.Result) {
        switch result {
        case .created(let newItem):
            model.addItem(newItem)
        case .updated(let updatedItem):
            model.updateItem(updatedItem)
        }
        editor.dismiss(animated: true, completion: nil)
    }
}

extension TodoItemsViewController {
    private func refresh() {
        tableView.reloadData()
    }
    
    @objc private func onAddButtonTouchUpInside() {
        let editor = TodoItemEditorViewController()
        editor.mode = .create
        editor.delegate = self
        present(editor, animated: true, completion: nil)
    }
}

