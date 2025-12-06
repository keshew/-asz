import SpriteKit
import Combine
import SwiftUI

class GameData: ObservableObject {
    @Published var reward: Double = 0.0
    @Published var bet: Int = 50

    @Published var balance: Int = UserDefaultsManager.shared.coins
    @Published var isPlayTapped: Bool = false
    @Published var labels: [String] = ["1x", "1.5x", "2x", "5x", "10x", "5x", "2x", "1.5x", "1x"]
    
    var createBallPublisher = PassthroughSubject<Void, Never>()
    
    var formattedBalance: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: balance)) ?? "\(balance)"
    }
    
    
    func decreaseBet() {
        if bet - 5 >= 5 {
            bet -= 5
        }
    }
    func increaseBet() {
        let newBet = bet + 5
        if newBet <= balance {
            bet = newBet
        }
    }
    
    
    func dropBalls() {
        guard bet <= balance else {
            return
        }
        UserDefaultsManager.shared.playGame()
        let _ = UserDefaultsManager.shared.removeCoins(bet)
        UserDefaultsManager.shared.playGame() 
        UserDefaultsManager.shared.placeBet(bet)
        balance = UserDefaultsManager.shared.coins
        reward = 0.0
        isPlayTapped = true
        createBallPublisher.send(())
    }
    
    func resetGame() {
        bet = 50
        reward = 0
        isPlayTapped = false
    }
    
    func addWin(_ amount: Double) {
        reward += amount
    }
    
    func finishGame() {
        UserDefaultsManager.shared.addCoins(Int(reward))
        balance = UserDefaultsManager.shared.coins
        reward = 0
        isPlayTapped = false
    }
}

class GameSpriteKit: SKScene, SKPhysicsContactDelegate {
    var game: GameData? {
        didSet {
        }
    }
    
    let ballCategory: UInt32 = 0x1 << 0
    let obstacleCategory: UInt32 = 0x1 << 1
    let ticketCategory: UInt32 = 0x1 << 2
    
    var ballsInPlay: Int = 0
    var ballNodes: [SKSpriteNode] = []
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        size = UIScreen.main.bounds.size
        backgroundColor = .clear
        
        createObstacles()
        createTickets()
        createInitialBalls()
        
