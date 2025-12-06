import SwiftUI

class DiceRollViewModel: ObservableObject {
    let contact = DiceRollModel()
    @Published var coin =   UserDefaultsManager.shared.coins
    @Published var bet = 10
    @Published var isTail = false
    @Published var isFlipping = false
    @Published var rotationStep = 0
    @Published var totalRotations = 0
    @Published var diceResult: Int = 1
    private var userChoiceIsTail: Bool = false
    private var finalResultTail: Bool = false
    var onFlipResult: ((Bool) -> Void)? = nil

      @Published var currentDisplayNumber: Int = 1
      
      func startFlip(userChoice: Bool) {
          guard !isFlipping, bet <= coin else { return }
          UserDefaultsManager.shared.removeCoins(bet)
          UserDefaultsManager.shared.playGame()
          UserDefaultsManager.shared.placeBet(bet)
          UserDefaultsManager.shared.playGame() 
          coin = UserDefaultsManager.shared.coins
          userChoiceIsTail = userChoice
          
          let finalResult = Int.random(in: 1...99)
          diceResult = finalResult
          finalResultTail = finalResult <= 50
          
          generateIntermediateNumbers(finalResult: finalResult)
          
          totalRotations = Int.random(in: 5...7)
          rotationStep = 0
          isFlipping = true
          runRotationAnimation()
      }
      
      private func generateIntermediateNumbers(finalResult: Int) {
          var numbers: [Int] = []
          for _ in 0..<totalRotations {
              numbers.append(Int.random(in: 1...99))
          }
          numbers.append(finalResult)
      }
      
      private func runRotationAnimation() {
          guard rotationStep < totalRotations + 1 else {
              isFlipping = false
              isTail = finalResultTail
              
              if userChoiceIsTail == finalResultTail {
                  UserDefaultsManager.shared.addCoins(bet * 2)
                  coin = UserDefaultsManager.shared.coins
                  onFlipResult?(true)
              } else {
                  coin = UserDefaultsManager.shared.coins
                  onFlipResult?(false)
              }
              return
          }
          
          currentDisplayNumber = Int.random(in: 1...99)
          
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
              self.rotationStep += 1
              self.runRotationAnimation()
          }
      }
}
