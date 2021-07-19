//
//  TodoItemsModel.swift
//  TestingPlayground
//
//  Created by Dmitry Trimonov on 19.07.2021.
//

import Foundation

struct TodoItem {
    let text: String
}

public protocol TodoItemsModelListener {
    func onModelDidUpdateItems()
}

class TodoItemsModel {
    typealias Token = UUID
    
    var itemsCount: Int {
        return items.count
    }
    
    var lastItem: TodoItem? {
        return items.last
    }
    
    func removeAll() {
        items.removeAll()
    }
    
    func addItem(text: String) {
        items.append(TodoItem(text: text))
    }
    
    public func addListener(_ listener: TodoItemsModelListener) -> Token {
        let token = UUID()
        listeners[token] = listener
        return token
    }
    
    public func removeListener(token: Token) {
        listeners.removeValue(forKey: token)
    }
    
    private var listeners: [Token: TodoItemsModelListener] = [:]
    
    private var items: [TodoItem] = [] {
        didSet {
            listeners.values.forEach { $0.onModelDidUpdateItems() }
        }
    }
}
