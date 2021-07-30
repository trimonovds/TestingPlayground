//
//  TodoItemEditorViewController.swift
//  TestingPlayground
//
//  Created by Dmitry Trimonov on 30.07.2021.
//

import UIKit

protocol TodoItemEditorViewControllerDelegate: AnyObject {
    func editorDidFinish(_ editor: TodoItemEditorViewController, withResult result: TodoItemEditorViewController.Result)
}

class TodoItemEditorViewController: UIViewController {
    
    enum Result {
        case created(TodoItem)
        case updated(TodoItem)
    }
    
    enum Mode {
        case create
        case update(item: TodoItem)
        
        var initialText: String {
            switch self {
            case .create: return ""
            case .update(let item): return item.text
            }
        }
    }
    
    var mode: Mode!
    
    weak var delegate: TodoItemEditorViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        [itemTextInputField, saveButton].forEach {
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
        
        
        updateUI()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        itemTextInputField.becomeFirstResponder()
//    }
//    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        
//        view.endEditing(true)
//    }
    
    deinit {
     
    }
    
    private lazy var itemTextInputField: TextField = {
        let res = TextField()
        res.textColor = UIColor.black
        res.attributedPlaceholder = NSAttributedString(string: "Item text", attributes: [.foregroundColor: UIColor.black.withAlphaComponent(0.5)])
        res.backgroundColor = UIColor.white
        res.autocorrectionType = .no
        res.accessibilityIdentifier = AccessibilityIdentifiers.EditorScreen.inputTextField
        res.addTarget(self, action: #selector(onTextFieldEditingChanged), for: .editingChanged)
        res.layer.cornerRadius = 4
        return res
    }()
    
    private lazy var saveButton: UIButton = {
        let res = UIButton(type: .system)
        res.accessibilityIdentifier = AccessibilityIdentifiers.EditorScreen.saveButton
        res.setTitle("Save", for: .normal)
        setupButton(res)
        res.addTarget(self, action: #selector(onSaveButtonTouchUpInside), for: .touchUpInside)
        return res
    }()
    
    private func setupButton(_ button: UIButton) {
        button.setTitleColor(.darkText, for: .normal)
        button.setTitleColor(UIColor.darkText.withAlphaComponent(0.5), for: .disabled)
        button.contentEdgeInsets = .init(top: 8, left: 16, bottom: 8, right: 16)
        button.layer.cornerRadius = 4
        button.backgroundColor = .yellow
    }
    
}

extension TodoItemEditorViewController {
    
    private func updateUI() {
        itemTextInputField.text = mode.initialText
        updateButtonsAvailability()
    }
    
    private func updateButtonsAvailability() {
        saveButton.isEnabled = {
            switch mode! {
            case .create:
                return !itemTextInputField.text.isNilOrEmpty
            case .update(let item):
                return !itemTextInputField.text.isNilOrEmpty && itemTextInputField.text != item.text
            }
        }()
    }
    
    private func resetEditing() {
        itemTextInputField.text = ""
        updateButtonsAvailability()
        view.endEditing(true)
    }
    
    @objc private func onTextFieldEditingChanged() {
        updateButtonsAvailability()
    }
    
    @objc private func onSaveButtonTouchUpInside() {
        guard let newText = itemTextInputField.text, !newText.isEmpty else {
            assert(false)
            return
        }
        switch mode! {
        case .create:
            delegate?.editorDidFinish(self, withResult: .created(TodoItem(id: UUID(), text: newText)))
        case .update(let item):
            delegate?.editorDidFinish(self, withResult: .updated(TodoItem(id: item.id, text: newText)))
        }
        resetEditing()
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
