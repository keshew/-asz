import SwiftUI

struct Aciev: Identifiable {
    var id = UUID()
    var title: String
    var desc: String
    var image: String
    var cuurentGoal: Int
    var goal: Int
    var isDone = false
}

struct AchievmentsView: View {
    @StateObject var achievmentsModel =  AchievmentsViewModel()
    var achiev = [Aciev(title: "Mine Sweeper", desc: "Reveal 15 safe tiles in Mines", image: "ach1", cuurentGoal: 0, goal: 15, isDone: true),
                  Aciev(title: "Coin Flipper", desc: "Win 20 coin flips", image: "ach2", cuurentGoal: 0, goal: 20),
                  Aciev(title: "Crash Survivor", desc: "Cash out at 5x or higher in Crash", image: "ach3", cuurentGoal: 0, goal: 5),
                  Aciev(title: "Level 10", desc: "Reach level 10", image: "ach4", cuurentGoal: 0, goal: 10),
                  Aciev(title: "Level 25", desc: "Reach level 25", image: "ach5", cuurentGoal: 0, goal: 25),
                  Aciev(title: "Level 50", desc: "Reach level 50", image: "ach6", cuurentGoal: 0, goal: 50),
                  Aciev(title: "Marathon Player", desc: "Play 100 games", image: "ach7", cuurentGoal: 0, goal: 100),
                  Aciev(title: "Risk Taker", desc: "Bet 500 coins in a single game", image: "ach8", cuurentGoal: 0, goal: 500),
                  Aciev(title: "Mega Multiplier", desc: "Win with a 10x multiplier or higher", image: "ach9", cuurentGoal: 0, goal: 10),
                  Aciev(title: "Fruit Lover", desc: "Win 100 times on Fruit Slots", image: "ach10", cuurentGoal: 0, goal: 100),
                  Aciev(title: "Classic Fan", desc: "Win 100 times on Classic Slots", image: "ach11", cuurentGoal: 0, goal: 100),
                  Aciev(title: "Gold Digger", desc: "Win 100 times on Gold Slots", image: "ach12", cuurentGoal: 0, goal: 100)]
    
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
                                
