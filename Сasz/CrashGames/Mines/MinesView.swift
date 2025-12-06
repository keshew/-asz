import SwiftUI

struct MinesView: View {
    @StateObject var viewModel =  MinesViewModel()
    @Environment(\.presentationMode) var presentationMode
    let columns = Array(repeating: GridItem(.fixed(40), spacing: 0), count: 5)
    
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
                                        Image("minesBg")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 550, height: 290)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 14)
                                                    .stroke(Color(red: 251/255, green: 146/255, blue: 61/255), lineWidth: 7)
                                                    .overlay {
                                                        VStack(spacing: 5) {
                                                            VStack(spacing: 0) {
                                                                LazyVGrid(columns: columns, spacing: 5) {
                                                                    ForEach(viewModel.cards.indices, id: \.self) { index in
                                                                        let card = viewModel.cards[index]
                                                                        Button(action: {
                                                                            viewModel.openCard(at: index)
                                                                        }) {
                                                                            if card.isOpened {
                                                                                Rectangle()
                                                                                    .fill(
                                                                                        LinearGradient(
                                                                                            colors: card.isBomb
                                                                                            ? [Color.red.opacity(0.8), Color.red.opacity(0.6)]
                                                                                            : [Color.green.opacity(0.7), Color.green.opacity(0.4)],
                                                                                            startPoint: .topLeading,
                                                                                            endPoint: .bottomTrailing
                                                                                        )
                                                                                    )
                                                                                    .overlay {
                                                                                        RoundedRectangle(cornerRadius: 6)
                                                                                            .stroke(
                                                                                                card.isBomb
                                                                                                ? Color.red.opacity(0.9)
                                                                                                : Color.green.opacity(0.9),
                                                                                                lineWidth: 3
                                                                                            )
                                                                                            .overlay(
                                                                                                Image(card.image)
                                                                                                    .resizable()
                                                                                                    .aspectRatio(contentMode: .fit)
                                                                                                    .frame(width: 25, height: 25)
                                                                                            )
                                                                                    }
                                                                                    .frame(width: 33, height: 33)
                                                                                    .cornerRadius(6)
                                                                                    .padding(.horizontal, 5)
                                                                                    .shadow(
                                                                                        color: card.isBomb
                                                                                        ? Color.red.opacity(0.8)
                                                                                        : Color.green.opacity(0.7),
                                                                                        radius: 10
                                                                                    )
                                                                            } else {
                                                                                Rectangle()
                                                                                    .fill(
                                                                                        LinearGradient(
                                                                                            colors: [Color(red: 38/255, green: 38/255, blue: 38/255)],
                                                                                            startPoint: .topLeading,
                                                                                            endPoint: .bottomTrailing
                                                                                        )
                                                                                    )
                                                                                    .overlay(
                                                                                        RoundedRectangle(cornerRadius: 8)
                                                                                            .stroke(Color(red: 148/255, green: 163/255, blue: 185/255), lineWidth: 2)
                                                                                    )
                                                                                    .frame(width: 33, height: 33)
                                                                                    .cornerRadius(8)
                                                                                    .padding(.horizontal, 5)
                                                                            }
                                                                        }
                                                                        .disabled(card.isOpened || !viewModel.isPlaying)
                                                                    }
                                                                }
                                                                .padding()
                                                                .disabled(!viewModel.isPlaying)
                                                            }

                                                            HStack(spacing: 20) {
                                                                Button(action: {
                                                                    if viewModel.bet >= 100 {
                                                                        viewModel.bet -= 50
                                                                    }
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
                                                                                    
                                                                                    Text("\(viewModel.bet)")
                                                                                        .font(.custom("PaytoneOne-Regular", size: 14))
                                                                                        .foregroundStyle(Color(red: 148/255, green: 163/255, blue: 185/255))
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
                                                                if viewModel.isPlaying {
                                                                    viewModel.getReward()
                                                                } else {
                                                                    viewModel.startGame()
                                                                }
                                                            }) {
                                                                Rectangle()
                                                                    .fill(Color(red: 224/255, green: 105/255, blue: 10/255))
                                                                    .overlay {
                                                                        RoundedRectangle(cornerRadius: 6)
                                                                            .stroke(Color(red: 252/255, green: 211/255, blue: 77/255), lineWidth: 2)
                                                                            .overlay {
                                                                                Text(viewModel.isPlaying ? "Claim" : "Start game")
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
    MinesView()
}

