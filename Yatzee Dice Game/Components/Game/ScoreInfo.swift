/*
  ScoreInfo.swift
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

struct ScoreInfo: View {
    // MARK: ***** PROPERTIES *****
    let label: String
    let score: Int
    
    // MARK: ***** BODY VIEW *****
    var body: some View {
        VStack(alignment: .center) {
            Text("\(score)")
                .font(.custom("Play-Bold", size: 25))
            Text(label)
                .font(.custom("Play-Regular", size: 15))
        }
    }
}

struct ScoreInfo_Previews: PreviewProvider {
    static var previews: some View {
        ScoreInfo(label: "High Score", score: 1000)
    }
}
