/*
  LeaderBoardViewModel.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created date: 22/08/2023
  Last modified: 24/08/2023
*/

import SwiftUI

struct PointBox: View {
    // MARK: ***** PROPERTIES *****
    let points: Int
    var selected: Bool
    
    // MARK: ***** BODY VIEW *****
    var body: some View {
        ZStack {
            // MARK: BACKGROUND CONTAINER
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color(selected ? "secondary-color" : "secondary-color-transparent"))
                .frame(width: 60, height: 60)
            // MARK: POINT INFO
            Text("\(points)")
                .font(.custom("Play-Regular", size: 25))
                .foregroundColor(.white)
                .bold()
                
        }
    }
}

struct PointBox_Previews: PreviewProvider {
    static var previews: some View {
        PointBox(points: 50, selected: true)
    }
}
