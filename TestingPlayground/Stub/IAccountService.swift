import Foundation

struct Account {
    let email: String
    let isStuff: Bool
}

protocol IAccountService {
    var account: Account? { get }
}
