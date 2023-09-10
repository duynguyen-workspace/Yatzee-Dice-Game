/*
  RollView.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created date: 22/08/2023
  Last modified: 05/09/2023
  Acknowledgement:
  - Animation: Lecturer's Example, Week 07 Animation Documentation, RMIT Canvas
  - Observable Object, MVVM Model: Lecturer's Example, Week 10 Lecture Slides & Lab Tutorial
  - LazyVGrid Layout: Swift Playgrounds - Playground Name: Organizing with Grids
*/

import SwiftUI

struct RollView: View {
    // MARK: ***** PROPERTIES *****
    let columns: Int // Number of columns for the grid layout
    let diceFaces: [String]  // Array stores a list of dice faces
    let rerollCount: Int // Number of reroll by game mode
    
    @ObservedObject var rollModel : RollViewModel // roll view model
    @Binding var animatingIcon: Bool // animation boolean status
    
    // MARK: ***** BODY VIEW *****
    var body: some View {
        VStack {
            // MARK: NO. REROLL INFORMATION
            HStack {
                Image(systemName: "dice.fill")
                    .modifier(IconModifier())
                Text("\(rerollCount)")
                    .font(.custom("Play-Regular", size: 20))
                    .foregroundColor(.white)
                    .bold()
            }
            
            // MARK: REELS
            LazyVGrid(columns: Array(repeating: GridItem(), count: columns)) {
                // Iterate through the array
                ForEach(0..<5) { i in
                    // Generate a reel button
                    Button {
                        // toggle reel lock
                        rollModel.reels[i].isLocked.toggle()
                        // play lock sound
                        if rollModel.reels[i].isLocked {
                            playSound(sound: "lock", type: "mp3")
                        }
                    } label: {
                        // MARK: Reel Box
                        ZStack(alignment: .top) {
                            ReelBox(image: Image(diceFaces[rollModel.reels[i].value]), animatingIcon: animatingIcon, isLocked: rollModel.reels[i].isLocked)
                            // MARK: Lock Icon
                            if rollModel.reels[i].isLocked {
                                Image(systemName: "lock.fill")
                                    .font(.system(size: 20))
                                    .offset(y:-15)
                            }
                        }
                    }
                }
                
            }
            .padding(.horizontal)
            
        } // VStack
        .padding(.top, 5)
    }
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView(columns: 5, diceFaces:["dice-face-1","dice-face-2","dice-face-3","dice-face-4","dice-face-5","dice-face-6"], rerollCount: 5, rollModel: RollViewModel(), animatingIcon: .constant(true))
    }
}
