//
//  AdvertisementUseCase.swift
//  TestingPlayground
//
//  Created by Дмитрий Тримонов on 19.07.2021.
//

import Foundation

struct Account {
    let email: String
    let isStuff: Bool
}

protocol IAccountService {
    var account: Account? { get }
}

enum SettingsBlock {
    case map, routes, debug
}

class SettingsViewModel {
    init(accountService: IAccountService) {
        self.accountService = accountService
    }
    
    func getBlocks() -> [SettingsBlock] {
        var blocks: [SettingsBlock] = [.map, .routes]
        if accountService.account?.isStuff ?? false {
            blocks.append(.debug)
        }
        return blocks
    }
    
    private let accountService: IAccountService
}
