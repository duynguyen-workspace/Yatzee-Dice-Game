/*
  GameButton.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created  date: 05/09/2023
  Last modified: 06/09/2023
*/

import SwiftUI

struct GameButton: View {
    // MARK: ***** PROPERTIES *****
    let text: String // button text info
    let textColor: Color // button text foreground color
    let buttonColor: Color // button background color
    
    // MARK: ***** BODY VIEW *****
    var body: some View {
        Capsule()
            .frame(width: 180, height: 60)
            .foregroundColor(buttonColor)
            .overlay(
                Text(text)
                    .foregroundColor(textColor)
                    .font(.custom("Play-Bold", size: 25))
            )
    }
}

struct GameButton_Previews: PreviewProvider {
    static var previews: some View {
        GameButton(text: "Play", textColor: .black, buttonColor: Color("icon-color"))
    }
}
