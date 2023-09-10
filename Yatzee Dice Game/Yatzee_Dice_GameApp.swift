/*
  Yatzee_Dice_GameApp.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created date: 21/08/2023
  Last modified: 07/09/2023
  Acknowledgement:
  - Environment Object, StateObject: Lecturer's Example, Week 10 Lecture Slides & Lab Tutorial
*/

import SwiftUI

@main
struct Yatzee_Dice_GameApp: App {
    @StateObject var leaderboardModel: LeaderBoardViewModel = LeaderBoardViewModel()
    @StateObject var gameModel: GameViewModel = GameViewModel()
    @StateObject var menuModel: MenuViewModel = MenuViewModel()
    
    var body: some Scene {
        WindowGroup {
            AnimatingView()
                .environmentObject(leaderboardModel)
                .environmentObject(gameModel)
                .environmentObject(menuModel)
        }
    }
}
