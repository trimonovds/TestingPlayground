//
//  TodoItemsModel.swift
//  TestingPlayground
//
//  Created by Dmitry Trimonov on 19.07.2021.
//

import Foundation

struct TodoItem {
    let id: UUID
    let text: String
}

public protocol TodoItemsModelListener {
    func onModelDidUpdateItems()
}

class TodoItemsModel {
    typealias Token = UUID
    
    private(set) var items: [TodoItem] = [] {
        didSet {
            listeners.values.forEach { $0.onModelDidUpdateItems() }
        }
    }
    
    func removeAll() {
        items.removeAll()
    }
    
    func addItem(_ item: TodoItem) {
        guard items.firstIndex(where: { $0.id == item.id }) == nil else {
            assert(false)
            return
        }
        items.append(item)
    }
    
    func updateItem(_ item: TodoItem) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else {
            assert(false)
            return
        }
        items[index] = item
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
}

extension TodoItemsModel {
    var itemsCount: Int {
        return items.count
    }
    
    func addItem(text: String) {
        addItem(TodoItem(id: UUID(), text: text))
    }
}
