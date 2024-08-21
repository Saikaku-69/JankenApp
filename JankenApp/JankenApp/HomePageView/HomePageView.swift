//
//  HomePageView.swift
//  JankenApp
//
//  Created by cmStudent on 2024/08/04.
//

import SwiftUI

struct HomePageView: View {
    @State var isPlay: Bool = false
    @State var Vposi:CGFloat = -0
    @State var Sposi:CGFloat = 0
    @State var isChange: Bool = true
    @State var isSleep: Bool = true
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(.blue)
                    .frame(width: 70)
                Text("V")
                    .fontWeight(.bold)
                    .font(.system(size: 40))
            }
            .offset(x:Vposi)
            ZStack {
                Circle()
                    .fill(.red)
                    .frame(width: 70)
                Text("S")
                    .fontWeight(.bold)
                    .font(.system(size: 40))
            }
            .offset(x:Sposi)
        }
        .opacity(0.8)
        .fullScreenCover(isPresented: $isPlay) {
            JankenView()
        }
        
        HStack {
            
            ZStack {
                Button(action: {
                    isChange.toggle()
                    isAnitor()
                    isSleep = false
                }) {
                    if isChange {
                        if isSleep {
                            ZStack {
                                Image("zzz")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50)
                                    .position(x: 80, y: 20)
                                Image("pikasleep")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 70)
                                    .position(x: 50, y: 40)
                            }
                        }
                    } else {
                        Image("pikawalk")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 70)
                            .position(x: 50, y: 40)
                    }
                }
            }
        }
        .frame(height:100)
    }
    private func isAnitor() {
        Vposi += 20
        Sposi -= 20
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation(.easeInOut(duration: 1.0)) {
                VpositionAfter()
                SpositionAfter()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isPlay = true
                }
            }
        }
    }
    private func VpositionAfter() {
        Vposi -= 220
    }
    private func SpositionAfter() {
        Sposi += 220
    }
}

#Preview {
    HomePageView()
}
