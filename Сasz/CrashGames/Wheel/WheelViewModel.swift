import SwiftUI
import Combine

struct WheelSegment: Identifiable {
    let id = UUID()
    let title: String
    let prize: Double
    let color: Color
}

class WheelViewModel: ObservableObject {
    let contact = WheelModel()
    @Published var coin = UserDefaultsManager.shared.coins
    @Published var bet = 50
    @Published var win = 0
    @ObservedObject private var soundManager = SoundManager.shared
    
    @Published var segments: [WheelSegment] = [
        WheelSegment(title: "10x", prize: 10, color: Color(red: 236/255, green: 72/255, blue: 153/255)),
        WheelSegment(title: "1x", prize: 1, color: Color(red: 21/255, green: 184/255, blue: 166/255)),
        WheelSegment(title: "3x", prize: 3, color: Color(red: 249/255, green: 115/255, blue: 23/255)),
        WheelSegment(title: "0.5x", prize: Double(0.5), color: Color(red: 239/255, green: 67/255, blue: 68/255)),
        WheelSegment(title: "2x", prize: 2, color: Color(red: 245/255, green: 158/255, blue: 10/255)),
        WheelSegment(title: "1x", prize: 1, color: Color(red: 19/255, green: 185/255, blue: 129/255)),
        WheelSegment(title: "5x", prize: 5, color: Color(red: 59/255, green: 130/255, blue: 246/255)),
        WheelSegment(title: "1.5x", prize: Double(1.5), color: Color(red: 140/255, green: 92/255, blue: 246/255))
    ]
    
    @Published var isSpinning = false
    @Published var rotationDegree: Double = 0
    private var cancellables = Set<AnyCancellable>()
    private var userDefaults = UserDefaultsManager.shared
    @Published private(set) var balance: Double = 0
    @Published var alertMessage: String? = nil
    
    @Published var selectedSegmentIndex: Int? = nil
     @Published var betAmount: Double = 0
    
    func spinWheel() {
         guard !isSpinning else { return }
        soundManager.playSoundBtn()
         win = 0
         guard let selectedIndex = selectedSegmentIndex else {
             alertMessage = "Please select a segment before spinning."
             return
         }
         
        guard bet > 0 && bet <= coin else {
             alertMessage = "Please set a valid bet amount."
             return
         }
         
         isSpinning = true
        
        let _ = UserDefaultsManager.shared.removeCoins(bet)
        coin = UserDefaultsManager.shared.coins
        
         let fullRotations = Double.random(in: 3...6)
         let randomAngle = Double.random(in: 0..<360)
         let newRotation = rotationDegree + fullRotations * 360 + randomAngle
         
         withAnimation(.easeOut(duration: 3)) {
             rotationDegree = newRotation
         }
         
         DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
             let normalizedDegree = (self.rotationDegree.truncatingRemainder(dividingBy: 360))
             let segmentAngle = 360.0 / Double(self.segments.count)
             let index = Int(Double(self.segments.count) - (normalizedDegree / segmentAngle)) % self.segments.count
             
             if index == selectedIndex {
                 let prize = self.segments[index].prize * Double(self.bet)
                 self.win = Int(prize) 
                 self.applyPrize(Int(prize))
                 self.alertMessage = "You won $\(String(format: "%.2f", prize))!"
             } else {
                 self.alertMessage = "You lost your bet. Try again!"
             }
             
             self.isSpinning = false
             self.soundManager.stopWrong()
         }
     }
     
    private func applyPrize(_ prize: Int) {
         win = prize
         UserDefaultsManager.shared.addCoins(win)
         coin = UserDefaultsManager.shared.coins
     }
    
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}
