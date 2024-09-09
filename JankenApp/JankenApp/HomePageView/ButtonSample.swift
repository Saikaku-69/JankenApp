//
//  ButtonSample.swift
//  JankenApp
//
//  Created by cmStudent on 2024/09/09.
//
import SwiftUI

struct LongPressExampleView: View {
    @State private var rectangleWidth: CGFloat = 100
    @State private var timer: Timer? = nil

    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.blue)
                .frame(width: rectangleWidth, height: 50)
                .animation(.easeInOut, value: rectangleWidth) // 动画效果

            // 长按按钮
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 50))
                .gesture(
                    LongPressGesture(minimumDuration: 0.1) // 长按触发的最小时间
                        .onChanged { _ in
                            startIncreasingWidth()
                        }
                        .onEnded { _ in
                            stopIncreasingWidth()
                        }
                )
        }
    }

    // 开始增加矩形宽度
    private func startIncreasingWidth() {
        // 确保上一个定时器被停止
        stopIncreasingWidth()
        
        // 启动新定时器
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            rectangleWidth += 10
        }
    }

    // 停止增加宽度
    private func stopIncreasingWidth() {
        timer?.invalidate()
        timer = nil
        print("定时器已停止") // 调试信息
    }
}

#Preview {
    LongPressExampleView()
}
