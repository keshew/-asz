import SwiftUI

struct TabBarView: View {
    @State private var selectedTab: CustomTabBar.TabType = .Home
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                if selectedTab == .Home {
                    HomeView()
                } else if selectedTab == .Games {
                    InstantGameView()
                } else if selectedTab == .Shop {
                    AchievmentsView()
                } else if selectedTab == .Achiev {
                    ProfileView()
                }
            }
            .frame(maxHeight: .infinity)
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 0)
            }
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TabBarView()
}

struct CustomTabBar: View {
    @Binding var selectedTab: TabType
    
    enum TabType: Int {
        case Home
        case Games
        case Shop
        case Achiev
    }
    
    var body: some View {
        ZStack {
            ZStack {
                Rectangle()
                    .fill(LinearGradient(colors: [Color(red: 21/255, green: 51/255, blue: 82/255),
                                                 Color(red: 63/255, green: 22/255, blue: 105/255)], startPoint: .top, endPoint: .bottom))
                    .frame(width: 140)
                    .edgesIgnoringSafeArea(.vertical)
            }
            
            VStack {
                Text("Name Game")
                    .font(.custom("PaytoneOne-Regular", size: 14))
                    .foregroundStyle(Color(red: 244/255, green: 211/255, blue: 113/255))
                    .padding(.horizontal)
                    .padding(.top, 37.5)
                
                Rectangle()
                    .fill(Color(red: 89/255, green: 49/255, blue: 129/255))
                    .frame(width: 140, height: 1)
                
                VStack(alignment: .leading, spacing: 15) {
                    TabBarItem(imageName: "tab1", tab: .Home, selectedTab: $selectedTab)
                    TabBarItem(imageName: "tab2", tab: .Games, selectedTab: $selectedTab)
                    TabBarItem(imageName: "tab3", tab: .Shop, selectedTab: $selectedTab)
                    TabBarItem(imageName: "tab4", tab: .Achiev, selectedTab: $selectedTab)
                }
                .padding(.horizontal, 10)
                .frame(height: 170)
                
                Spacer()
                
                VStack(spacing: 10) {
                    Rectangle()
                        .fill(Color(red: 89/255, green: 49/255, blue: 129/255))
                        .frame(width: 140, height: 1)
                    
                    HStack {
                        Image("profileImg1")
                            .resizable()
                            .frame(width: 30, height: 30)
                        
                        VStack(alignment: .leading) {
                            Text("Player")
                                .font(.custom("PaytoneOne-Regular", size: 10))
                                .foregroundStyle(.white)
                            
                            Text("Gold Tier")
                                .font(.custom("PaytoneOne-Regular", size: 10))
                                .foregroundStyle(Color(red: 244/255, green: 211/255, blue: 113/255))
                        }
                        
                        Spacer()
                    }
                    .frame(width: 120)
                    .padding(.leading)
                    
                    Spacer()
                }
                .padding(.top)
            }
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


struct TabBarItem: View {
    let imageName: String
    let tab: CustomTabBar.TabType
    @Binding var selectedTab: CustomTabBar.TabType
    
    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            if selectedTab == tab {
                Rectangle()
                    .fill(Color(red: 133/255, green: 39/255, blue: 215/255))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(red: 167/255, green: 91/255, blue: 241/255), lineWidth: 2)
                            .overlay {
                                HStack(spacing: 6) {
                                    Image(selectedTab == tab ? imageName + "Picked" : imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 16, height: 16)
                                    
                                    Text("\(tab)")
                                        .font(.custom("PaytoneOne-Regular", size: 12))
                                        .foregroundStyle(selectedTab == tab ? Color(red: 244/255, green: 211/255, blue: 113/255) : .white)
                                    
                                    Spacer()
                                }
                                .padding(.leading , 10)
                            }
                    }
                    .frame(width: 100, height: 30)
                    .cornerRadius(10)
            } else {
                HStack(spacing: 6) {
                    Image(selectedTab == tab ? imageName + "Picked" : imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                    
                    Text("\(tab)")
                        .font(.custom("PaytoneOne-Regular", size: 12))
                        .foregroundStyle(selectedTab == tab ? Color(red: 244/255, green: 211/255, blue: 113/255) : .white)
                    
                    Spacer()
                }
                .frame(width: 100, height: 30)
                .padding(.leading , 10)
            }
        }
    }
}
