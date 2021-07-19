//
//  IAccountService.swift
//  TestingPlayground
//
//  Created by Dmitry Trimonov on 19.07.2021.
//

import Foundation

struct Account {
    let email: String
    let isStuff: Bool
}

protocol IAccountService {
    var account: Account? { get }
}
