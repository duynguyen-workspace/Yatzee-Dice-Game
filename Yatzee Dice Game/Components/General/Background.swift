/*
  Background.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created  date: 02/09/2023
  Last modified: 07/09/2023
*/

import SwiftUI

struct Background: View {
    // MARK: ***** PROPERTIES *****
    @EnvironmentObject var menuModel: MenuViewModel
    
    // MARK: ***** BODY VIEW *****
    var body: some View {
        // MARK: BACKGROUND IMAGE
        Image(menuModel.isDark ? "background" : "background")
            .resizable()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background()
            .environmentObject(MenuViewModel())
    }
}
