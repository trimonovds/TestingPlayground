//
//  Model.swift
//  TestingPlayground
//
//  Created by Дмитрий Тримонов on 18.07.2021.
//

import Foundation

final class Model {
    
    init(logger: ILogger) {
        self.logger = logger
    }
    
    func fetch() {
        logger.log("Did start fetching", scope: .info)
    }
    
    private let logger: ILogger
}