                                Text("10000")
                                    .font(.custom("PaytoneOne-Regular", size: 18))
                                    .foregroundStyle(Color(red: 245/255, green: 199/255, blue: 61/255))
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(red: 120/255, green: 0/255, blue: 240/255), lineWidth: 3)
                            }
                            .padding(.top)
                        }
                        
                        ScrollView(showsIndicators: false) {
                            HStack {
                                Spacer()
                                Color.clear.frame(width: 0)
                                
                                VStack(spacing: 20) {
                                    VStack {
                                        Text("Achievements")
                                            .font(.custom("PaytoneOne-Regular", size: 32))
                                            .foregroundStyle(Color(red: 251/255, green: 191/255, blue: 36/255))
                                        
                                        Text("Track your progress and unlock rewards")
                                            .font(.custom("PaytoneOne-Regular", size: 15))
                                            .foregroundStyle(Color(red: 204/255, green: 204/255, blue: 204/255))
                                    }
                                    
                                    Rectangle()
                                        .fill(LinearGradient(colors: [Color(red: 20/255, green: 20/255, blue: 20/255),
                                                                      Color(red: 38/255, green: 38/255, blue: 38/255)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color(red: 96/255, green: 78/255, blue: 31/255), lineWidth: 6)
                                                .overlay {
                                                    VStack {
                                                        HStack {
                                                            Text("Progress")
                                                                .font(.custom("PaytoneOne-Regular", size: 12))
                                                                .foregroundStyle(Color(red: 204/255, green: 204/255, blue: 204/255))
                                                            
                                                            Spacer()
                                                            
                                                            Text("1/12")
                                                                .font(.custom("PaytoneOne-Regular", size: 14))
                                                                .foregroundStyle(Color(red: 251/255, green: 191/255, blue: 36/255))
                                                        }
                                                        
                                                        GeometryReader { geometry in
                                                            ZStack(alignment: .leading) {
                                                                Rectangle()
                                                                    .fill(Color(red: 64/255, green: 64/255, blue: 64/255))
                                                                    .frame(width: geometry.size.width)
                                                                
                                                                Rectangle()
                                                                    .fill(LinearGradient(colors: [Color(red: 245/255, green: 157/255, blue: 11/255),
                                                                                                  Color(red: 249/255, green: 115/255, blue: 23/255)], startPoint: .leading, endPoint: .trailing))
                                                                    .frame(width: geometry.size.width - 100)
                                                            }
                                                            .cornerRadius(20)
                                                        }
                                                        .frame(height: 15)
                                                        
                                                        Text("6.5% Complete")
                                                            .font(.custom("PaytoneOne-Regular", size: 10))
                                                            .foregroundStyle(Color(red: 204/255, green: 204/255, blue: 204/255))
                                                    }
                                                    .padding()
                                                }
                                        }
                                        .frame(width: 300, height: 107)
                                        .cornerRadius(12)
                                    
                                    LazyVGrid(columns: [GridItem(.flexible(minimum: 150, maximum: 160)),
                                                        GridItem(.flexible(minimum: 150, maximum: 160)),
                                                        GridItem(.flexible(minimum: 150, maximum: 160)),
                                                        GridItem(.flexible(minimum: 150, maximum: 160))]) {
                                        ForEach(achiev, id: \.id) { item in
                                            if item.isDone {
                                                Rectangle()
                                                    .fill(LinearGradient(colors: [Color(red: 20/255, green: 83/255, blue: 45/255).opacity(0.5),
                                                                                  Color(red: 5/255, green: 78/255, blue: 59/255).opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                                    .frame(width: 150, height: 130)
                                                    .overlay {
                                                        RoundedRectangle(cornerRadius: 12)
                                                            .stroke(Color(red: 74/255, green: 222/255, blue: 129/255), lineWidth: 3)
                                                            .overlay {
                                                                VStack(alignment: .leading) {
                                                                    HStack {
                                                                        Image(item.image)
                                                                            .resizable()
                                                                            .aspectRatio(contentMode: .fit)
                                                                            .frame(width: 30, height: 30)
                                                                        
                                                                        Spacer()
                                                                        
                                                                        Image("unlock")
                                                                            .resizable()
                                                                            .aspectRatio(contentMode: .fit)
                                                                            .frame(width: 25, height: 30)
                                                                    }
                                                                    
                                                                    Text(item.title)
                                                                        .font(.custom("PaytoneOne-Regular", size: 15))
                                                                        .foregroundStyle(Color(red: 74/255, green: 222/255, blue: 129/255))
                                                                    
                                                                    Text(item.desc)
                                                                        .font(.custom("PaytoneOne-Regular", size: 9))
                                                                        .minimumScaleFactor(0.8)
                                                                        .lineLimit(1)
                                                                        .foregroundStyle(Color(red: 204/255, green: 204/255, blue: 204/255))
                                                                    
                                                                    HStack {
                                                                        Image(systemName: "checkmark")
                                                                            .font(.custom("PaytoneOne-Regular", size: 14))
                                                                            .fontWeight(.medium)
                                                                            .foregroundStyle(Color(red: 74/255, green: 222/255, blue: 129/255))
                                                                        
                                                                        Text("UNLOCKED")
                                                                            .font(.custom("PaytoneOne-Regular", size: 10))
                                                                            .foregroundStyle(Color(red: 74/255, green: 222/255, blue: 129/255))
                                                                    }
                                                                    .padding(.horizontal, 10)
                                                                    .padding(.vertical, 7)
                                                                    .background(Color(red: 74/255, green: 222/255, blue: 129/255).opacity(0.2))
                                                                    .cornerRadius(12)
                                                                    .overlay {
                                                                        RoundedRectangle(cornerRadius: 12)
                                                                            .stroke(Color(red: 74/255, green: 222/255, blue: 129/255).opacity(0.3))
                                                                    }
                                                                }
                                                                .padding(.horizontal, 10)
                                                            }
                                                    }
                                                    .cornerRadius(12)
                                            } else {
                                                Rectangle()
                                                    .fill(LinearGradient(colors: [Color(red: 20/255, green: 20/255, blue: 20/255).opacity(0.9),
                                                                                  Color(red: 38/255, green: 38/255, blue: 38/255).opacity(0.9)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                                    .frame(width: 150, height: 130)
                                                    .overlay {
                                                        RoundedRectangle(cornerRadius: 12)
                                                            .stroke(Color(red: 89/255, green: 89/255, blue: 89/255), lineWidth: 3)
                                                            .overlay {
                                                                VStack(alignment: .leading) {
                                                                    HStack {
                                                                        Image(item.image)
                                                                            .resizable()
                                                                            .aspectRatio(contentMode: .fit)
                                                                            .frame(width: 30, height: 30)
                                                                        
                                                                        Spacer()
                                                                        
                                                                        Image("locked")
                                                                            .resizable()
                                                                            .aspectRatio(contentMode: .fit)
                                                                            .frame(width: 30, height: 30)
                                                                    }
                                                                    
                                                                    Text(item.title)
                                                                        .font(.custom("PaytoneOne-Regular", size: 14))
                                                                        .foregroundStyle(Color(red: 126/255, green: 117/255, blue: 150/255))
                                                                    
                                                                    Text(item.desc)
                                                                        .font(.custom("PaytoneOne-Regular", size: 9))
                                                                        .minimumScaleFactor(0.8)
                                                                        .lineLimit(1)
                                                                        .foregroundStyle(Color(red: 128/255, green: 128/255, blue: 128/255))
                                                                    
                                                                    HStack {
                                                                        Image("lock")
                                                                            .resizable()
                                                                            .frame(width: 15, height: 15)
                                                                        
                                                                        Text("LOCKED")
                                                                            .font(.custom("PaytoneOne-Regular", size: 10))
                                                                            .foregroundStyle(Color(red: 128/255, green: 128/255, blue: 128/255))
                                                                    }
                                                                    .padding(.horizontal, 10)
                                                                    .padding(.vertical, 7)
                                                                    .background(Color(red: 38/255, green: 38/255, blue: 38/255).opacity(0.5))
                                                                    .cornerRadius(12)
                                                                    .overlay {
                                                                        RoundedRectangle(cornerRadius: 12)
                                                                            .stroke(Color(red: 38/255, green: 38/255, blue: 38/255).opacity(0.3))
                                                                    }
                                                                }
                                                                .padding(.horizontal, 10)
                                                            }
                                                    }
                                                    .cornerRadius(12)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.top, 5)
                    }
                    .padding(.trailing)
                }
            }
        }
    }
}

#Preview {
    AchievmentsView()
}

