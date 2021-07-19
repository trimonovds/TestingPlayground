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
        [itemTextInputField, addButton, removeButton, itemsCountLabel].forEach {
            stack.addArrangedSubview($0)
        }
        itemTextInputField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -64),
            stack.leftAnchor.constraint(equalTo: view.leftAnchor),
            stack.rightAnchor.constraint(equalTo: view.rightAnchor),
            itemTextInputField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            itemTextInputField.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        token = model.addListener(self)
        updateUI()
    }
    
    deinit {
        model.removeListener(token: token)
    }
    
    private lazy var itemTextInputField: TextField = {
        let res = TextField()
        res.textColor = UIColor.black
        res.attributedPlaceholder = NSAttributedString(string: "Input item text", attributes: [.foregroundColor: UIColor.black.withAlphaComponent(0.5)])
        res.backgroundColor = UIColor.white
        res.accessibilityIdentifier = AccessibilityIdentifiers.StartScreen.itemTextInputField
        res.addTarget(self, action: #selector(onTextFieldEditingChanged), for: .editingChanged)
        res.layer.cornerRadius = 4
        return res
    }()
    
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
        button.setTitleColor(UIColor.darkText.withAlphaComponent(0.5), for: .disabled)
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
        updateButtonsAvailability()
    }
    
    private func updateButtonsAvailability() {
        addButton.isEnabled = !itemTextInputField.text.isNilOrEmpty
        removeButton.isEnabled = model.itemsCount > 0
    }
    
    private func resetEditing() {
        itemTextInputField.text = ""
        updateButtonsAvailability()
        view.endEditing(true)
    }
    
    @objc private func onTextFieldEditingChanged() {
        updateButtonsAvailability()
    }
    
    @objc private func onAddButtonTouchUpInside() {
        model.addItem(text: itemTextInputField.text!)
        resetEditing()
    }
    
    @objc private func onRemoveButtonTouchUpInside() {
        model.removeAll()
    }
}

extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        switch self {
        case .none:
            return true
        case .some(let txt):
            return txt.isEmpty
        }
    }
}

class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
