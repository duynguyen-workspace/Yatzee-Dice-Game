/*
  Dice.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created  date: 30/08/2023
  Last modified: 02/09/2023
  Acknowledgement:
  - Codable Objects: Lecturer's Example - Week 5 Lecture Slides and Lab Tutorial
*/

import Foundation
import SwiftUI

struct Dice: Identifiable, Codable, Hashable {
    // Attributes
    var id: Int
    var name: String
    var diceDescription: String
    var scoreDescription: String
    var imageName: String
    var image: Image {
        Image(imageName)
    }
}
