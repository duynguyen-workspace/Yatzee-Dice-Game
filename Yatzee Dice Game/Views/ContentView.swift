//
//  ContentView.swift
//  Yatzee Dice Game
//
//  Created by Nguyễn Anh Duy on 21/08/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MenuView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            LeaderBoardView()
                .tabItem {
                    Label("LeaderBoard", systemImage: "list.dash")
                }
                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
