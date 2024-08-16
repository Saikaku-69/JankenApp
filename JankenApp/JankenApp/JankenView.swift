//
//  JankenView_new.swift
//  JankenApp
//
//  Created by cmStudent on 2024/07/05.
//

import SwiftUI

struct JankenView: View {
    
    let janken = ["jenikame","hitokage","suantouwangba"]
    
    @State var isSwitch: Bool = false
    
    @State var com = "?"
    @State var result = "結果"
    
    @State var comscore = 0
    @State var playerscore = 0
    @State var count = 0
    
    @State var life = 5
    @State var tekilife = 5
    @State var lifebase = 5
    
    @State var isShow: Bool = false
    @State var kinshi = false
    
    @State var timer: Timer?
    
    @State var isEnd : Bool = false
    @State var isResult : Bool = false
    @State var isResult2: Bool = false
    @State var isModal: Bool = false
    @State var isModal2: Bool = false
    
    var body: some View {
        
        ZStack {
            
            //启动开关
            Toggle (isOn: $isSwitch) {
                HStack {
                    if isSwitch {
                        Text("中止")
                        Image(systemName: "pause.fill")
                        
                    } else {
                        Text("開始")
                        Image(systemName: "play.fill")
                    }
                }
            }
            .position(x: -50, y: -210)
            .frame(width: 120, height: 40)
            
            VStack {
                
                // 敵life & リセットボタン
                ZStack {
                    HStack {
                        ForEach( 0 ..< lifebase, id: \.self) { _ in
                            Image("life_base")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                        }
                        Spacer()
                    }
                    HStack {
                        ForEach( 0 ..< tekilife, id: \.self) { _ in
                            Image("pokemonball")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 20, height: 20)
                        }
                        Spacer()
                        Button(action: {
                            playerscore = 0
                            comscore = 0
                            count = 0
                            life = 5
                            tekilife = 5
                        }) {
                            Image(systemName: "goforward")
                                .font(.title)
                                .foregroundColor(.black)
                        }
                    }
                }
                .padding(.horizontal)
                .frame(width: UIScreen.main.bounds.width)
                .offset(x: -3, y: 21)
                
                //結果によるBool
                ZStack {
                    
                    if isResult {
                        Image("result_img")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35)
                            .offset(x: 35, y: -60)
                    } else {
                        
                    }
                    
                    //相手の状態
                    HStack {
                        VStack {
                            Image("rightmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:210)
                            Spacer()
                            
                            //原来启动开关的位置
                            
                        }
                        .frame(width: 100, height: 100)
                        Spacer()
                        Image("com_img")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200)
                    }
                    .padding(.leading, 30)
                    .padding(.trailing, 10)
                    .frame(width: UIScreen.main.bounds.width)
                }
                //敵のButton & ゲーム回数
                Spacer()
                
                ZStack {
                    ZStack {
                        if isModal {
                            Image("pokemon_mark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:30)
                        } else {
                            
                        }
                    }
                    .font(.system(size: 20))
                    .offset(y:80)
                    
                    HStack {
                        Spacer()
                        VStack {
                            
                            HStack {
                                Text("Round:")
                                    .padding(.leading, 10)
                                    .frame(width:80)
                                ZStack {
                                    Text("\(count)")
                                        .padding(.horizontal,15)
                                        .foregroundColor(.white)
                                        .frame(width:55)
                                }.frame(width:55)
                                
                            }
                            .background(.green)
                            .cornerRadius(7)
                            .padding(.bottom,3)
                            
                            HStack {
                                Text("敵       : ")
                                    .padding(.leading, 10)
                                    .frame(width:80)
                                ZStack {
                                    Text("\(comscore)")
                                        .padding(.horizontal,15)
                                        .foregroundColor(.white)
                                        .frame(width:55)
                                }.frame(width:55)
                            }
                            .background(.yellow)
                            .cornerRadius(7)
                            .padding(.bottom,3)
                            
                            HStack {
                                Text("Player:")
                                    .padding(.leading, 10)
                                    .frame(width:80)
                                ZStack {
                                    Text("\(playerscore)")
                                        .padding(.horizontal,15)
                                        .foregroundColor(.white)
                                        .frame(width:55)
                                }.frame(width:55)
                            }
                            .background(.gray)
                            .cornerRadius(7)
                            .padding(.bottom,3)
                            
                        }
                        .offset(x: 10)
                        // [!VStack]
                        
                    }.frame(width:UIScreen.main.bounds.width)
                    Button("") {
                        com = janken.randomElement()!
                    }
                    Image(com)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 90)
                }
                Spacer()
                
                //中間  [スコアの状態]
                HStack {
                    Spacer()
                    VStack {
                        Text("敵")
                        Text("\(comscore)")
                            .font(.system(size: 100))
                    }.offset(y: -30)
                        .frame(width: 130)
                    
                    Spacer()
                    ZStack {
                        Rectangle()
                            .foregroundColor(.orange)
                            .frame(width: 10, height:140)
                            .cornerRadius(5)
                            .rotationEffect(.degrees(30), anchor: .center)
                        Text("VS")
                            .fontWeight(.bold)
                            .font(.largeTitle)
                            .background()
                    }.padding(.vertical)
                    Spacer()
                    
                    VStack {
                        Text("Player")
                        Text("\(playerscore)")
                            .font(.system(size: 100))
                            .foregroundColor(.red)
                    }.offset(y: 30)
                        .frame(width: 130)
                    Spacer()
                }
                Spacer()
                
                //開始ボタン
                ZStack {
                    ZStack {
                        if isModal2 {
                            Image("pokemon_mark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:30)
                        } else {
                            
                        }
                    }
                    .font(.system(size: 20))
                    .offset(y:-70)
                    
                    HStack {
                        ForEach (janken, id: \.self) { item in
                            Button(action: {
                                stop()
                                let player = item
                                com = janken.randomElement()!
                                result = game(player: player, com: com)
                                if result == "win" {
                                    playerscore += 1
                                    tekilife -= 1
                                    isResult = true
                                    isModal2 = true
                                } else {
                                    if result == "lose" {
                                        comscore += 1
                                        life -= 1
                                        isResult2 = true
                                        isModal = true
                                    }
                                }
                                count += 1
                                kinshi = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.start()
                                    kinshi = false
                                    isResult = false
                                    isResult2 = false
                                    isModal = false
                                    isModal2 = false
                                }
                                // life,tekilife確認
                                if life == 0 || tekilife == 0 {
                                    isEnd = true
                                }
                            }) {
                                Image(item)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80)
                            }
                            .frame(width: UIScreen.main.bounds.width/3-20)
                            .disabled(kinshi)
                        }
                        .font(.largeTitle)
                    }.padding(.top)
                }
                Spacer()
                
