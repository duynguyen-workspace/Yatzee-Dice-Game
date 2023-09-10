/*
  DiceViewModel.swift
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

class DiceOptionViewModel : ObservableObject {
    // MARK: PROPERTIES
    @Published var diceOptions : [DiceOption] = [] // Array store the list of DiceOption structs
    private let diceNames = ["ones", "twos", "threes","fours","fives","sixs","3x","twoPairs","fullHouse","small","large","5x","all"] // Array store the list of dice option names
    private let userDefaultsKey = "optionView" // UserDefault key for storing the dice option view model data
    
    // MARK: CONSTRUCTOR
    init() {
        if diceOptions.isEmpty { // Generate all empty dice options when firstly initiated
            resetOptions()
        }
        loadOptions() // Load the saved dice options
    }
    
    // MARK: METHODS
    /* Private function: load the saved values of dice options */
    private func loadOptions() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedData = try? JSONDecoder().decode([DiceOption].self, from: savedData) {
            diceOptions = decodedData
        }
    }
    /* Private function: save the values for dice options to user default storage */
    private func saveOptions() {
        if let encodedData = try? JSONEncoder().encode(diceOptions) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsKey)
        }
    }
    
    /* Function: reset current value, saved value, and isPlayed status of the dice option*/
    func resetOptions() {
        // Remove all previous structs and values
        diceOptions.removeAll()
        // Iteration over the list of dice names
        for i in 0...diceNames.count-1 {
            // Create empty option with the dice option name and append to the options list
            let emptyOption = DiceOption(name: diceNames[i], currentValue: 0, savedValue: 0, isPlayed: false)
            diceOptions.append(emptyOption)
        }
    }
    
    /* Function: reset the current values of all dice options */
    func resetOptionCurrentValues() {
        // Iteration over the list of dice options
        for i in 0...diceOptions.count-1 {
            diceOptions[i].currentValue = 0
        }
    }
    
    /* Function: toggle the isPlayed status of the playing dice option */
    func toggleOptionIsPlayed(at index: Int) {
        diceOptions[index].isPlayed.toggle()
    }
    
    /* Function: set the status for isPlayed property of the playing dice option */
    func setOptionIsPlayed(at index: Int, status: Bool) {
        diceOptions[index].isPlayed = status
    }
    
    /* Function: set the current value property of the playing dice option */
    func setOptionCurrentValue(at index: Int, value: Int) {
        diceOptions[index].currentValue = value
    }
    
    /* Function: set the saved value property of the playing dice option */
    func setOptionSavedValue(at index: Int, value: Int) {
        diceOptions[index].savedValue = value
    }
}
