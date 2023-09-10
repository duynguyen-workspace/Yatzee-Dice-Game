/*
  ReelBox.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created date: 22/08/2023
  Last modified: 22/08/2023
  Acknowledgement:
  - Observable Object, MVVM Model, UserDefault Storage: Lecturer's Example, Week 10 Lecture Slides & Lab Tutorial
*/

import SwiftUI

struct ReelBox: View {
    // MARK: ***** PROPERTIES *****
    let image: Image
    let animatingIcon: Bool
    let isLocked: Bool
    
    // MARK: ***** BODY VIEW *****
    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(!isLocked ? Color("black-transparent") : .blue,lineWidth: 3)
            )
            .frame(height: 50)
            // Animation Modifier
            .opacity(!isLocked ? (animatingIcon ? 1 : 0) : 1)
            .offset(y: !isLocked ? (animatingIcon ? 0 : -50) : 0)
            .rotation3DEffect(.degrees(!isLocked ? (animatingIcon ? 1 : 360) : 0), axis: (x: 1, y: 0, z: 0))
            .animation(.easeOut, value: animatingIcon)
    }
}

struct ReelView_Previews: PreviewProvider {
    static var previews: some View {
        ReelBox(image: Image("dice-face-1"), animatingIcon: true, isLocked: true)
    }
}