        game?.createBallPublisher.sink { [weak self] in
            self?.launchBalls()
        }.store(in: &cancellables)
    }
    
    var cancellables = Set<AnyCancellable>()
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        for (index, ball) in ballNodes.enumerated().reversed() {
            if ball.position.y < 0 || ball.position.x < 0 || ball.position.x > size.width {
                ball.removeFromParent()
                ballNodes.remove(at: index)
                ballsInPlay -= 1
                createBall(atIndex: index)
            }
        }
    }
    
    func createObstacles() {
        let numberOfRows = size.width > 1200 ? 5 : 4
        let obstacleSize = CGSize(width: size.width > 1200 ? 30 : 20, height: size.width > 1200 ? 30 : 13)
        let horizontalSpacing: CGFloat = size.width > 1200 ? 90 : 45

        for row in 0..<numberOfRows {
            let countInRow = 13 - row
            let totalWidth = CGFloat(countInRow) * (obstacleSize.width + horizontalSpacing) - horizontalSpacing
            let xOffset = (size.width - totalWidth) / 2 + obstacleSize.width / 2
            let yPosition = (UIScreen.main.bounds.width > 1200 ? size.height / 1.35 : size.height / 1.32) - CGFloat(row) * (obstacleSize.height + (UIScreen.main.bounds.width > 1200 ? 105 : 60))
            
            for col in 0..<countInRow {
                let obstacle = SKSpriteNode(imageNamed: "obstacle")
                obstacle.size = obstacleSize
                let xPosition = xOffset + CGFloat(col) * (obstacleSize.width + horizontalSpacing)
                obstacle.position = CGPoint(x: xPosition, y: yPosition)
                
                obstacle.physicsBody = SKPhysicsBody(circleOfRadius: obstacleSize.width / 2.0)
                obstacle.physicsBody?.isDynamic = false
                obstacle.physicsBody?.categoryBitMask = obstacleCategory
                obstacle.physicsBody?.contactTestBitMask = ballCategory
                
                addChild(obstacle)
            }
        }
    }

    
    func createTickets() {
        guard let game = self.game else { return }
        let labels = game.labels
        let count = labels.count
        let ticketWidth: CGFloat = size.width > 1200 ? 120 : 82
        let horizontalSpacing: CGFloat = 10
        let totalWidth = CGFloat(count) * (ticketWidth + horizontalSpacing) - horizontalSpacing
        let xOffset = (size.width - totalWidth) / 2 + ticketWidth / 2
        let yPosition = size.height / 17.5

        for i in 0..<count {
            let label = SKLabelNode(text: labels[i])
            label.fontName = "PaytoneOne-Regular"
            label.fontSize = size.width > 1200 ? 34 : 18
            label.fontColor = UIColor(red: 253/255, green: 255/255, blue: 193/255, alpha: 1)
            label.verticalAlignmentMode = .center
            label.horizontalAlignmentMode = .center
            label.position = CGPoint(x: 0, y: 0)
            label.xScale = size.width > 1200 ? 1.2 : 1.5
            label.yScale = 1
            label.name = "ticket_\(i)"


            let backgroundSize = CGSize(width: ticketWidth + 10, height: label.frame.height + 25)
            let backgroundNode = SKShapeNode(rectOf: backgroundSize, cornerRadius: 3)
            let turquoiseColor = UIColor(red: 35/255, green: 212/255, blue: 238/255, alpha: 1.0)
            backgroundNode.fillColor = .clear
            backgroundNode.strokeColor = turquoiseColor
            backgroundNode.lineWidth = 2.0
            backgroundNode.position = CGPoint(x: xOffset + CGFloat(i) * (ticketWidth + horizontalSpacing), y: yPosition)
            backgroundNode.zPosition = label.zPosition - 1

            backgroundNode.physicsBody = SKPhysicsBody(rectangleOf: backgroundSize)
            backgroundNode.physicsBody?.isDynamic = false
            backgroundNode.physicsBody?.categoryBitMask = ticketCategory
            backgroundNode.physicsBody?.contactTestBitMask = ballCategory

            backgroundNode.addChild(label)

            addChild(backgroundNode)
        }
    }
    
    func createInitialBalls() {
        
        ballNodes.forEach { $0.removeFromParent() }
        ballNodes.removeAll()
        ballsInPlay = 0
        
        let ball = SKSpriteNode(imageNamed: "ball")
        ball.size = CGSize(width: size.width > 1200 ? 35 : 30, height: size.width > 1200 ? 32 : 20)
        ball.position = CGPoint(x: size.width / 2,
                                y: size.height / 1.15)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 3)
        ball.physicsBody?.restitution = 0.7
        ball.physicsBody?.friction = 0.0
        ball.physicsBody?.linearDamping = 0.2
        ball.physicsBody?.allowsRotation = true
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.categoryBitMask = ballCategory
        ball.physicsBody?.contactTestBitMask = obstacleCategory | ticketCategory
        ball.physicsBody?.collisionBitMask = obstacleCategory | ticketCategory
        ball.physicsBody?.isDynamic = true
        
        addChild(ball)
        ballNodes.append(ball)
        ballsInPlay += 1
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let game = game else { return }
        
        let ballCategory = self.ballCategory
        let ticketCategory = self.ticketCategory
        
        var ballNode: SKNode?
        var ticketNode: SKNode?
        
        if contact.bodyA.categoryBitMask == ballCategory {
            ballNode = contact.bodyA.node
        } else if contact.bodyB.categoryBitMask == ballCategory {
            ballNode = contact.bodyB.node
        }
        
        if contact.bodyA.categoryBitMask == ticketCategory {
            ticketNode = contact.bodyA.node
        } else if contact.bodyB.categoryBitMask == ticketCategory {
            ticketNode = contact.bodyB.node
        }
        
        guard let ball = ballNode as? SKSpriteNode,
              let ticketBackground = ticketNode as? SKShapeNode else {
            return
        }
        
        guard let ticketLabel = ticketBackground.children.compactMap({ $0 as? SKLabelNode }).first(where: {
            $0.name?.starts(with: "ticket_") == true
        }) else {
            print("Ticket label not found as child of ticket background node")
            return
        }
        
        guard let multiplier = parseMultiplier(from: ticketLabel.text) else {
            print("Failed to parse multiplier from label \(ticketLabel.text ?? "")")
            return
        }
        
        let win = Double(game.bet) * multiplier
        game.addWin(win)
        
        ball.removeFromParent()
        if let index = ballNodes.firstIndex(of: ball) {
            ballNodes.remove(at: index)
        }
        
        ballsInPlay -= 1
        
        createBall(atIndex: 0)
        
        checkBallsStopped()
    }

    
    func createBall(atIndex index: Int) {
        
        let ball = SKSpriteNode(imageNamed: "ball")
        ball.size = CGSize(width: size.width > 1200 ? 25 : 30, height: 20)
        ball.position = CGPoint(x: size.width / 2,
                                y: size.height / 1.15)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 3)
        ball.physicsBody?.restitution = 0.7
        ball.physicsBody?.friction = 0.0
        ball.physicsBody?.linearDamping = 0.2
        ball.physicsBody?.allowsRotation = true
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.categoryBitMask = ballCategory
        ball.physicsBody?.contactTestBitMask = obstacleCategory | ticketCategory
        ball.physicsBody?.collisionBitMask = obstacleCategory | ticketCategory
        ball.physicsBody?.isDynamic = true
        
        addChild(ball)
        ballNodes.append(ball)
        ballsInPlay += 1
    }
    
    func launchBalls() {
        for (_, ball) in ballNodes.enumerated() {
            ball.physicsBody?.affectedByGravity = true
            
            let randomXImpulse = CGFloat.random(in: -0.01...0.01)
            
            ball.physicsBody?.applyImpulse(CGVector(dx: randomXImpulse, dy: 0))
        }
    }
    
    private func parseMultiplier(from text: String?) -> Double? {
        guard let text = text?.lowercased().replacingOccurrences(of: "x", with: "") else { return nil }
        return Double(text)
    }
    
    private func checkBallsStopped() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self, let game = self.game else { return }
            let movingBalls = self.ballNodes.filter {
                guard let body = $0.physicsBody else { return false }
                return body.velocity.dx > 5 || body.velocity.dy > 5
            }
            if movingBalls.isEmpty && game.isPlayTapped {
                game.finishGame()
            }
        }
    }
}

