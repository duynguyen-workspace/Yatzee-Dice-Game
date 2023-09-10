/*
  Player.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created  date: 06/09/2023
  Last modified: 06/09/2023
  Acknowledgement:
  - Codable Objects: Lecturer's Example - Week 5 Lecture Slides and Lab Tutorial
*/

import Foundation
import SwiftUI

struct Player: Codable {
    var id: UUID = UUID()
    var name: String
    var score: Int
    var rank: Int
    var badges: [String]
    var imageName: String
    var image: Image {
        Image(imageName)
    }
}
