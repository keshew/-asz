import SwiftUI

struct Slots: Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var desc: String
    var array: [String]
    var color: Color?
}

struct InstantGameView: View {
    @StateObject var instantGameModel =  InstantGameViewModel()
    
    var slots = [Slots(image: "instant1", title: "Plinko", desc: "Drop the ball and watch it bounce", array: ["Min: 5", "Max: 100"], color: Color(red: 35/255, green: 212/255, blue: 238/255)),
                 Slots(image: "instant2", title: "Dice Roll", desc: "Roll the dice and predict the outcome", array: ["Min: 5", "Max: 150"], color: Color(red: 251/255, green: 146/255, blue: 61/255)),
                 Slots(image: "instant3", title: "Wheel of Fortune", desc: "Spin the wheel for big prizes", array: ["Min: 10", "Max: 200"], color: Color(red: 243/255, green: 114/255, blue: 182/255)),
                 Slots(image: "instant4", title: "Mines", desc: "Avoid the mines and collect rewards.", array: ["Min: 10", "Max: 100"], color: Color(red: 148/255, green: 163/255, blue: 185/255)),
                 Slots(image: "instant5", title: "Coin Flip", desc: "Heads or tails? Make your choice", array: ["Min: 5", "Max: 500"], color: Color(red: 251/255, green: 191/255, blue: 36/255))]
    
    var lockedSlots = [Slots(image: "instant1", title: "Plinko", desc: "Drop the ball and watch it bounce", array: ["Min: 5", "Max: 100"], color: Color(red: 35/255, green: 212/255, blue: 238/255)),
                       Slots(image: "instant2", title: "Dice Roll", desc: "Roll the dice and predict the outcome", array: ["Min: 5", "Max: 150"], color: Color(red: 251/255, green: 146/255, blue: 61/255)),
                       Slots(image: "instant3", title: "Wheel of Fortune", desc: "Spin the wheel for big prizes", array: ["Min: 10", "Max: 200"], color: Color(red: 243/255, green: 114/255, blue: 182/255)),
                       Slots(image: "instant4", title: "Mines", desc: "Avoid the mines and collect rewards.", array: ["Min: 10", "Max: 100"], color: Color(red: 148/255, green: 163/255, blue: 185/255)),
                       Slots(image: "instant5", title: "Coin Flip", desc: "Heads or tails? Make your choice", array: ["Min: 5", "Max: 500"], color: Color(red: 251/255, green: 191/255, blue: 36/255))]
    
    @State var showAlert = false
    @State  var coin = UserDefaultsManager.shared.coins
    @State var isCrasht1 = false
    @State var isCrasht2 = false
    @State var isCrasht3 = false
    @State var isCrasht4 = false
    @State var isCrasht5 = false
    