struct PlinkoView: View {
    @StateObject var viewModel =  PlinkoViewModel()
    @Environment(\.presentationMode) var presentationMode
    @StateObject var gameModel = GameData()
    
    var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                
                Color.clear
                    .overlay(
                        Color.clear
                            .overlay(
                                ZStack {
                                    Image("bgMain")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                    
                                    LinearGradient(colors: [Color(red: 51/255, green: 21/255, blue: 101/255),
                                                            Color(red: 95/255, green: 18/255, blue: 69/255)], startPoint: .leading, endPoint: .trailing)
                                }
                            )
                            .clipped()
                            .ignoresSafeArea()
                    )
                    .clipped()
                    .ignoresSafeArea()
                
                ZStack(alignment: .bottom) {
                    LinearGradient(colors: [Color(red: 21/255, green: 51/255, blue: 62/255),
                                            Color(red: 63/255, green: 22/255, blue: 105/255)], startPoint: .leading, endPoint: .trailing)
                    .frame(height: 70)
                    
                    Rectangle()
                        .foregroundStyle(Color(red: 89/255, green: 49/255, blue: 129/255))
                        .frame(height: 1)
                }
            }
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    
                    VStack(spacing: 8) {
                        HStack(spacing: 20) {
                            Button(action: {
                                NotificationCenter.default.post(name: Notification.Name("RefreshData"), object: nil)
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image("backBtn")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                            }
                            
                            Spacer()
                            
                            HStack {
                                Image("coins")
                                    .resizable()
                                    .frame(width: 24, height: 31)
                                
                                Text("\(gameModel.balance)")
                                    .font(.custom("PaytoneOne-Regular", size: 18))
                                    .foregroundStyle(Color(red: 239/255, green: 208/255, blue: 0/255))
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(red: 89/255, green: 49/255, blue: 129/255), lineWidth: 2)
                            }
                        }
                        .padding(.top)
                        .padding(.horizontal)
                        
                        ScrollView(showsIndicators: false) {
                            VStack {
                                Rectangle()
                                    .fill(Color(red: 84/255, green: 79/255, blue: 30/255))
                                    .overlay {
                                        Image("plinkoBg")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: UIScreen.main.bounds.width > 1200 ? 700 : 550, height: UIScreen.main.bounds.width > 1200 ? 420 : 290)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 14)
                                                    .stroke(Color(red: 35/255, green: 212/255, blue: 238/255), lineWidth: 7)
                                                    .overlay {
                                                        VStack(spacing: 5) {
                                                            Rectangle()
                                                                .fill(.black.opacity(0.5))
                                                                .overlay {
                                                                    SpriteView(scene: viewModel.createGameScene(gameData: gameModel), options: [.allowsTransparency])
                                                                        .frame(width: UIScreen.main.bounds.width > 1200 ? 370 : 270, height: UIScreen.main.bounds.width > 1200 ? 300 : 180)
                                                                }
                                                                .frame(width: UIScreen.main.bounds.width > 1200 ? 500 : 400, height: UIScreen.main.bounds.width > 1200 ? 300 : 190)
                                                                .cornerRadius(16)
                                                            
                                                            HStack(spacing: 20) {
                                                                Button(action: {
                                                                    gameModel.decreaseBet()
                                                                }) {
                                                                    Circle()
                                                                        .fill(Color.black.opacity(0.5))
                                                                        .overlay {
                                                                            RoundedRectangle(cornerRadius: 15)
                                                                                .stroke(Color(red: 251/255, green: 191/255, blue: 36/255).opacity(0.5), lineWidth: 2)
                                                                                .overlay {
                                                                                    Text("-")
                                                                                        .font(.custom("PaytoneOne-Regular", size: 20))
                                                                                        .foregroundStyle(.white)
                                                                                        .offset(y: -3)
                                                                                }
                                                                        }
                                                                        .frame(width: 30, height: 30)
                                                                        .cornerRadius(15)
                                                                }
                                                                
                                                                Rectangle()
                                                                    .fill(Color(red: 28/255, green: 28/255, blue: 28/255))
                                                                    .frame(width: 80, height: 45)
                                                                    .overlay {
                                                                        RoundedRectangle(cornerRadius: 12)
                                                                            .stroke(Color(red: 84/255, green: 92/255, blue: 102/255), lineWidth: 2)
                                                                            .overlay {
                                                                                VStack(spacing: 0) {
                                                                                    Text("Bet Amount")
                                                                                        .font(.custom("PaytoneOne-Regular", size: 10))
                                                                                        .foregroundStyle(Color(red: 203/255, green: 213/255, blue: 225/255))
                                                                                    
                                                                                    Text("Bet: \(gameModel.bet)")
                                                                                        .font(.custom("PaytoneOne-Regular", size: 14))
                                                                                        .foregroundStyle(Color(red: 148/255, green: 163/255, blue: 185/255))
                                                                                }
                                                                            }
                                                                    }
                                                                    .cornerRadius(12)
                                                                
                                                                Button(action: {
                                                                    gameModel.increaseBet()
                                                                }) {
                                                                    Circle()
                                                                        .fill(Color.black.opacity(0.5))
                                                                        .overlay {
                                                                            RoundedRectangle(cornerRadius: 15)
                                                                                .stroke(Color(red: 251/255, green: 191/255, blue: 36/255).opacity(0.5), lineWidth: 2)
                                                                                .overlay {
                                                                                    Text("+")
                                                                                        .font(.custom("PaytoneOne-Regular", size: 20))
                                                                                        .foregroundStyle(.white)
                                                                                        .offset(y: -3)
                                                                                }
                                                                        }
                                                                        .frame(width: 30, height: 30)
                                                                        .cornerRadius(15)
                                                                }
                                                            }
                                                            
                                                            Button(action: {
                                                                withAnimation {
                                                                    gameModel.dropBalls()
                                                                }
                                                            }) {
                                                                Rectangle()
                                                                    .fill(Color(red: 224/255, green: 105/255, blue: 10/255))
                                                                    .overlay {
                                                                        RoundedRectangle(cornerRadius: 6)
                                                                            .stroke(Color(red: 252/255, green: 211/255, blue: 77/255), lineWidth: 2)
                                                                            .overlay {
                                                                                Text("Start game")
                                                                                    .font(.custom("PaytoneOne-Regular", size: 12))
                                                                                    .foregroundStyle(.white)
                                                                            }
                                                                    }
                                                                    .frame(width: 250, height: 26)
                                                                    .cornerRadius(6)
                                                            }
                                                            .padding(.horizontal)
                                                        }
                                                    }
                                            }
                                    }
                                    .frame(width: UIScreen.main.bounds.width > 1200 ? 700 : 550, height: UIScreen.main.bounds.width > 1200 ? 420 : 290)
                                    .cornerRadius(14)
                                
                                Spacer()
                            }
                            .padding(.top)
                            .padding(.trailing, 50)
                        }
                        .padding(.top, 5)
                    }
                    .padding(.trailing)
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    PlinkoView()
}

