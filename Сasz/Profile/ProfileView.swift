import SwiftUI

struct ProfileView: View {
    @StateObject var profileModel =  ProfileViewModel()
    @State var profileImg = "profileImg1"
    
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
                                        Text("Your Profile")
                                            .font(.custom("PaytoneOne-Regular", size: 32))
                                            .foregroundStyle(Color(red: 244/255, green: 211/255, blue: 113/255))
                                        
                                        Text("Track your stats and customize your experience")
                                            .font(.custom("PaytoneOne-Regular", size: 14))
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.5)
                                            .foregroundStyle(Color(red: 244/255, green: 211/255, blue: 113/255))
                                    }
                                    
                                    VStack {
                                        HStack {
                                            Rectangle()
                                                .fill(Color(red: 61/255, green: 34/255, blue: 89/255))
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .stroke(Color(red: 89/255, green: 49/255, blue: 129/255), lineWidth: 6)
                                                        .overlay {
                                                            VStack(alignment: .leading) {
                                                                Text("Player Info")
                                                                    .font(.custom("PaytoneOne-Regular", size: 14))
                                                                    .foregroundStyle(Color(red: 244/255, green: 211/255, blue: 113/255))
                                                                
                                                                HStack {
                                                                  Image(profileImg)
                                                                        .resizable()
                                                                        .frame(width: 60, height: 60)
                                                                    
                                                                    VStack(alignment: .leading) {
                                                                        Text("Player")
                                                                            .font(.custom("PaytoneOne-Regular", size: 14))
                                                                            .foregroundStyle(Color(red: 244/255, green: 211/255, blue: 113/255))
                                                                        
                                                                        Text("Gold Tier")
                                                                            .font(.custom("PaytoneOne-Regular", size: 12))
                                                                            .foregroundStyle(Color(red: 244/255, green: 211/255, blue: 113/255))
                                                                    }
                                                                }
                                                                
                                                                HStack {
                                                                    Text("Level 5")
                                                                        .font(.custom("PaytoneOne-Regular", size: 12))
                                                                        .foregroundStyle(Color(red: 244/255, green: 211/255, blue: 113/255))
                                                                    
                                                                    Spacer()
                                                                    
                                                                    Text("350 / 500 XP")
                                                                        .font(.custom("PaytoneOne-Regular", size: 12))
                                                                        .foregroundStyle(Color(red: 244/255, green: 211/255, blue: 113/255))
                                                                }
                                                                
                                                                GeometryReader { geometry in
                                                                    ZStack(alignment: .leading) {
                                                                        Rectangle()
                                                                            .fill(Color(red: 57/255, green: 31/255, blue: 83/255))
                                                                            .frame(width: geometry.size.width)
                                                                        
                                                                        Rectangle()
                                                                            .fill(Color(red: 41/255, green: 20/255, blue: 61/255))
                                                                            .frame(width: geometry.size.width - 100)
                                                                    }
                                                                    .cornerRadius(20)
                                                                }
                                                                .frame(height: 10)
                                                                
                                                                Spacer()
                                                            }
                                                            .padding()
                                                        }
                                                }
                                                .frame(width: 300, height: 230)
                                                .cornerRadius(12)
                                            
                                            Rectangle()
                                                .fill(Color(red: 61/255, green: 34/255, blue: 89/255))
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .stroke(Color(red: 89/255, green: 49/255, blue: 129/255), lineWidth: 6)
                                                        .overlay {
                                                            VStack(alignment: .leading) {
                                                                Text("Statistics")
                                                                    .font(.custom("PaytoneOne-Regular", size: 14))
                                                                    .foregroundStyle(Color(red: 244/255, green: 211/255, blue: 113/255))
                                                              
                                                                Rectangle()
                                                                    .fill(Color(red: 68/255, green: 37/255, blue: 97/255))
                                                                    .overlay {
                                                                        HStack {
                                                                            Image("coins")
                                                                                .resizable()
                                                                                .frame(width: 25, height: 25)
                                                                            
                                                                            Text("Balance")
                                                                                .font(.custom("PaytoneOne-Regular", size: 14))
                                                                                .foregroundStyle(Color(red: 244/255, green: 211/255, blue: 113/255))
                                                                            
                                                                            Spacer()
                                                                            
                                                                            Text("10000")
                                                                                .font(.custom("PaytoneOne-Regular", size: 14))
                                                                                .foregroundStyle(Color(red: 244/255, green: 211/255, blue: 113/255))
                                                                        }
                                                                        .padding(.horizontal, 10)
                                                                    }
                                                                    .frame(height: 35)
                                                                    .cornerRadius(12)
                                                                
                                                                Rectangle()
                                                                    .fill(Color(red: 68/255, green: 37/255, blue: 97/255))
                                                                    .overlay {
                                                                        HStack {
                                                                            Image("level")
                                                                                .resizable()
                                                                                .frame(width: 25, height: 25)
                                                                            
                                                                            Text("Level")
                                                                                .font(.custom("PaytoneOne-Regular", size: 14))
                                                                                .foregroundStyle(Color(red: 244/255, green: 211/255, blue: 113/255))
                                                                            
                                                                            Spacer()
                                                                            
                                                                            Text("5")
                                                                                .font(.custom("PaytoneOne-Regular", size: 14))
                                                                                .foregroundStyle(Color(red: 244/255, green: 211/255, blue: 113/255))
                                                                        }
                                                                        .padding(.horizontal, 10)
                                                                    }
                                                                    .frame(height: 35)
                                                                    .cornerRadius(12)
                                                                
                                                                Rectangle()
                                                                    .fill(Color(red: 68/255, green: 37/255, blue: 97/255))
                                                                    .overlay {
                                                                        HStack {
                                                                            Image("achiev")
                                                                                .resizable()
                                                                                .frame(width: 25, height: 25)
                                                                            
                                                                            Text("Achievements")
                                                                                .font(.custom("PaytoneOne-Regular", size: 14))
                                                                                .foregroundStyle(Color(red: 244/255, green: 211/255, blue: 113/255))
                                                                            
                                                                            Spacer()
                                                                            
                                                                            Text("1/12")
                                                                                .font(.custom("PaytoneOne-Regular", size: 14))
                                                                                .foregroundStyle(Color(red: 244/255, green: 211/255, blue: 113/255))
                                                                        }
                                                                        .padding(.horizontal, 10)
                                                                    }
                                                                    .frame(height: 35)
                                                                    .cornerRadius(12)
                                                                
                                                                Rectangle()
                                                                    .fill(Color(red: 68/255, green: 37/255, blue: 97/255))
                                                                    .overlay {
                                                                        HStack {
                                                                            Image("tier")
                                                                                .resizable()
                                                                                .frame(width: 25, height: 25)
                                                                            
                                                                            Text("Tier")
                                                                                .font(.custom("PaytoneOne-Regular", size: 14))
                                                                                .foregroundStyle(Color(red: 244/255, green: 211/255, blue: 113/255))
                                                                            
                                                                            Spacer()
                                                                            
                                                                            Text("Gold")
                                                                                .font(.custom("PaytoneOne-Regular", size: 14))
                                                                                .foregroundStyle(Color(red: 244/255, green: 211/255, blue: 113/255))
                                                                        }
                                                                        .padding(.horizontal, 10)
                                                                    }
                                                                    .frame(height: 35)
                                                                    .cornerRadius(12)
                                                            }
                                                            .padding()
                                                        }
                                                }
                                                .frame(width: 280, height: 230)
                                                .cornerRadius(12)
                                        }
                                        
                                        Rectangle()
                                            .fill(Color(red: 61/255, green: 34/255, blue: 89/255))
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(Color(red: 89/255, green: 49/255, blue: 129/255), lineWidth: 6)
                                                    .overlay {
                                                        VStack(alignment: .leading) {
                                                            Text("Customize Avatar")
                                                                .font(.custom("PaytoneOne-Regular", size: 14))
                                                                .foregroundStyle(Color(red: 244/255, green: 211/255, blue: 113/255))
                                                            
                                                            ScrollView(.horizontal, showsIndicators: false) {
                                                                HStack {
                                                                ForEach(0..<8, id: \.self) { index in
                                                                    Button(action: {
                                                                        profileImg = "profileImg\(index + 1)"
                                                                    }) {
                                                                        Image("profileImg\(index + 1)")
                                                                            .resizable()
                                                                            .frame(width: 60, height: 60)
                                                                            .overlay {
                                                                                Circle()
                                                                                    .stroke(Color(red: 243/255, green: 204/255, blue: 7/255), lineWidth: profileImg == "profileImg\(index + 1)" ? 1 : 0)
                                                                            }
                                                                            .padding(3)
                                                                    }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        .padding()
                                                    }
                                            }
                                            .frame(width: 590, height: 130)
                                            .cornerRadius(12)
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
    ProfileView()
}

