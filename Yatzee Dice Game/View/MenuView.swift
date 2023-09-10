/*
  MenuView.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created  date: 21/08/2023
  Last modified: 08/09/2023
  Acknowledgement:
  - Observable Object, MVVM Model: Lecturer's Example, Week 10 Lecture Slides & Lab Tutorial
  - Custom Bottom Sheet & Toggle Button: https://www.youtube.com/watch?v=gw2k-sXTEyI
*/

import SwiftUI
import AVFoundation

struct MenuView: View {
    // MARK: ***** PROPERTIES *****
    @State var isInstructionSheetPresented = false // store the active status of displaying the instruction sheet
    @EnvironmentObject var menuModel : MenuViewModel
    
    // MARK: ***** BODY VIEW *****
    var body: some View {
        NavigationStack {
            ZStack {
                // MARK: ----- BACKGROUND -----
                Background()
                
                // MARK: ----- CONTENT -----
                VStack {
                    // MARK: HEADER
                    HStack {
                        Spacer()
                        Button {
                            menuModel.toggleTheme()
                        } label: {
                            MenuIcon(iconName: !menuModel.isDark ? "moon.fill" : "sun.max.fill")
                        }
                    }
                    .padding(.horizontal,30)
                    .padding(.top, 60)
                    
                    // MARK: LOGO
                    Logo(image: Image("logo-transparent"))
                        .frame(width: 280)
                    Button {
                        // Toggle the instruction sheet to be displayed
                        isInstructionSheetPresented.toggle()
                    } label: {
                        MenuIcon(iconName: "questionmark.circle.fill")
                            .offset(y: -10)
                    }
                    // MARK: INSTRUCTION SHEET
                    .sheet(isPresented: $isInstructionSheetPresented) {
                        InstructionView()
                            .presentationDetents([.medium, .large])
                            .presentationDragIndicator(.visible)
                    }
                    
                    Spacer()
                    
                    // MARK: GAME BUTTONS
                    VStack(spacing: 10) {
                        // MARK: START NEW GAME BUTTON
                        NavigationLink() {
                            UserInputView()
                        } label: {
                            GameButton(text: "New Game", textColor: .black, buttonColor: .blue)
                        }
                        
                        // MARK: CONTINUE GAME BUTTON
                        NavigationLink {
                            
                        } label: {
                            GameButton(text: "Continue", textColor: .black, buttonColor: Color("button-color"))
                                .opacity(0.6)
                        }
                        .disabled(true)
                        
                        // MARK: SETTING BUTTON
                        NavigationLink {
                            SettingView()
                        } label: {
                            GameButton(text: "Setting", textColor: .black, buttonColor: Color("icon-color"))
                        }
                    }
                    
                    Spacer()
                    
                    // MARK: LEADERBOARD BUTTON
                    NavigationLink {
                        LeaderBoardView()
                    } label: {
                        Image("leaderboard-icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
                    }
                    
                    Spacer()
                }
                
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitleDisplayMode(.inline)
            .environment(\.colorScheme, menuModel.isDark ? .dark : .light) // modify the color sheme based on the state variable
            .onAppear { // play background music when the view is rendered
                playBackgroundMusic(sound: "background-music", type: "mp3")
            }
            
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environmentObject(MenuViewModel())
    }
}
