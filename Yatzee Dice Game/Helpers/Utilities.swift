/*
  Utilities.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created date: 23/08/2023
  Last modified: 07/09/2023
*/

import Foundation

/**
  Check if the array elements is in a sequence
 */
func isSequence(arr: [Int]) -> Bool {
    // Checking the adjacent elements
    for i in 1...arr.count - 1 {
        if (arr[i] != arr[i-1]+1) {
            return false
        }
    }
    
    return true
}

/**
 Calculate the score for dices with the same value (any dice in the reel)
 */
func calcSameDices(reels: [Reel], value: Int) -> Int {
    var result = 0
    for reel in reels {
        if reel.value == value {
            result += value
        }
    }
    return result
}


