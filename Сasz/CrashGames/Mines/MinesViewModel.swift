import SwiftUI

class MinesViewModel: ObservableObject {
    let contact = MinesModel()
    struct Card: Identifiable {
        let id = UUID()
        let image: String
        var isOpened = false
        var isBomb: Bool {
            image == "bomb"
        }
    }
    
    @Published var cards: [Card] = []
    @Published var coin = UserDefaultsManager.shared.coins
    @Published var bet = 5
    @Published var win = 0
    @Published var isPlaying = false
    @Published var gameOver = false
    @Published var correctAnswersCount = 0

    init() {
        resetCards()
    }
    
    func resetCards() {
        let baseCards = (0..<20).map { _ in Card(image: Bool.random() ? "scratch2" : "bomb") }
        cards = baseCards.shuffled()
        win = 0
        gameOver = false
        isPlaying = false
    }

    func startGame() {
        guard coin >= bet else { return }
        UserDefaultsManager.shared.removeCoins(bet)
        coin = UserDefaultsManager.shared.coins
        resetCards()
        isPlaying = true
        gameOver = false
        correctAnswersCount = 0
        win = 0
    }

    func openCard(at index: Int) {
        guard isPlaying, !gameOver else { return }
        guard !cards[index].isOpened else { return }

        cards[index].isOpened = true

        if cards[index].isBomb {
            gameOver = true
            isPlaying = false
            win = 0
            correctAnswersCount = 0
        } else {
            correctAnswersCount += 1
            win += bet
        }
    }

    func getReward() {
        coin += win
        UserDefaultsManager.shared.addCoins(win)
        coin = UserDefaultsManager.shared.coins
        isPlaying = false
        gameOver = false
        win = 0
    }
}
