import SwiftUI

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    
    private init() {}
    
    var coins: Int {
        get { defaults.integer(forKey: "coins") }
        set { defaults.set(newValue, forKey: "coins") }
    }
    
    
    func addCoins(_ amount: Int) {
        coins += amount
    }
    
    func removeCoins(_ amount: Int) {
        coins = max(coins - amount, 0)
    }
}
