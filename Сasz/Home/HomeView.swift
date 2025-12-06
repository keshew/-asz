import SwiftUI

struct HomeView: View {
    @StateObject var homeModel =  HomeViewModel()
    var slots = [Slots(image: "slot1", title: "Olymp Slots", desc: "Traditional casino experience", array: ["3x3", "Min: 10", "Max: 50"]),
                 Slots(image: "slot2", title: "Lucky Lepri Slots", desc: "Fresh and fruity wins", array: ["3x3", "Min: 5", "Max: 100"]),
                 Slots(image: "slot3", title: "Fishy Slots", desc: "Luxury jewels and riches", array: ["3x3", "Min: 20", "Max: 200"]),
                 Slots(image: "slot4", title: "Egypt Slots", desc: "Big bets and exciting wins.", array: ["3x3", "Min: 20", "Max: 200"])]
    
    var lockedSlots = [Slots(image: "slot1", title: "Olymp Slots", desc: "Traditional casino experience", array: ["3x3", "Min: 10", "Max: 50"]),
                       Slots(image: "slot2", title: "Lucky Lepri Slots", desc: "Fresh and fruity wins", array: ["3x3", "Min: 5", "Max: 100"]),
                       Slots(image: "slot3", title: "Fishy Slots", desc: "Luxury jewels and riches", array: ["3x3", "Min: 20", "Max: 200"]),
                       Slots(image: "slot4", title: "Egypt Slots", desc: "Big bets and exciting wins.", array: ["3x3", "Min: 20", "Max: 200"])]
    @State var showAlert = false
    
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
                                
                                VStack {
                                    VStack {
                                        Text("Name game")
                                            .font(.custom("PaytoneOne-Regular", size: 32))
                                            .foregroundStyle(Color(red: 245/255, green: 199/255, blue: 61/255))
                                        
                                        Text("Choose your game and spin to win big!")
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
                                                                        .foregroundStyle(Color(red: 245/255, green: 199/255, blue: 61/255))
                                                                    
                                                                    Text(item.desc)
                                                                        .font(.custom("PaytoneOne-Regular", size: 10))
                                                                        .minimumScaleFactor(0.8)
                                                                        .foregroundStyle(Color(red: 204/255, green: 204/255, blue: 204/255))
                                                                    
                                                                    HStack {
                                                                        ForEach(0..<3, id: \.self) { index in
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
                                                                            ForEach(0..<3, id: \.self) { index in
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
    HomeView()
}

