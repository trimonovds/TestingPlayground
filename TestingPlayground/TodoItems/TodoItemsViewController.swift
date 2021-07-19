//
//  TodoItemsViewController.swift
//  TestingPlayground
//
//  Created by Dmitry Trimonov on 19.07.2021.
//

import UIKit

class TodoItemsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        [addButton, removeButton, itemsCountLabel].forEach {
            stack.addArrangedSubview($0)
        }
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -64),
            stack.leftAnchor.constraint(equalTo: view.leftAnchor),
            stack.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        
        token = model.addListener(self)
        updateUI()
    }
    
    deinit {
        model.removeListener(token: token)
    }
    
    private lazy var itemsCountLabel: UILabel = {
        let res = UILabel()
        res.accessibilityIdentifier = AccessibilityIdentifiers.StartScreen.itemsCountLabel
        setupLabel(res)
        return res
    }()
    
    private lazy var addButton: UIButton = {
        let res = UIButton(type: .system)
        res.accessibilityIdentifier = AccessibilityIdentifiers.StartScreen.addButton
        res.setTitle("Add item", for: .normal)
        setupButton(res)
        res.addTarget(self, action: #selector(onAddButtonTouchUpInside), for: .touchUpInside)
        return res
    }()
    
    private lazy var removeButton: UIButton = {
        let res = UIButton(type: .system)
        res.accessibilityIdentifier = AccessibilityIdentifiers.StartScreen.removeButton
        res.setTitle("Remove all items", for: .normal)
        setupButton(res)
        res.addTarget(self, action: #selector(onRemoveButtonTouchUpInside), for: .touchUpInside)
        return res
    }()
    
    private func setupLabel(_ label: UILabel) {
        label.font = UIFont.systemFont(ofSize: 24)
    }
    
    private func setupButton(_ button: UIButton) {
        button.setTitleColor(.darkText, for: .normal)
        button.contentEdgeInsets = .init(top: 8, left: 16, bottom: 8, right: 16)
        button.layer.cornerRadius = 4
        button.backgroundColor = .yellow
    }
    
    private let model = TodoItemsModel()
    private var token: TodoItemsModel.Token!
}

extension TodoItemsViewController: TodoItemsModelListener {
    func onModelDidUpdateItems() {
        updateUI()
    }
}

extension TodoItemsViewController {
    
    private func updateUI() {
        itemsCountLabel.text = "\(model.itemsCount)"
    }
    
    @objc private func onAddButtonTouchUpInside() {
        model.addItem(text: "Item \(model.itemsCount)")
    }
    
    @objc private func onRemoveButtonTouchUpInside() {
        model.removeAll()
    }
}
