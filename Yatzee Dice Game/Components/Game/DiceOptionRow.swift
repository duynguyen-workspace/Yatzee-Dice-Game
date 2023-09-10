/*
  DiceOptionRow.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created date: 04/09/2023
  Last modified: 07/09/2023
  Acknowledgement:
  - Observable Object, MVVM Model: Lecturer's Example, Week 10 Lecture Slides & Lab Tutorial
*/

import SwiftUI

struct DiceOptionRow: View {
    // MARK: ***** PROPERTIES *****
    let id: Int // position of the dice option in the model's data
    let diceImage: Image // image of the dice face
    let points: Int
    
    @ObservedObject var diceOptionModel : DiceOptionViewModel // dice option view model data
    @Binding var selected: [String: Bool] // array store a list of dice option selected status from the dice option view model data
    @Binding var hasPlayed: [String: Bool] // array store a list of dice option isPlayed status from the dice option view model data
    @Binding var isOtherOptionSelected : Bool // boolean status to check if any other option is selected
    @Binding var canPlay: Bool // boolean status to toggle the play button in game view
    
    // MARK: ***** BODY VIEW *****
    var body: some View {
        // Check the conditions for the disabled status:
        let disabledStatus = !(selected[diceOptionModel.diceOptions[id].name]!) && isOtherOptionSelected
        ZStack {
            // MARK: DICE BOX
            HStack {
                DiceBox(image: diceImage)
                Button {
                    // Toggle the select status of the dice button
                    selected[diceOptionModel.diceOptions[id].name]!.toggle()
                    // Play the sound when the dice option is selected
                    if (selected[diceOptionModel.diceOptions[id].name]! == true) {
                        playSound(sound: "select", type: "mp3")
                    }
                    
                    // Update the value for other state variable
                    isOtherOptionSelected.toggle()
                    canPlay.toggle()
                } label: {
                    PointBox(points: points, selected: selected[diceOptionModel.diceOptions[id].name]!)
                }
                .disabled(hasPlayed[diceOptionModel.diceOptions[id].name]! ? true : disabledStatus)
                // -> The option cannot be selected if there is any other option selected OR the option has been already played.
            }
            // Display the checker if the option has been played
            Image(systemName: "checkmark.circle.fill")
                .offset(x: 28, y: -28)
                .opacity(hasPlayed[diceOptionModel.diceOptions[id].name]! ? 1 : 0)
            
        }
        
    }
}

struct DiceOptionRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DiceOptionRow(id: 0, diceImage: Image("dice-face-1"), points: 50, diceOptionModel: DiceOptionViewModel(), selected: .constant(["ones": false]), hasPlayed: .constant(["ones": false]), isOtherOptionSelected: .constant(false), canPlay: .constant(true))
        }
        
    }
}

