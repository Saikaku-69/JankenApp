import SwiftUI

struct HomePageView: View {
    @State var isPlay: Bool = false
    @State var Vposi: CGFloat = 0
    @State var Sposi: CGFloat = 0
    
    @State var RectangleSize: CGFloat = 0
    @State var timer: Timer? = nil

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
                            startTimer()
                            generateHapticFeedback()  // 震动效果
                        }
                        .onEnded { _ in
                            stopTimer()
                            generateHapticFeedback()  // 震动效果
                        }
                )
            
            Rectangle()
                .fill(.yellow)
                .frame(width: RectangleSize, height: 30)
                .animation(.easeInOut, value: RectangleSize)
        }
        .frame(height: 400)
        .fullScreenCover(isPresented: $isPlay) {
            JankenView()
        }
    }

    private func startTimer() {
        stopTimer()  // 停止之前的计时器，防止重复
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            RectangleSize += 10
            if RectangleSize >= 300 { // 限制最大值
                stopTimer()
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
}

#Preview {
    HomePageView()
}
