/*
  DiceBox.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created date: 22/08/2023
  Last modified: 22/08/2023
*/

import SwiftUI

struct DiceBox: View {
    // MARK: ***** PROPERTIES *****
    let image: Image
    
    // MARK: ***** BODY VIEW *****
    var body: some View {
        // MARK: DICE BOX
        image
            .resizable()
            .scaledToFit()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("secondary-color"),lineWidth: 3)
            )
            .frame(height: 50)
    }
}

struct DiceBox_Previews: PreviewProvider {
    static var previews: some View {
        DiceBox(image: Image("dice-face-1"))
    }
}
