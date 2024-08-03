//
//  MainView.swift
//  JankenApp
//
//  Created by cmStudent on 2024/07/05.
//

import SwiftUI

struct JankenView: View {
    
    @State var selectedOption = 1
    
    var body: some View {
        
        Picker(selection: $selectedOption, label: Text("Mode")) {
            Text("簡単").tag(0)
            Text("普通").tag(1)
            Text("困難").tag(2)
        }
        
        switch selectedOption {
        case 0:
            EasyModeView()
        case 1:
            NormalModeView()
        case 2:
            ImpossibleModeView()
        default:
            EmptyView()
        }
    }
}

#Preview {
    JankenView()
}
