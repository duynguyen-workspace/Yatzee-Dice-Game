/*
  InstructionRow.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created  date: 30/08/2023
  Last modified: 01/09/2023
*/

import SwiftUI

struct InstructionRow: View {
    // MARK: ***** PROPERTIES *****
    let dice: Dice // Dice Information
    
    // MARK: ***** BODY VIEW *****
    var body: some View {
        HStack {
            // MARK: DICE OPTION FACES
            DiceBox(image: dice.image)
                .padding(.trailing, 10)
            
            // MARK: DICE OPTION INFORMATION
            VStack(alignment: .listRowSeparatorLeading) {
                // MARK: DICE NAME & DESCRIPTION
                HStack(spacing: 0) {
                    Text("\(dice.name): ")
                        .bold()
                        .font(.custom("Play-Bold", size: 18)) + // Text Views Concatentation
                    Text("\(dice.diceDescription)")
                }
                
                // MARK: DICE OPTION CALCULATED SCORE
                HStack(spacing: 0) {
                    Text("Score: ")
                        .bold()
                        .font(.custom("Play-Bold", size: 18)) + // Text Views Concatentation
                    Text("\(dice.scoreDescription)")
                        .font(.custom("Play-Regular", size: 18))
                }
            }
            
        }
    }
}

struct InstructionRow_Previews: PreviewProvider {
    static var previews: some View {
        InstructionRow(dice: dices[0])
    }
}
