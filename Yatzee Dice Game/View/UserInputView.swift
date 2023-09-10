/*
  UserInputView.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created  date: 05/09/2023
  Last modified: 07/09/2023
  Acknowledgement:
  - Environment Object, Observable Object, MVVM Model: Lecturer's Example, Week 10 Lecture Slides
  - TextField: Lecturer's Example, Week 10 Lab Tutorial
  - Custom Navigation Back Button: https://www.youtube.com/watch?v=-XcNs22WnTc
*/

import SwiftUI

struct UserInputView: View {
    // MARK: ***** PROPERTIES *****
    @EnvironmentObject var leaderboardModel : LeaderBoardViewModel // Store the leaderboard view model information
    @State private var canStartGame = false // Store the validated value if the game can be started
    @State private var newName: String = "" // Store the value in the text field
    @State private var playerName: String = "" // Store the player name after the text field's value is validated
    @State private var isValidated: Bool = false // Store the validation status of the username
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode> // Store the presented value of the screen when navigated
    
    // MARK: ***** BODY VIEW *****
    var body: some View {
        NavigationStack {
            ZStack {
                // MARK: ----- BACKGROUND -----
                Background()
                
                // MARK: ----- CONTENT -----
                VStack(spacing: 15) {
                    // MARK: HEADER TITLE
                    Logo(image: Image("logo"))
                        .frame(width: 100)
                    Text("Your Information")
                        .font(.custom("Play-Bold", size: 40))
                        .foregroundColor(.white)
                    
                    // MARK: USERNAME INPUT TEXTFIELD
                    TextField("Enter Your Username", text: $newName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.custom("Play-Regular", size: 22))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 2)
                                .foregroundColor(.blue)
                        )
                    
                    // MARK: VALIDATION SUCCESSFUL MESSAGE
                    if isValidated { // Display the message if the text field is validated successfully
                        Text("Complete validation. You can start the game!")
                            .foregroundColor(.white)
                            .font(.custom("Play-Regular", size: 18))
                    }
                    
                    // MARK: BUTTONS
                    HStack {
                        // MARK: BACK BUTTON
                        Button {
                            // Remove the current view and return to the previous view
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            GameButton(text: "Back", textColor: .black, buttonColor: Color("tertiary-color"))
                        }
                        
                        // MARK: VALIDATION BUTTON
                        Button {
                            // Create an empty player
                            let player = Player(name: newName, score: 0, rank: 0, badges: [], imageName: "game-avatar")
                            
                            // Validate the player's username
                            if leaderboardModel.validatePlayer(player: player) {
                                // Update the state variables and player name accordingly
                                canStartGame = true
                                isValidated = true
                                playerName = newName
                            } else {
                                canStartGame = false
                                isValidated = false
                            }
                            
                        } label: {
                            GameButton(text: "Check", textColor: .black, buttonColor: .green)
                        }
                        // MARK: VALIDATION ERROR ALERT
                        .alert(isPresented: $leaderboardModel.showAlert) {
                            Alert(title: Text("Validation Error"), message: Text(leaderboardModel.alertMessage), dismissButton: .default(Text("Got it!")))
                        }
                    }
                    
                    // MARK: START BUTTON
                    if canStartGame { // show the start button if the game can be started
                        NavigationLink {
                            GameView(userName: playerName)
                        } label: {
                            StartGameButton()
                                .offset(y: 15)
                        }
                        .onSubmit { // Reset the player username and start game statusa
                            playerName = ""
                            canStartGame = false
                        }
                        
                        
                    }
                }
                .padding(.horizontal)
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                // Reset the value of the text field when the view is rendered
                newName = ""
                if playerName == "" {
                    canStartGame = false
                }
            }
        }
        
    }
}

struct UserInputView_Previews: PreviewProvider {
    static var previews: some View {
        UserInputView()
            .environmentObject(LeaderBoardViewModel())
    }
}


