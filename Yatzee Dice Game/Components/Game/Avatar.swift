/*
  Avatar.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created  date: 22/08/2023
  Last modified: 22/08/2023
*/

import SwiftUI

struct Avatar: View {
    let image: Image
    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color("gradient-color-purple"), lineWidth: 5)
            )
    }
}

struct Avatar_Previews: PreviewProvider {
    static var previews: some View {
        Avatar(image: Image("avatar"))
    }
}
