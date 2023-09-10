/*
  InstructionView.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created  date: 21/08/2023
  Last modified: 07/09/2023
*/

import SwiftUI
import AVKit

struct InstructionView: View {
    var body: some View {
        ScrollView {
            ZStack {
                // MARK: ----- BODY CONTENT -----
                VStack(spacing: 5) {
                    // MARK: TITLE
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .edgesIgnoringSafeArea(.all)
                            .frame(height: 200)
                            .foregroundColor(Color("secondary-color"))
                        VStack {
                            Text("How To Play")
                                .font(.custom("Play-Bold", size: 40))
                                .foregroundColor(.white)
                        }
                    }
                    
                    Divider()
                    
                    // MARK: INSTRUCTION CONTAINER
                    VStack() {
                        Text("INSTRUCTIONS")
                            .font(.custom("Play-Bold", size: 20))
                        
                        HStack {
                            ForEach(0..<5, id: \.self) {i in
                                ReelBox(image: Image("dice-face-\(i+1)"), animatingIcon: true, isLocked: false)
                            }
                        }
                        
                        // MARK: GENERAL INFORMATION
                        VStack(alignment: .listRowSeparatorLeading,spacing: 10) {
                            Text("A traditional Yahtzee Game is a strategic dice game with a combination of normal rolling dices and card games. To play the game, the player will roll a total of 5 different fair dices and have a selection between 12 options (See below for more information). Each dice option will have a different approach to calculate the score based on the rolled dice.")
                            
                            Divider()
                            
                            // MARK: GAME TURN INFORMATION
                            Text("Each Turn")
                                .font(.custom("Play-Bold", size: 18))
                                .foregroundColor(Color("primary-color"))
                            
                            Text("Step 1: ")
                                .font(.custom("Play-Bold", size: 16)) +
                            Text("Roll the dice ")
                            
                            Text("Step 2: ")
                                .font(.custom("Play-Bold", size: 16)) +
                            Text("Decide to either keep a number of dice(s) or reroll some (or all) dices again (according to the limited reroll count per turn.)")
                            
                            Text("Step 3: ")
                                .font(.custom("Play-Bold", size: 16)) +
                            Text("Select a dice option to play and end the turn")
                            
                            Text("Step 4: ")
                                .font(.custom("Play-Bold", size: 16)) +
                            Text("Continue with the next turn")
                            
                            Text("The game ends after you have played all the dice options or the timer runs out (for medium and hard mode). You will win if you beat the target score. Good Luck!")
                            
                            Divider()
                            
                        }
                        .font(.custom("Play-Regular", size: 16))
                        .padding()
                        
                        // MARK: GAME BUTTON INFORMATION
                        VStack {
                            HStack {
                                ZStack {
                                    ReelBox(image: Image("dice-face-1"), animatingIcon: true, isLocked: true)
                                    Image(systemName: "lock.fill")
                                        .offset(y:-28)
                                }
                                Text("The reel is locked and cannot be roll")
                            }
                            
                            HStack {
                                ZStack {
                                    PointBox(points: 50, selected: false)
                                    Image(systemName: "checkmark.circle.fill")
                                        .offset(y: -28)
                                }
                                Text("This option is selected before and cannot be reselected")
                            }
                            .padding(.horizontal, 10)
                            
                            HStack {
                                Image("play-button")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                                Text("Play the turn")
                            }
                            
                            HStack {
                                Image("roll-button")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                                Text("Roll the dice")
                            }
                        }
                        Divider()
                        
                    }
                    
                    // MARK: DICE OPTION INFORMATION
                    VStack {
                        Text("DICE OPTIONS INFORMATION")
                            .font(.custom("Play-Bold", size: 20))
                        VStack (alignment: .listRowSeparatorLeading, spacing: 20) {
                            ForEach(dices, id: \.self) { dice in
                                InstructionRow(dice: dice)
                            }
                        }
                    }
                    
                    .padding([.top, .bottom], 20)
                    .padding(.horizontal, 15)
                    Divider()
                    
                    // MARK: BADGES INFORMATION
                    VStack {
                        Text("BADGES")
                            .font(.custom("Play-Bold", size: 20))
                        Text("Get a badge for each of your accomplishment!")
                            .padding(.bottom)
                        Text("Level Completion")
                            .font(.custom("Play-Regular", size: 20))
                        HStack {
                            Badge(image: Image("badge-easy"))
                                .frame(width: 80)
                            Badge(image: Image("badge-medium"))
                                .frame(width: 80)
                            Badge(image: Image("badge-hard"))
                                .frame(width: 80)
                        }
                        
                        Text("Score Achieved+")
                            .font(.custom("Play-Regular", size: 20))
                        HStack {
                            Badge(image: Image("badge-100"))
                                .frame(width: 80)
                            Badge(image: Image("badge-200"))
                                .frame(width: 80)
                            Badge(image: Image("badge-300"))
                                .frame(width: 80)
                        }
                        
                        Text("Get Five of A Kind")
                            .font(.custom("Play-Regular", size: 20))
                        Badge(image: Image("badge-5x"))
                            .frame(width: 80)
                        Divider()
                    }
                    
                    // MARK: GAMEPLAY VIDEO
                    VStack {
                        Text("GAMEPLAY")
                            .font(.custom("Play-Bold", size: 20))
                        VideoPlayer(player: AVPlayer(url:  URL(string: "https://youtu.be/avwDuB-P0UI")!))
                            .frame(width: 300, height: 300)
                    }
                    
                } // VStack
                
            }
        }
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct InstructionView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionView()
    }
}
