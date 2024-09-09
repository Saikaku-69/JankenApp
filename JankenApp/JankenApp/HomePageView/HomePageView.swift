import SwiftUI

struct HomePageView: View {
    @State var Vposi: CGFloat = 0
    @State var Sposi: CGFloat = 0
    
    @State var RectangleSize: CGFloat = 0
    @State var timer: Timer? = nil

    //start game
    @State var gameStart:Bool = false
    var body: some View {
        VStack {
            Spacer()

            HStack {
                ZStack {
                    Circle()
                        .fill(.blue)
                        .frame(width: 70)
                    Text("V")
                        .fontWeight(.bold)
                        .font(.system(size: 40))
                }
                .offset(x: Vposi)
                
                ZStack {
                    Circle()
                        .fill(.red)
                        .frame(width: 70)
                    Text("S")
                        .fontWeight(.bold)
                        .font(.system(size: 40))
                }
                .offset(x: Sposi)
            }
            .opacity(0.8)
            
            Spacer()

            // 持续按钮
            Image(systemName: "button.programmable")
                .font(.system(size: 50))
            
                .gesture(
                    LongPressGesture(minimumDuration: 0.5)
                        .onChanged { _ in
                            
                            logoMoving()
                            startTimer()
                            generateHapticFeedback()  // 震动效果
                        }
                        .onEnded { _ in
                            RectangleSize = 0
                        }
                )
            
            HStack {
                
                Rectangle()
                    .fill(.yellow)
                    .frame(width: RectangleSize, height: 30)
                    .animation(.easeInOut, value: RectangleSize)
                Spacer()
            }
            .frame(width:300,height: 30)
            .border(.gray, width: 1)
            
        }
        .frame(height: 400)
        .fullScreenCover(isPresented: $gameStart) {
            JankenView()
        }
    }

    private func startTimer() {
        stopTimer()  // 停止之前的计时器，防止重复
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            RectangleSize += 20
            if RectangleSize >= 300 { // 限制最大值
                stopTimer()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    gameStart = true
                }
            }
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    // 震动效果
    private func generateHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    private func logoMoving() {
        withAnimation(.easeOut(duration: 1)) {
            Vposi += 20
            Sposi -= 20
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            withAnimation(.linear(duration: 0.8)) {
                Vposi -= 220
                Sposi += 220
            }
        }
    }
}

#Preview {
    HomePageView()
}
