/*
  MenuViewModel.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created date: 05/09/2023
  Last modified: 05/09/2023
  Acknowledgement:
  - Observable Object, MVVM Model: Lecturer's Example, Week 10 Lecture Slides & Lab Tutorial
*/

import Foundation

class MenuViewModel: ObservableObject {
    @Published var isDark: Bool = false
    
    func toggleTheme() {
        isDark.toggle()
    }
}
