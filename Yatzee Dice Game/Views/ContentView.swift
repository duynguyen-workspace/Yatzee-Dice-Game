//
//  ContentView.swift
//  Yatzee Dice Game
//
//  Created by Nguyễn Anh Duy on 21/08/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            TabView {
                MenuView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                GameSettingView()
                    .tabItem {
                        Label("Game Settings", systemImage: "list.dash")
                    }
                LeaderBoardView()
                    .tabItem {
                        Label("LeaderBoard", systemImage: "rosette")
                    }
                InstructionView()
                    .tabItem {
                        Label("How To Play", systemImage: "questionmark.circle.fill")
                    }
                    
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
