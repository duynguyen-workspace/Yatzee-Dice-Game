/*
  RollViewModel.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created date: 05/09/2023
  Last modified: 07/09/2023
  Acknowledgement:
  - Observable Object, MVVM Model, UserDefault Storage: Lecturer's Example, Week 10 Lecture Slides & Lab Tutorial
*/

import Foundation

class RollViewModel: ObservableObject {
    // MARK: PROPERTIES
    @Published var reels : [Reel] = [] // Array store the list of Reel structs
    private let userDefaultsKey = "rollView" // UserDefault key to store the roll view model
    
    // MARK: CONSTRUCTOR
    init() {
        if reels.isEmpty { // Create empty reels when the model is initiated the first time
            resetReels()
        }
        loadReels() // Load the saved reels
        
    }
    
    // MARK: METHODS
    
    /* Private Function: Load the reel values from userdefault storage */
    private func loadReels() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedData = try? JSONDecoder().decode([Reel].self, from: savedData) {
            reels = decodedData
        }
    }
    
    /* Private Function: Save the reel values to userdefault storage */
    private func saveReels() {
        if let encodedData = try? JSONEncoder().encode(reels) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsKey)
        }
    }
    
    /* Function: Reset all the reels value to 0 */
    func resetReels() {
        reels.removeAll()
        let emptyReel = Reel(value: 0, isLocked: false)
        for _ in 0...4 { // 5 reels value -> 0
            reels.append(emptyReel)
        }
        saveReels()
    }
    
    /* Function: generate reel values */
    func roll() {
        for i in 0...4 {
            // Generate random dice values if the reel is not locked
            if !reels[i].isLocked {
                reels[i].value = Int.random(in: 1...6)
            }
        }
        saveReels()
    }
    
    /*
     Function: toggle the lock status of the reel value
     @param index: Location of the reel
     */
    func toggleReelLock(at index: Int) {
        reels[index].isLocked.toggle()
        saveReels()
    }
    
    
}
