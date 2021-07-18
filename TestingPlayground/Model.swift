//
//  Model.swift
//  TestingPlayground
//
//  Created by Дмитрий Тримонов on 18.07.2021.
//

import Foundation

public protocol ModelListener {
    func onModelDidUpdate()
}

public final class Model {
    public typealias Token = UUID
    
    public init(logger: ILogger) {
        self.logger = logger
    }
    
    public func fetch() {
        logger.log("Did start fetching", scope: .info)
        
        // Do some job
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: { [weak self] in
            self?.logger.log("Did finish fetching", scope: .info)
            self?.listeners.values.forEach {
                $0.onModelDidUpdate()
            }
        })
    }
    
    public func addListener(_ listener: ModelListener) -> Token {
        let token = UUID()
        listeners[token] = listener
        return token
    }
    
    public func removeListener(token: Token) {
        listeners.removeValue(forKey: token)
    }
    
    private let logger: ILogger
    private var listeners: [Token: ModelListener] = [:]
}
