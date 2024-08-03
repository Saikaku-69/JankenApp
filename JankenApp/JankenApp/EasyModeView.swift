//
//  EasyModeView.swift
//  JankenApp
//
//  Created by cmStudent on 2024/07/05.
//

import SwiftUI

struct EasyModeView: View {
    
    let janken = ["shui1","huo1","cao1"]
    
    let shui = ["shui1","shui1","shui1","huo1","cao1"]
    let huo = ["huo1","huo1","huo1","shui1","cao1"]
    let cao = ["cao1","cao1","cao1","shui1","huo1"]
    
    @State var com = "?"
    @State var result = "結果"
    @State var comscore = 0
    @State var playerscore = 0
    @State var isShow: Bool = false
    
    @State var count = 0
    @State var life = 5
    @State var tekilife = 5
    @State var timer: Timer?
    @State var kinshi = false
    
    var body: some View {
        
        VStack {
            //Title
            HStack {
                Spacer()
                ForEach( 0 ..< tekilife, id: \.self) { _ in
                    Image(systemName: "heart.fill")
                        .font(.largeTitle)
                        .padding(.bottom)
                        .offset(x: 25)
                }
                Spacer()
                Button(action: {
                    playerscore = 0
                    comscore = 0
                    count = 0
                    life = 5
                    tekilife = 5
                }) {
                    Image(systemName: "trash")
                        .font(.largeTitle)
                        .foregroundColor(.black)
                }
            }.padding(.trailing)
            
            //敵のButton
            Spacer()
            ZStack {
                ZStack {
                    if result == "lose" {
                        Text("win!!")
                            .padding()
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .background(.black)
                            .clipShape(.capsule)
                    } else if (result == "win") {
                        Text("lose!!")
                    } else if (result == "same") {
                        Text("-")
                    } else {
                    }
                }
                .font(.system(size: 20))
                .offset(y:100)
                
                HStack {
                    Spacer()
                    Text("   回数:\(count)")
                        .font(.body)
                        .padding()
                }
                Button("") {
                    com = janken.randomElement()!
                }
                Image(com)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 100)
            }
            Spacer()
            
            //中間
            HStack {
                Spacer()
                VStack {
                    Text("敵")
                    Text("\(comscore)")
                        .font(.system(size: 100))
                }
                Spacer()
                
                ZStack {
                    Text("VS")
                        .fontWeight(.bold)
                        .padding()
                        .background(.blue)
                        .cornerRadius(15)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                VStack {
                    Text("Player")
                    Text("\(playerscore)")
                        .font(.system(size: 100))
                        .foregroundColor(.red)
                }
                Spacer()
            }
            
            Spacer()
            
            //開始ボタン
            
            HStack {
                Button(action: {
                    stop()
                    let player = "shui1"
                    com = huo.randomElement()!
                    result = easygame(player: player, com: com)
                    if result == "win" {
                        playerscore += 1
                        tekilife -= 1
                    } else {
                        if result == "lose" {
                            comscore += 1
                            life -= 1
                        }
                    }
                    count += 1
                    kinshi = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.start()
                        kinshi = false
                    }
                }) {
                    Image("shui1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: UIScreen.main.bounds.width/3-20)
                .disabled(kinshi)
                .font(.largeTitle)
                Button(action: {
                    stop()
                    let player = "huo1"
                    com = cao.randomElement()!
                    result = easygame(player: player, com: com)
                    if result == "win" {
                        playerscore += 1
                        tekilife -= 1
                    } else {
                        if result == "lose" {
                            comscore += 1
                            life -= 1
                        }
                    }
                    count += 1
                    kinshi = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.start()
                        kinshi = false
                    }
                }) {
                    Image("huo1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: UIScreen.main.bounds.width/3-20)
                .disabled(kinshi)
                .font(.largeTitle)
                Button(action: {
                    stop()
                    let player = "cao1"
                    com = shui.randomElement()!
                    result = easygame(player: player, com: com)
                    if result == "win" {
                        playerscore += 1
                        tekilife -= 1
                    } else {
                        if result == "lose" {
                            comscore += 1
                            life -= 1
                        }
                    }
                    count += 1
                    kinshi = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.start()
                        kinshi = false
                    }
                }) {
                    Image("cao1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: UIScreen.main.bounds.width/3-20)
                //kinshibotan
                .disabled(kinshi)
                .font(.largeTitle)
            }
            Spacer()
            
            //命のText
            HStack {
                ForEach (0 ..< life, id: \.self) { _ in
                    Image(systemName: "heart.fill")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                        .padding(.bottom)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width)
        .padding()
        .onAppear {
            self.start()
        }
        .onDisappear {
            self.stop()
        }
    }
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.08, repeats: true) { _ in
            com = self.janken.randomElement()!
        }
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
}

func easygame(player: String, com: String) -> String {
    if player == com {
        return "same"
    } else if (player == "shui1" && com == "huo1") ||
                (player == "huo1" && com == "cao1") ||
                (player == "cao1" && com == "shui1") {
        return "win"
    } else {
        return "lose"
    }
}

#Preview {
    EasyModeView()
}
