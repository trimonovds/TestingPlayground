//
//  SettingsViewModelTests.swift
//  TestingPlaygroundTests
//
//  Created by Дмитрий Тримонов on 19.07.2021.
//

import Foundation
import XCTest
@testable import TestingPlayground

fileprivate class AccountServiceStub: IAccountService {
    var account: Account? = nil
}

class SettingsViewModelTests: XCTestCase {
    func testGetBlocksContainsDebugWhenAccountIsStuff() {
        let accountServiceStub = AccountServiceStub()
        accountServiceStub.account = .init(email: "", isStuff: true)
        let sut = SettingsViewModel(accountService: accountServiceStub)
        let actual = sut.getBlocks()
        XCTAssertTrue(actual.contains(.debug))
    }
    
    func testGetBlocksDoesntContainDebugWhenAccountIsNotStuff() {
        let accountServiceStub = AccountServiceStub()
        accountServiceStub.account = .init(email: "", isStuff: false)
        let sut = SettingsViewModel(accountService: accountServiceStub)
        let actual = sut.getBlocks()
        XCTAssertFalse(actual.contains(.debug))
    }
}
