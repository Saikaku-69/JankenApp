//
//  alertTestView.swift
//  JankenApp
//
//  Created by cmStudent on 2024/07/17.
//

import SwiftUI

struct alertTestView: View {
    
    @State var isOver:Bool = false
    @State var p1 = 0
    @State var p2 = 0
    
    var body: some View {
        
        VStack {
            
            HStack {
                Text("\(p1)")
                Text("\(p2)")
            }
            Button (action: {
                p1 += 1
                p2 += 1
                if (p1 == 5 && p2 == 5) {
                    isOver = true
                }
            }) {
                Text("Button")
            }
        }
        .alert(isPresented: $isOver) {
            Alert(title:Text("Reset"),
                  message: Text("123"),
                  primaryButton: .default(Text("リセット"), action: {
                p1 = 0
                p2 = 0
            }),
                  secondaryButton: .cancel(Text("キャンセル"), action: {
                
            })
            )
        }
    }
}

#Preview {
    alertTestView()
}