                //comment
                ZStack {
                    if isResult2 {
                        Image("myself_coment")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                            .offset(x: -70, y: -40)
                    } else {
                        
                    }
                    
                    //Playerの状態
                    
                    HStack {
                        Image("player_img")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200)
                        Spacer()
                        VStack {
                            ZStack {
                                HStack {
                                    Spacer()
                                    ForEach (0 ..< life, id: \.self) { _ in
                                        Image("pokemonball")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20)
                                    }
                                }
                                //排列背景
                                HStack {
                                    Spacer()
                                    ForEach( 0 ..< lifebase, id: \.self) { _ in
                                        Image("life_base")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20)
                                        
                                        
                                    }
                                }
                            }
                            .offset(x: 10, y: 5)
                            Image("leftmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200)
                                .offset(x:15)
                        }
                    }
                    .padding(.trailing, 30)
                    .padding(.leading, 0)
                    .frame(width: UIScreen.main.bounds.width)
                    
                    //  <!HStack>
                    
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
            .disabled(!isSwitch)
        }
        .frame(width: UIScreen.main.bounds.width)
        // [!ZStack]
        
        //アラートの設定
        .alert(isPresented: $isEnd) {
            Alert(title:Text("結果"),
                  message: Text(
                    "----敵----：\(comscore)点\n--Player--：\(playerscore)点\n\n優勝者は：\(playerscore == 0 && comscore != 0 ? "---敵---" : "---Player---")"),
                  primaryButton: .destructive(Text("リセット"),action: {
                playerscore = 0
                comscore = 0
                count = 0
                life = 5
                tekilife = 5
            }),
                  secondaryButton: .default(Text("続きから"),action: {
                life = 5
                tekilife = 5
            })
            )
        }
    }
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.08, repeats: true) { _ in
            if  isSwitch {
                com = self.janken.randomElement()!
            }
        }
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
}

func game(player: String, com: String) -> String {
    if player == com {
        return "same"
    } else if (player == "jenikame" && com == "hitokage") ||
                (player == "hitokage" && com == "suantouwangba") ||
                (player == "suantouwangba" && com == "jenikame") {
        return "win"
    } else {
        return "lose"
    }
}

#Preview {
    JankenView()
}
