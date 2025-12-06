import SwiftUI

class UserDefaultsManager: ObservableObject {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    private let achievementsKey = "achievements"
    
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
    
    @Published var currentXP: Int = 0 {
        didSet {
            defaults.set(currentXP, forKey: "currentXP")
            checkLevelUp()
        }
    }
    
    @Published var profileImageName: String = "profileImg1" {
        didSet {
            defaults.set(profileImageName, forKey: "profileImageName")
        }
    }
    
    @Published var currentLevel: Int = 1 {
        didSet {
            defaults.set(currentLevel, forKey: "currentLevel")
        }
    }
    
    @Published var minesRevealed: Int = 0 {
        didSet { defaults.set(minesRevealed, forKey: "minesRevealed") }
    }
    
    @Published var coinFlipsWon: Int = 0 {
        didSet { defaults.set(coinFlipsWon, forKey: "coinFlipsWon") }
    }
    
    @Published var crashCashouts5x: Int = 0 {
        didSet { defaults.set(crashCashouts5x, forKey: "crashCashouts5x") }
    }
    
    @Published var totalGamesPlayed: Int = 0 {
        didSet { defaults.set(totalGamesPlayed, forKey: "totalGamesPlayed") }
    }
    
    @Published var maxBetAmount: Int = 0 {
        didSet { defaults.set(maxBetAmount, forKey: "maxBetAmount") }
    }
    
    @Published var maxMultiplierWon: Double = 0 {
        didSet { defaults.set(maxMultiplierWon, forKey: "maxMultiplierWon") }
    }
    
    @Published var fruitSlotsWins: Int = 0 {
        didSet { defaults.set(fruitSlotsWins, forKey: "fruitSlotsWins") }
    }
    
    @Published var classicSlotsWins: Int = 0 {
        didSet { defaults.set(classicSlotsWins, forKey: "classicSlotsWins") }
    }
    
    @Published var goldSlotsWins: Int = 0 {
        didSet { defaults.set(goldSlotsWins, forKey: "goldSlotsWins") }
    }
    
    private init() {
        loadAllData()
    }
    
    func value<T>(forKey key: String) -> T? {
        defaults.value(forKey: key) as? T
    }
    
    func setValue<T>(_ value: T, forKey key: String) {
        defaults.set(value, forKey: key)
    }
    
    func increment(key: String, by amount: Int = 1) {
        let current = (defaults.integer(forKey: key) + amount)
        defaults.set(current, forKey: key)
        updatePublishedProperty(key: key, value: current)
    }
    
    func updateMax(key: String, newValue: Int) {
        let current = defaults.integer(forKey: key)
        if newValue > current {
            defaults.set(newValue, forKey: key)
            updatePublishedProperty(key: key, value: newValue)
        }
    }
    
    func updateMaxMultiplier(newValue: Double) {
        if newValue > maxMultiplierWon {
            maxMultiplierWon = newValue
        }
    }
    
    private func updatePublishedProperty(key: String, value: Int) {
        switch key {
        case "minesRevealed": minesRevealed = value
        case "coinFlipsWon": coinFlipsWon = value
        case "crashCashouts5x": crashCashouts5x = value
        case "currentLevel": currentLevel = value
        case "totalGamesPlayed": totalGamesPlayed = value
        case "maxBetAmount": maxBetAmount = value
        case "fruitSlotsWins": fruitSlotsWins = value
        case "classicSlotsWins": classicSlotsWins = value
        case "goldSlotsWins": goldSlotsWins = value
        default: break
        }
    }
    
    private func loadAllData() {
        coins = defaults.integer(forKey: "coins")
        let savedLevel = defaults.integer(forKey: "currentLevel")
        currentLevel = savedLevel > 0 ? savedLevel : 1
        if let savedProfileImg = defaults.string(forKey: "profileImageName") {
            profileImageName = savedProfileImg
        } else {
            profileImageName = "profileImg1"
        }
        currentXP = defaults.integer(forKey: "currentXP")
        minesRevealed = defaults.integer(forKey: "minesRevealed")
        coinFlipsWon = defaults.integer(forKey: "coinFlipsWon")
        crashCashouts5x = defaults.integer(forKey: "crashCashouts5x")
        currentLevel = defaults.integer(forKey: "currentLevel")
        totalGamesPlayed = defaults.integer(forKey: "totalGamesPlayed")
        maxBetAmount = defaults.integer(forKey: "maxBetAmount")
        if let multiplier = defaults.value(forKey: "maxMultiplierWon") as? Double {
            maxMultiplierWon = multiplier
        }
        fruitSlotsWins = defaults.integer(forKey: "fruitSlotsWins")
        classicSlotsWins = defaults.integer(forKey: "classicSlotsWins")
        goldSlotsWins = defaults.integer(forKey: "goldSlotsWins")
    }
    
    func revealSafeTile() {
        increment(key: "minesRevealed")
    }
    
    func winCoinFlip() {
        increment(key: "coinFlipsWon")
    }
    
    func cashout5x() {
        increment(key: "crashCashouts5x")
    }
    
    func updateLevel(_ level: Int) {
        currentLevel = level
    }
    
    func placeBet(_ amount: Int) {
        updateMax(key: "maxBetAmount", newValue: amount)
    }
    
    func winMultiplier(_ multiplier: Double) {
        updateMaxMultiplier(newValue: multiplier)
    }
    
    func winFruitSlot() {
        increment(key: "fruitSlotsWins")
    }
    
    func winClassicSlot() {
        increment(key: "classicSlotsWins")
    }
    
    func winGoldSlot() {
        increment(key: "goldSlotsWins")
    }
    
    func addXP(_ amount: Int) {
        currentXP += amount
    }
    
    func playGame() {
        addXP(10)
        increment(key: "totalGamesPlayed")
    }
    
    private func checkLevelUp() {
        while currentXP >= currentLevel * 1000 {
            currentLevel += 1
            print("🎉 Level Up! Now level \(currentLevel)")
        }
    }
    
    var xpProgress: Double {
        let xpForCurrentLevel = (currentLevel - 1) * 1000
        let xpNeededForNextLevel = currentLevel * 1000
        let progress = Double(currentXP - xpForCurrentLevel) / Double(xpNeededForNextLevel - xpForCurrentLevel)
        return min(progress, 1.0)
    }
    
    var xpToNextLevel: Int {
        currentLevel * 1000 - currentXP
    }
}
