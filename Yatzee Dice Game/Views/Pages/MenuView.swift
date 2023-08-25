//
//  MenuView.swift
//  Yatzee Dice Game
//
//  Created by Nguyễn Anh Duy on 21/08/2023.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("gradient-color-purple"), Color("gradient-color-pink")]), startPoint: .top, endPoint: .bottom)
            VStack {
                NavigationLink {
                    GameView()
                } label: {
                    Text("Play Game")
                        .foregroundColor(.white)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
