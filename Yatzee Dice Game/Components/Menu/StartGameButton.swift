/*
  StartGameButton.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created  date: 05/09/2023
  Last modified: 05/09/2023
*/

import SwiftUI

struct StartGameButton: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 120)
                .overlay(
                    Image(systemName: "triangle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60)
                        .offset(y: -5)
                        .rotationEffect(Angle(degrees: 90))
                        .foregroundColor(Color("icon-color"))
                )
        }
    }
}

struct StartGameButton_Previews: PreviewProvider {
    static var previews: some View {
        StartGameButton()
    }
}
