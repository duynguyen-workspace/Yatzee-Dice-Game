/*
  DiceOption.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created  date: 01/09/2023
  Last modified: 02/09/2023
  Acknowledgement:
  - Codable Objects: Lecturer's Example - Week 5 Lecture Slides and Lab Tutorial
*/

import Foundation

struct DiceOption: Identifiable, Codable {
    // MARK: PROPERTIES
    var id: UUID = UUID()
    var name: String
    var currentValue: Int
    var savedValue: Int
    var isPlayed: Bool
    // var isSelected: Bool
    
}
