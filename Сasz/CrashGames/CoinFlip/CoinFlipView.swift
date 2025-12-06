import SwiftUI

struct CoinFlipView: View {
    @StateObject var viewModel =  CoinFlipViewModel()
    @Environment(\.presentationMode) var presentationMode
    
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
                                
                                Text("\(viewModel.coin)")
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
                                        Image("coinBg")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 550, height: 290)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 14)
                                                    .stroke(Color(red: 251/255, green: 191/255, blue: 36/255), lineWidth: 7)
                                                    .overlay {
                                                        VStack {
                                                            Text("Coin Flip")
                                                                .font(.custom("PaytoneOne-Regular", size: 18))
                                                                .foregroundStyle(Color(red: 251/255, green: 191/255, blue: 36/255))
                                                                .shadow(color: .black, radius: 1)
                                                            
                                                            ZStack {
                                                                Circle()
                                                                    .fill(Color(red: 252/255, green: 211/255, blue: 77/255))
                                                                    .frame(width: 80, height: 80)
                                                                
                                                                Circle()
                                                                    .fill(Color(red: 243/255, green: 185/255, blue: 23/255))
                                                                    .frame(width: 75, height: 75)
                                                                
                                                                Image(viewModel.rotationStep % 2 == 0 ? "head" : "trail")
                                                                    .resizable()
                                                                    .aspectRatio(contentMode: .fit)
                                                                    .frame(width: 60, height: 60)
                                                                    .rotation3DEffect(
                                                                        .degrees(Double(viewModel.rotationStep) * 360.0 / 2),
                                                                        axis: (x: 0, y: 1, z: 0)
                                                                    )
                                                                    .animation(.easeInOut(duration: 0.1), value: viewModel.rotationStep)
                                                            }
                                                            
                                                            HStack {
                                                                Button(action: {
                                                                    withAnimation {
                                                                        viewModel.isTail = false
                                                                    }
                                                                }) {
                                                                    Rectangle()
                                                                        .fill(!viewModel.isTail ? Color(red: 229/255, green: 99/255, blue: 11/255) : .black.opacity(0.5))
                                                                        .overlay {
                                                                            RoundedRectangle(cornerRadius: 8)
                                                                                .stroke(Color(red: 236/255, green: 152/255, blue: 21/255), lineWidth: 2)
                                                                                .overlay {
                                                                                    HStack(spacing: 3) {
                                                                                        Image("head")
                                                                                            .resizable()
                                                                                            .aspectRatio(contentMode: .fit)
                                                                                            .frame(width: 28, height: 28)
                                                                                        
                                                                                        Text("Heads")
                                                                                            .font(.custom("PaytoneOne-Regular", size: 14))
                                                                                            .foregroundStyle(.white)
                                                                                            .offset(y: -1)
                                                                                    }
                                                                                }
                                                                        }
                                                                        .frame(width: 123, height: 45)
                                                                        .cornerRadius(8)
                                                                }
                                                                
                                                                Button(action: {
                                                                    withAnimation {
                                                                        viewModel.isTail = true
                                                                    }
                                                                }) {
                                                                    Rectangle()
                                                                        .fill(viewModel.isTail ? Color(red: 229/255, green: 99/255, blue: 11/255) : .black.opacity(0.5))
                                                                        .overlay {
                                                                            RoundedRectangle(cornerRadius: 8)
                                                                                .stroke(Color(red: 236/255, green: 152/255, blue: 21/255), lineWidth: 2)
                                                                                .overlay {
                                                                                    HStack(spacing: 3) {
                                                                                        Image("trail")
                                                                                            .resizable()
                                                                                            .aspectRatio(contentMode: .fit)
                                                                                            .frame(width: 28, height: 28)
                                                                                        
                                                                                        Text("Tails")
                                                                                            .font(.custom("PaytoneOne-Regular", size: 14))
                                                                                            .foregroundStyle(.white)
                                                                                            .offset(y: -1)
                                                                                    }
                                                                                }
                                                                        }
                                                                        .frame(width: 123, height: 45)
                                                                        .cornerRadius(8)
                                                                }
                                                            }
                                                            
                                                            HStack(spacing: 20) {
                                                                Button(action: {
                                                                    if viewModel.bet >= 100 {
                                                                        viewModel.bet -= 50
                                                                    }
                                                                }) {
                                                                    Circle()
                                                                        .fill(Color(red: 229/255, green: 99/255, blue: 11/255))
                                                                        .overlay {
                                                                            RoundedRectangle(cornerRadius: 15)
                                                                                .stroke(Color(red: 236/255, green: 152/255, blue: 21/255).opacity(0.7), lineWidth: 2)
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
                                                                    .frame(width: 90, height: 50)
                                                                    .overlay {
                                                                        RoundedRectangle(cornerRadius: 12)
                                                                            .stroke(Color(red: 136/255, green: 107/255, blue: 30/255), lineWidth: 2)
                                                                            .overlay {
                                                                                VStack(spacing: 0) {
                                                                                    Text("Current Bet")
                                                                                        .font(.custom("PaytoneOne-Regular", size: 10))
                                                                                        .foregroundStyle(Color(red: 251/255, green: 191/255, blue: 36/255))
                                                                                    
                                                                                    Text("\(viewModel.bet)")
                                                                                        .font(.custom("PaytoneOne-Regular", size: 18))
                                                                                        .foregroundStyle(Color(red: 251/255, green: 191/255, blue: 36/255))
                                                                                }
                                                                            }
                                                                    }
                                                                    .cornerRadius(12)
                                                                
                                                                Button(action: {
                                                                    if (viewModel.bet + 50) <= viewModel.coin {
                                                                        viewModel.bet += 50
                                                                    }
                                                                }) {
                                                                    Circle()
                                                                        .fill(Color(red: 229/255, green: 99/255, blue: 11/255))
                                                                        .overlay {
                                                                            RoundedRectangle(cornerRadius: 15)
                                                                                .stroke(Color(red: 236/255, green: 152/255, blue: 21/255).opacity(0.7), lineWidth: 2)
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
                                                                    viewModel.startFlip(userChoice: viewModel.isTail)
                                                                   }
                                                            }) {
                                                                Rectangle()
                                                                    .fill(Color(red: 255/255, green: 191/255, blue: 1/255))
                                                                    .overlay {
                                                                        RoundedRectangle(cornerRadius: 6)
                                                                            .stroke(Color(red: 252/255, green: 211/255, blue: 77/255), lineWidth: 2)
                                                                            .overlay {
                                                                                HStack {
                                                                                    Image(systemName: "play")
                                                                                        .font(.custom("PaytoneOne-Regular", size: 12))
                                                                                        .foregroundStyle(.black)
                                                                                    
                                                                                    Text("FLIP COIN")
                                                                                        .font(.custom("PaytoneOne-Regular", size: 12))
                                                                                        .foregroundStyle(.black)
                                                                                }
                                                                            }
                                                                    }
                                                                    .frame(height: 26)
                                                                    .cornerRadius(6)
                                                            }
                                                            .padding(.horizontal)
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
    CoinFlipView()
}

