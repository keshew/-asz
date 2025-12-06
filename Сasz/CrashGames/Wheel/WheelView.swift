import SwiftUI

struct WheelView: View {
    @StateObject var viewModel =  WheelViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    
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
                                        Image("wheelBg")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 550, height: 290)
                                            .opacity(0.6)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 14)
                                                    .stroke(Color(red: 243/255, green: 114/255, blue: 182/255), lineWidth: 7)
                                                    .overlay {
                                                        VStack(spacing: 5) {
                                                            ZStack {
                                                                ZStack {
                                                                    Circle()
                                                                        .stroke(lineWidth: 5)
                                                                        .foregroundColor(Color(red: 243/255, green: 114/255, blue: 182/255))
                                                                    
                                                                    Circle()
                                                                        .stroke(lineWidth: 10)
                                                                        .foregroundColor(.clear)
                                                                    
                                                                    ForEach(viewModel.segments.indices) { i in
                                                                        let segmentCount = viewModel.segments.count
                                                                        let segmentAngle = 360.0 / Double(segmentCount)
                                                                        let midAngle = Double(i) * segmentAngle + segmentAngle / 2 - 90
                                                                        
                                                                        SectorShape(
                                                                            startAngle: Angle(degrees: Double(i) * segmentAngle),
                                                                            endAngle: Angle(degrees: Double(i + 1) * segmentAngle)
                                                                        )
                                                                        .fill(viewModel.segments[i].color)
                                                                        .shadow(color: viewModel.selectedSegmentIndex == i ? Color.yellow.opacity(0.8) : Color.clear,
                                                                                radius: viewModel.selectedSegmentIndex == i ? 15 : 0, x: 0, y: 0)
                                                                        .overlay(
                                                                            Text(viewModel.segments[i].title)
                                                                                .font(.custom("PaytoneOne-Regular", size: 16))
                                                                                .foregroundStyle(Color(red: 253/255, green: 255/255, blue: 193/255))
                                                                                .rotationEffect(Angle(degrees: midAngle + viewModel.rotationDegree))
                                                                                .position(
                                                                                    x: 75 + 50 * CGFloat(cos(midAngle * .pi / 180)),
                                                                                    y: 75 + 50 * CGFloat(sin(midAngle * .pi / 180))
                                                                                )
                                                                        )
                                                                        .onTapGesture {
                                                                            viewModel.selectedSegmentIndex = i
                                                                        }
                                                                    }
                                                                }
                                                                .frame(width: 150, height: 150)
                                                                .rotationEffect(Angle(degrees: viewModel.rotationDegree))
                                                                
                                                                Triangle()
                                                                    .fill(Color(red: 243/255, green: 114/255, blue: 182/255))
                                                                    .scaleEffect(y: -1)
                                                                    .frame(width: 20, height: 20)
                                                                    .offset(y: -75)
                                                            }
                                                            .offset(y: -15)
                                                            .padding(.top, 20)
                                                            .alert("Attention", isPresented: $showAlert, actions: {
                                                                Button("OK", role: .cancel) {}
                                                            }, message: {
                                                                Text(viewModel.selectedSegmentIndex == nil ? "Please select a segment before spinning." : "Please set a valid bet amount.")
                                                            })
                                                            
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
                                                                withAnimation {
                                                                    if viewModel.selectedSegmentIndex == nil {
                                                                        showAlert = true
                                                                    } else if viewModel.bet <= 0 {
                                                                        showAlert = true
                                                                    } else {
                                                                        viewModel.spinWheel()
                                                                    }
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
    WheelView()
}

struct SectorShape: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        path.move(to: center)
        path.addArc(center: center,
                    radius: rect.width/2,
                    startAngle: startAngle - Angle(degrees: 90),
                    endAngle: endAngle - Angle(degrees: 90),
                    clockwise: false)
        path.closeSubpath()
        return path
    }
}