    var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                
                Color.clear
                    .overlay(
                        ZStack {
                            Image("bgMain")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            
                            LinearGradient(colors: [Color(red: 21/255, green: 51/255, blue: 62/255),
                                                    Color(red: 63/255, green: 22/255, blue: 105/255)], startPoint: .leading, endPoint: .trailing).opacity(0.4)
                        }
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
                    
                    VStack {
                        HStack {
                            Spacer()
                            
                            HStack {
                                Image("coins")
                                    .resizable()
                                    .frame(width: 24, height: 31)
                                
                                Text("\(coin)")
                                    .font(.custom("PaytoneOne-Regular", size: 18))
                                    .foregroundStyle(Color(red: 245/255, green: 199/255, blue: 61/255))
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(red: 120/255, green: 0/255, blue: 240/255), lineWidth: 3)
                            }
                            .padding(.top, UIScreen.main.bounds.width > 1000 ? -10 : 15)
                        }
                        
                        ScrollView(showsIndicators: false) {
                            HStack {
                                Spacer()
                                Color.clear.frame(width: 0)
                                
                                VStack {
                                    VStack {
                                        Text("Instant Games")
                                            .font(.custom("PaytoneOne-Regular", size: 32))
                                            .foregroundStyle(Color(red: 37/255, green: 210/255, blue: 238/255))
                                        
                                        Text("Quick games, instant wins!")
                                            .font(.custom("PaytoneOne-Regular", size: 15))
                                            .foregroundStyle(Color(red: 204/255, green: 204/255, blue: 204/255))
                                    }
                                    
                                    LazyVGrid(columns: [GridItem(.flexible(minimum: 200, maximum: 210)),
                                                        GridItem(.flexible(minimum: 200, maximum: 210)),
                                                        GridItem(.flexible(minimum: 200, maximum: 210))]) {
                                        ForEach(slots, id: \.id) { item in
                                            ZStack(alignment: .top) {
                                                Rectangle()
                                                    .fill(LinearGradient(colors: [Color(red: 20/255, green: 20/255, blue: 20/255),
                                                                                  Color(red: 38/255, green: 38/255, blue: 38/255)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                                    .frame(width: 200, height: 190)
                                                    .overlay {
                                                        RoundedRectangle(cornerRadius: 12)
                                                            .stroke(Color(red: 96/255, green: 78/255, blue: 32/255), lineWidth: 3)
                                                            .overlay {
                                                                VStack(alignment: .leading) {
                                                                    Spacer()
                                                                    
                                                                    Text(item.title)
                                                                        .font(.custom("PaytoneOne-Regular", size: 18))
                                                                        .foregroundStyle(item.color ?? .white)
                                                                    
                                                                    Text(item.desc)
                                                                        .font(.custom("PaytoneOne-Regular", size: 10))
                                                                        .minimumScaleFactor(0.8)
                                                                        .lineLimit(1)
                                                                        .foregroundStyle(Color(red: 204/255, green: 204/255, blue: 204/255))
                                                                    
                                                                    HStack {
                                                                        ForEach(0..<2, id: \.self) { index in
                                                                            Text(item.array[index])
                                                                                .font(.custom("PaytoneOne-Regular", size: 9))
                                                                                .foregroundStyle(Color(red: 204/255, green: 204/255, blue: 204/255))
                                                                                .padding(.horizontal, 10)
                                                                                .padding(.vertical, 3)
                                                                                .background(Color(red: 38/255, green: 37/255, blue: 37/255))
                                                                                .cornerRadius(5)
                                                                        }
                                                                    }
                                                                    
                                                                    Button(action: {
                                                                        switch item.image {
                                                                        case "instant1": isCrasht1 = true
                                                                        case "instant2": isCrasht2 = true
                                                                        case "instant3": isCrasht3 = true
                                                                        case "instant4": isCrasht4 = true
                                                                        case "instant5": isCrasht5 = true
                                                                        default:
                                                                            isCrasht1 = true
                                                                        }
                                                                    }) {
                                                                        Text("Play Now")
                                                                            .font(.custom("PaytoneOne-Regular", size: 10))
                                                                            .frame(minWidth: 0, maxWidth: .infinity)
                                                                            .foregroundStyle(Color.black)
                                                                            .padding(.horizontal, 10)
                                                                            .padding(.vertical, 7)
                                                                            .background(LinearGradient(colors: [Color(red: 6/255, green: 182/255, blue: 212/255),
                                                                                                                Color(red: 59/255, green: 130/255, blue: 246/255)], startPoint: .leading, endPoint: .trailing))
                                                                            .cornerRadius(5)
                                                                            .overlay {
                                                                                RoundedRectangle(cornerRadius: 5)
                                                                                    .stroke(Color(red: 102/255, green: 232/255, blue: 249/255))
                                                                            }
                                                                    }
                                                                }
                                                                .padding(.horizontal)
                                                                .padding(.bottom, 10)
                                                            }
                                                    }
                                                
                                                Image(item.image)
                                                    .resizable()
                                                    .frame(width: 200, height: 70)
                                            }
                                            .cornerRadius(12)
                                        }
                                        
                                        ForEach(lockedSlots, id: \.id) { item in
                                            ZStack(alignment: .bottom) {
                                                ZStack(alignment: .top) {
                                                    Rectangle()
                                                        .fill(LinearGradient(colors: [Color(red: 20/255, green: 20/255, blue: 20/255),
                                                                                      Color(red: 38/255, green: 38/255, blue: 38/255)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                                        .frame(width: 200, height: 190)
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 12)
                                                                .stroke(Color(red: 96/255, green: 78/255, blue: 32/255), lineWidth: 3)
                                                                .overlay {
                                                                    VStack(alignment: .leading) {
                                                                        Spacer()
                                                                        
                                                                        Text(item.title)
                                                                            .font(.custom("PaytoneOne-Regular", size: 18))
                                                                            .foregroundStyle(Color(red: 245/255, green: 199/255, blue: 61/255))
                                                                        
                                                                        Text(item.desc)
                                                                            .font(.custom("PaytoneOne-Regular", size: 10))
                                                                            .minimumScaleFactor(0.8)
                                                                            .foregroundStyle(Color(red: 204/255, green: 204/255, blue: 204/255))
                                                                        
                                                                        HStack {
                                                                            ForEach(0..<2, id: \.self) { index in
                                                                                Text(item.array[index])
                                                                                    .font(.custom("PaytoneOne-Regular", size: 9))
                                                                                    .foregroundStyle(Color(red: 204/255, green: 204/255, blue: 204/255))
                                                                                    .padding(.horizontal, 10)
                                                                                    .padding(.vertical, 3)
                                                                                    .background(Color(red: 38/255, green: 37/255, blue: 37/255))
                                                                                    .cornerRadius(5)
                                                                            }
                                                                        }
                                                                        
                                                                        Button(action: {
                                                                       
                                                                        }) {
                                                                            Text("Play Now")
                                                                                .font(.custom("PaytoneOne-Regular", size: 10))
                                                                                .frame(minWidth: 0, maxWidth: .infinity)
                                                                                .foregroundStyle(Color.black)
                                                                                .padding(.horizontal, 10)
                                                                                .padding(.vertical, 7)
                                                                                .background(LinearGradient(colors: [Color(red: 245/255, green: 157/255, blue: 11/255),
                                                                                                                    Color(red: 249/255, green: 115/255, blue: 23/255)], startPoint: .leading, endPoint: .trailing))
                                                                                .cornerRadius(5)
                                                                                .overlay {
                                                                                    RoundedRectangle(cornerRadius: 5)
                                                                                        .stroke(Color(red: 245/255, green: 199/255, blue: 61/255))
                                                                                }
                                                                        }
                                                                    }
                                                                    .padding(.horizontal)
                                                                    .padding(.bottom, 10)
                                                                }
                                                        }
                                                    
                                                    Image(item.image)
                                                        .resizable()
                                                        .frame(width: 200, height: 70)
                                                }
                                                .cornerRadius(12)
                                                .blur(radius: 7)
                                                
                                                Button(action: {
                                                    showAlert = true
                                                }) {
                                                    HStack(spacing: 5) {
                                                        Text("Buy 1000000")
                                                            .font(.custom("PaytoneOne-Regular", size: 10))

                                                            .foregroundStyle(Color.black)
                                                        
                                                        Image("coins")
                                                            .resizable()
                                                            .frame(width: 24, height: 24)
                                                    }
                                                    .frame(minWidth: 0, maxWidth: .infinity)
                                                    .padding(.horizontal, 10)
                                                    .padding(.vertical, 2)
                                                    .background(LinearGradient(colors: [Color(red: 245/255, green: 157/255, blue: 11/255),
                                                                                        Color(red: 249/255, green: 115/255, blue: 23/255)], startPoint: .leading, endPoint: .trailing))
                                                    .cornerRadius(5)
                                                    .overlay {
                                                        RoundedRectangle(cornerRadius: 5)
                                                            .stroke(Color(red: 245/255, green: 199/255, blue: 61/255))
                                                    }
                                                    .padding(.bottom, 10)
                                                }
                                                .padding(.horizontal)
                                                .alert("You don't have enough coins to unlock it", isPresented: $showAlert) {
                                                    Button("OK") {}
                                                }
                                            }
                                        }
                                    }
                                }
                                
                                if UIScreen.main.bounds.width > 1000 {
                                    Spacer()
                                    Color.clear.frame(width: 0)
                                }
                            }
                        }
                        .padding(.top, 5)
                    }
                    .padding(.trailing)
                }
            }
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: Notification.Name("RefreshData"), object: nil, queue: .main) { _ in
                self.coin = UserDefaultsManager.shared.coins
            }
        }
        .fullScreenCover(isPresented: $isCrasht1) {
            PlinkoView()
        }
        .fullScreenCover(isPresented: $isCrasht2) {
            DiceRollView()
        }
        .fullScreenCover(isPresented: $isCrasht3) {
            WheelView()
        }
        .fullScreenCover(isPresented: $isCrasht4) {
            MinesView()
        }
        .fullScreenCover(isPresented: $isCrasht5) {
            CoinFlipView()
        }
    }
}

#Preview {
    InstantGameView()
}

