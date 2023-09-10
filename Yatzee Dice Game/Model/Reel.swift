/*
  Reel.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created  date: 01/09/2023
  Last modified: 01/09/2023
  Acknowledgement:
  - Codable Objects: Lecturer's Example - Week 5 Lecture Slides and Lab Tutorial
*/

import Foundation

struct Reel: Identifiable, Codable {
    // MARK: ATTRIBUTES
    var id : UUID = UUID()
    var value: Int
    var isLocked: Bool
}
