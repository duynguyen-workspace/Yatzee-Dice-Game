/*
  Logo.swift
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

struct Logo: View {
    let image: Image
    var body: some View {
        image
            .resizable()
            .scaledToFit()
    }
}

struct Logo_Previews: PreviewProvider {
    static var previews: some View {
        Logo(image: Image("logo-transparent"))
    }
}
