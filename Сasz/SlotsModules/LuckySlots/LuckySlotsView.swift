import SwiftUI

struct LuckySlotsView: View {
    @StateObject var viewModel =  LuckySlotsViewModel()
    @State var isOpenPaytable = false
    @State var isOpenGameRules = false
    @Environment(\.presentationMode) var presentationMode
    var paytable = [PayTable(image: "lucky1", mult: "200x"),
                    PayTable(image: "lucky2", mult: "100x"),
                    PayTable(image: "lucky3", mult: "75x"),
                    PayTable(image: "lucky4", mult: "50x"),
                    PayTable(image: "lucky5", mult: "25x"),
                    PayTable(image: "lucky6", mult: "10x")]
    
    var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                
                Color.clear
                    .overlay(
                        ZStack {
                            Image("luckyBg")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            
                            LinearGradient(colors: [Color(red: 21/255, green: 48/255, blue: 101/255),
                                                    Color(red: 18/255, green: 66/255, blue: 95/255)], startPoint: .leading, endPoint: .trailing).opacity(0.5)
                        }
                    )
                    .clipped()
                    .ignoresSafeArea()
                
                ZStack(alignment: .bottom) {
                    Color(red: 27/255, green: 74/255, blue: 28/255).opacity(0.95)
                        .frame(height: 70)
                    
                    Rectangle()
                        .foregroundStyle(Color(red: 24/255, green: 125/255, blue: 30/255).opacity(0.3))
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
                                Button(action: {
                                    if viewModel.bet >= 20 {
                                        viewModel.bet -= 10
                                    }
                                }) {
                                    Rectangle()
                                        .fill(LinearGradient(colors: [Color(red: 245/255, green: 10/255, blue: 241/255),
                                                                      Color(red: 255/255, green: 0/255, blue: 0/255)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 4)
                                                .stroke(Color(red: 252/255, green: 211/255, blue: 77/255), lineWidth: 2)
                                                .overlay {
                                                    Text("-")
                                                        .font(.custom("PaytoneOne-Regular", size: 24))
                                                        .foregroundStyle(Color(red: 46/255, green: 255/255, blue: 2/255))
                                                        .offset(y: -2)
                                                }
                                        }
                                        .frame(width: 30, height: 30)
                                        .cornerRadius(4)
                                }
                                
                                VStack(spacing: 0) {
                                    Text("Bet")
                                        .font(.custom("PaytoneOne-Regular", size: 12))
                                        .foregroundStyle(Color(red: 187/255, green: 195/255, blue: 187/255))
                                    
                                    Text("\(viewModel.bet)")
                                        .font(.custom("PaytoneOne-Regular", size: 12))
                                        .foregroundStyle(.white)
                                }
                                
                                Button(action: {
                                    if (viewModel.bet + 10) <= viewModel.coin {
                                        viewModel.bet += 10
                                    }
                                }) {
                                    Rectangle()
                                        .fill(LinearGradient(colors: [Color(red: 245/255, green: 10/255, blue: 241/255),
                                                                      Color(red: 3/255, green: 255/255, blue: 22/255)], startPoint: .leading, endPoint: .trailing))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 4)
                                                .stroke(Color(red: 252/255, green: 211/255, blue: 77/255), lineWidth: 2)
                                                .overlay {
                                                    Text("+")
                                                        .font(.custom("PaytoneOne-Regular", size: 24))
                                                        .foregroundStyle(Color(red: 46/255, green: 255/255, blue: 2/255))
                                                        .offset(y: -2)
                                                }
                                        }
                                        .frame(width: 30, height: 30)
                                        .cornerRadius(4)
                                }
                            }
                            
                            Spacer()
                            
                            HStack {
                                Image("coins")
                                    .resizable()
                                    .frame(width: 24, height: 31)
                                
                                Text("\(viewModel.coin)")
                                    .font(.custom("PaytoneOne-Regular", size: 18))
                                    .foregroundStyle(Color(red: 46/255, green: 255/255, blue: 2/255))
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(red: 46/255, green: 255/255, blue: 2/255), lineWidth: 3)
                            }
                        }
                        .padding(.top)
                        .padding(.horizontal)
                        
                        ScrollView(showsIndicators: false) {
                            HStack {
                                Color(red: 27/255, green: 74/255, blue: 28/255).opacity(0.95)
                                    .overlay {
                                        VStack(spacing: 10) {
                                            Button(action: {
                                                withAnimation {
                                                    isOpenPaytable.toggle()
                                                    isOpenGameRules = false
                                                }
                                            }) {
                                                HStack {
                                                    Image("paytable")
                                                        .resizable()
                                                        .frame(width: 18, height: 18)
                                                    
                                                    Text("Paytable")
                                                        .font(.custom("PaytoneOne-Regular", size: 14))
                                                        .foregroundStyle(.white)
                                                    
                                                    Spacer()
                                                    
                                                    Image(systemName: isOpenPaytable ? "chevron.up" : "chevron.down")
                                                        .font(.custom("PaytoneOne-Regular", size: 12))
                                                        .foregroundStyle(.white)
                                                }
                                            }
                                            .padding(.top)
                                            
                                            if isOpenPaytable {
                                                ForEach(paytable) { table in
                                                    VStack(alignment: .leading) {
                                                        Rectangle()
                                                            .fill(Color(red: 55/255, green: 69/255, blue: 31/255))
                                                            .overlay {
                                                                HStack {
                                                                    Image(table.image)
                                                                        .resizable()
                                                                        .aspectRatio(contentMode: .fit)
                                                                        .frame(width: 18, height: 18)
                                                                    
                                                                    Spacer()
                                                                    
                                                                    Text(table.mult)
                                                                        .font(.custom("PaytoneOne-Regular", size: 12))
                                                                        .foregroundStyle(Color(red: 242/255, green: 204/255, blue: 12/255))
                                                                }
                                                                .padding(.horizontal, 10)
                                                            }
                                                            .frame(height: 30)
                                                            .cornerRadius(8)
                                                    }
                                                }
                                            }
                                            
                                            Rectangle()
                                                .fill(Color(red: 57/255, green: 62/255, blue: 70/255))
                                                .frame(height: 1)
                                                .padding(.horizontal, 5)
                                            
                                            Button(action: {
                                                withAnimation {
                                                    isOpenGameRules.toggle()
                                                    isOpenPaytable = false
                                                }
                                            }) {
                                                HStack {
                                                    Image("gameRules")
                                                        .resizable()
                                                        .frame(width: 18, height: 18)
                                                    
                                                    Text("Game Rules")
                                                        .font(.custom("PaytoneOne-Regular", size: 14))
                                                        .foregroundStyle(.white)
                                                    
                                                    Spacer()
                                                    
                                                    Image(systemName: isOpenGameRules ? "chevron.up" : "chevron.down")
                                                        .font(.custom("PaytoneOne-Regular", size: 12))
                                                        .foregroundStyle(.white)
                                                }
                                            }
                                            
                                            if isOpenGameRules {
                                                VStack(spacing: 15) {
                                                    Text("How to Play: Set your bet amount using the slider, then click the SPIN button to start the game.")
                                                        .font(.custom("PaytoneOne-Regular", size: 14))
                                                        .minimumScaleFactor(0.5)
                                                        .foregroundStyle(.white)
                                                    
                                                    Text("Winning: Match 3 or more identical symbols on the center payline to win. Your prize is multiplied by your bet amount.")
                                                        .font(.custom("PaytoneOne-Regular", size: 14))
                                                        .minimumScaleFactor(0.5)
                                                        .foregroundStyle(.white)
                                                    
                                                    Text("Auto Spin: Enable Auto Spin to automatically play consecutive rounds without manual clicking.")
                                                        .font(.custom("PaytoneOne-Regular", size: 14))
                                                        .minimumScaleFactor(0.5)
                                                        .foregroundStyle(.white)
                                                    
                                                    Text("Balance: Your balance updates in real- time. Make sure you have enough credits to place your bet.")
                                                        .font(.custom("PaytoneOne-Regular", size: 14))
                                                        .minimumScaleFactor(0.5)
                                                        .foregroundStyle(.white)
                                                }
                                            }
                                            
                                            Rectangle()
                                                .fill(Color(red: 57/255, green: 62/255, blue: 70/255))
                                                .frame(height: 1)
                                                .padding(.horizontal, 5)
                                            
                                            Button(action: {
                                                if viewModel.coin >= viewModel.bet {
                                                    viewModel.spin()
                                                }
                                            }) {
                                                Text("SPIN")
                                                    .font(.custom("PaytoneOne-Regular", size: 14))
                                                    .frame(minWidth: 0, maxWidth: .infinity)
                                                    .foregroundStyle(Color.black)
                                                    .padding(.horizontal, 10)
                                                    .padding(.vertical, 7)
                                                    .background(LinearGradient(colors: [Color(red: 59/255, green: 245/255, blue: 11/255),
                                                                                        Color(red: 24/255, green: 249/255, blue: 215/255)], startPoint: .leading, endPoint: .trailing))
                                                    .cornerRadius(5)
                                                    .overlay {
                                                        RoundedRectangle(cornerRadius: 5)
                                                            .stroke(Color(red: 86/255, green: 252/255, blue: 77/255))
                                                    }
                                            }
                                            
                                            Spacer()
                                        }
                                        .padding(.horizontal)
                                    }
                                    .frame(width: 170, height: UIScreen.main.bounds.height)
                                    .ignoresSafeArea()
                                
                                Spacer()
                                
                                VStack {
                                    Rectangle()
                                        .fill(Color(red: 32/255, green: 84/255, blue: 31/255))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 14)
                                                .stroke(Color(red: 51/255, green: 168/255, blue: 55/255), lineWidth: 7)
                                                .overlay {
                                                    VStack(spacing: 15) {
                                                        ForEach(0..<3, id: \.self) { row in
                                                            HStack(spacing: 15) {
                                                                ForEach(0..<5, id: \.self) { col in
                                                                    Rectangle()
                                                                        .fill(Color(red: 40/255, green: 123/255, blue: 36/255))
                                                                        .frame(width: 90, height: 75)
                                                                        .overlay {
                                                                            RoundedRectangle(cornerRadius: 8)
                                                                                .stroke(Color(red: 32/255, green: 159/255, blue: 35/255), lineWidth: 3)
                                                                                .overlay {
                                                                                    Image(viewModel.slots[row][col])
                                                                                        .resizable()
                                                                                        .aspectRatio(contentMode: .fit)
                                                                                        .frame(width: 55, height: 55)
                                                                                        .padding(.horizontal, 5)
                                                                                        .shadow(
                                                                                            color: viewModel.winningPositions.contains(where: { $0.row == row && $0.col == col }) ? Color.blue : .clear,
                                                                                            radius: viewModel.isSpinning ? 0 : 25
                                                                                        )
                                                                                }
                                                                        }
                                                                        .cornerRadius(8)
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                        }
                                        .frame(width: 550, height: 290)
                                        .cornerRadius(14)
                                    
                                    Spacer()
                                }
                                .padding(.top)
                                .padding(.trailing, 50)
                                
                                Spacer()
                            }
                            
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
    LuckySlotsView()
}

