/*
  SettingView.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created  date: 04/09/2023
  Last modified: 07/09/2023
  Acknowledgement:
  - Environment Object, Observable Object, MVVM Model: Lecturer's Example, Week 10 Lecture Slides
  - Custom Navigation Back Button: https://www.youtube.com/watch?v=-XcNs22WnTc
*/

import SwiftUI

struct SettingView: View {
    // MARK: ***** PROPERTIES *****
    @EnvironmentObject var gameModel : GameViewModel // Store the game view model information
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode> // Store the presented value when the view is navigated
    
    var body: some View {
        ZStack {
            // MARK: ----- BACKGROUND -----
            Background()
            
            // MARK: ----- CONTENT -----
            VStack(spacing: 10) {
                Spacer()
                // MARK: HEADER TITLE
                VStack {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(Color("secondary-color"))
                        .font(.system(size: 40))
                    Text("SETTINGS")
                        .font(.custom("Play-Bold", size: 40))
                        .foregroundColor(Color("secondary-color"))
                        .padding(.bottom, 40)
                }
                
                // MARK: SETTING BUTTONS
                VStack(spacing: 30) {
                    // MARK: EASY MODE BUTTON
                    Button {
                        gameModel.isEasySelected = true
                        gameModel.isMediumSelected = false
                        gameModel.isHardSelected = false
                        gameModel.setEasyMode()
                    } label: {
                        SettingRow(gameButton: GameButton(text: "EASY", textColor: .white, buttonColor: .green), gameMode: GameMode(name: "easy", scoreToBeat: 200, rerollCount: 5, timer: 0), isSelected: gameModel.isEasySelected)
                    }
                    
                    // MARK: MEDIUM MODE BUTTON
                    Button {
                        gameModel.isEasySelected = false
                        gameModel.isMediumSelected = true
                        gameModel.isHardSelected = false
                        gameModel.setMediumMode()
                    } label: {
                        SettingRow(gameButton: GameButton(text: "MEDIUM", textColor: .white, buttonColor: .orange), gameMode: GameMode(name: "medium", scoreToBeat: 250, rerollCount: 4, timer: 200), isSelected: gameModel.isMediumSelected)
                        
                    }
                    
                    // MARK: HARD MODE BUTTON
                    Button {
                        gameModel.isEasySelected = false
                        gameModel.isMediumSelected = false
                        gameModel.isHardSelected = true
                        gameModel.setHardMode()
                    } label: {
                        SettingRow(gameButton: GameButton(text: "HARD", textColor: .white, buttonColor: Color("tertiary-color")), gameMode: GameMode(name: "hard", scoreToBeat: 300, rerollCount: 3, timer: 120), isSelected: gameModel.isHardSelected)
                        
                    }
                }
    
                // MARK: BACK TO HOME BUTTON
                Button {
                    // Remove the current view and return to the previous view
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    GameButton(text: "BACK", textColor: .white, buttonColor: Color("tertiary-color"))
                        .padding(.top, 40)
                }
                
                Spacer()
                
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if !gameModel.isEasySelected && !gameModel.isMediumSelected && !gameModel.isHardSelected {
                gameModel.setEasyMode()
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .environmentObject(GameViewModel())
    }
}
