/*
  LeaderboardView.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created  date: 21/08/2023
  Last modified: 07/09/2023
  Acknowledgement:
  - Environment Object, Observable Object, MVVM Model: Lecturer's Example, Week 10 Lecture Slides & Lab Tutorial
  - Custom Navigation Back Button: https://www.youtube.com/watch?v=-XcNs22WnTc
*/

import SwiftUI

struct LeaderBoardView: View {
    // MARK: ***** PROPERTIES *****
    @EnvironmentObject var leaderboardModel: LeaderBoardViewModel // Store leaderboard view model information
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode> // Store the presented value of this screen when navigated
    
    // MARK: ***** BODY VIEW *****
    var body: some View {
        ZStack {
            // MARK: ----- BACKGROUND -----
            Image("background")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            // MARK: ----- CONTENT -----
            ScrollView {
                VStack(spacing: 10) {
                    // MARK: HEADER TITLE
                    Image("leaderboard-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80)
                    Text("LEADERBOARD")
                        .font(.custom("Play-Bold", size: 40))
                        .foregroundColor(Color("secondary-color"))
                        .padding(.bottom, 40)
                    
                    // MARK: PLAYERS INFORMATION
                    VStack(spacing: 15) {
                        // Generate player row for each player saved in the leaderboard model
                        ForEach(leaderboardModel.players.indices, id: \.self) { i in
                            PlayerRow(player: $leaderboardModel.players[i])
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                    
                    // MARK: RETURN HOME BUTTON
                    Button {
                        // Return to the previous displayed view
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        GameButton(text: "Back", textColor: .black, buttonColor: Color("tertiary-color"))
                    }
                }
            }
            .padding(.top, 20)
        }
        // Hidden navigation back button
        .navigationBarBackButtonHidden(true)
        // MARK: VIEW ON RENDER EXECUTION
        .onAppear {
            // Sort and give ranking to the players in the leaderboard model
            leaderboardModel.sortPlayers()
            leaderboardModel.givePlayerRank()
        }
    }
    
}

struct LeaderBoardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderBoardView()
            .environmentObject(LeaderBoardViewModel())
    }
}
