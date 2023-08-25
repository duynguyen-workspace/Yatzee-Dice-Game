//
//  Utilities.swift
//  Yatzee Dice Game
//
//  Created by Nguyễn Anh Duy on 23/08/2023.
//

import Foundation

func checkConsecutiveNumbers(arr: [Int]) -> Bool {
    // Sort the array
    var sortedArr = arr.map{$0}
    sortedArr.sort()
    
    // Checking the adjacent elements
    for i in 1...sortedArr.count - 1 {
        if (sortedArr[i] != sortedArr[i-1]+1) {
            return false
        }
    }
    
    return true
}

func checkConsecutiveNumbers(arr: [Int], n: Int) -> Bool {
    //
    let missedNumberAllowed = arr.count - n
    var errorCount = 0
    
    // Sort the array
    var sortedArr = arr.map{$0}
    sortedArr.sort()
    
    // Checking the adjacent elements
    for i in 1...sortedArr.count - 1 {
        if (sortedArr[i] != sortedArr[i-1]+1) {
            errorCount += 1
        }
    }
    
    if errorCount > missedNumberAllowed {
        return false
    }
    return true
}
