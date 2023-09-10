/*
  SettingRow.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created  date: 05/09/2023
  Last modified: 07/09/2023
*/

import SwiftUI

struct SettingRow: View {
    // MARK: ***** PROPERTIES *****
    let gameButton: GameButton
    let gameMode: GameMode
    let isSelected: Bool
    
    // MARK: ***** BODY VIEW *****
    var body: some View {
        HStack {
            // MARK: GAMEMODE LABEL
            gameButton
            
            // MARK: GAMEMODE DESCRIPTION
            VStack(alignment: .leading) {
                // MARK: TIMER DESCRIPTION
                if gameMode.timer == 0 {
                    Text("No Time Limit")
                } else {
                    Text("Time Limit: \(gameMode.timer)s")
                }
                
                // MARK: SCORE TO BEAT AND REROLL COUNT DESCRIPTION
                Text("Score To Beat: \(gameMode.scoreToBeat)")
                Text("Reroll per Turn: \(gameMode.rerollCount)")
            }
            .font(.custom("Play-Regular", size: 18))
            .foregroundColor(.white)
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(gameButton.buttonColor, lineWidth: 5)
        )
        .opacity(isSelected ? 1 : 0.5)
    }
}

struct SettingRow_Previews: PreviewProvider {
    static var previews: some View {
        SettingRow(gameButton: GameButton(text: "EASY", textColor: .white, buttonColor: .green), gameMode: GameMode(name: "easy", scoreToBeat: 200, rerollCount: 7, timer: 0), isSelected: false)
    }
}
