//
//  HomePageView.swift
//  JankenApp
//
//  Created by cmStudent on 2024/08/04.
//

import SwiftUI

struct HomePageView: View {
    @State var isPlay: Bool = false
    
    var body: some View {
        Button(action: {
            isPlay = true
        }) {
            Text("Hello, World!")
                .foregroundColor(.black)
                .padding()
                .background(Color.green)
                .cornerRadius(30)
        }
        .fullScreenCover(isPresented: $isPlay) {
            JankenView()
        }
        
    }
}

#Preview {
    HomePageView()
}
