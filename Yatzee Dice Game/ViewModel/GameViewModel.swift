/*
  GameViewModel.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created date: 05/09/2023
  Last modified: 08/09/2023
  Acknowledgement:
  - Observable Object, MVVM Model: Lecturer's Example, Week 10 Lecture Slides & Lab Tutorial
*/

import Foundation

class GameViewModel: ObservableObject {
    // MARK: PROPERTIES
    // GAME PROPERTIES
    @Published var rerollCount: Int = 0
    @Published var scoreToBeat: Int = 0
    @Published var timer: Int = 0
    
    // SETTING PROPERTIES (boolean status for checking the game mode setting option)
    @Published var isEasySelected: Bool = false
    @Published var isMediumSelected: Bool = false
    @Published var isHardSelected: Bool = false
    
    // GAMEMODE PRIVATE PROPERTIES (store the gamemode information)
    private let easyMode = GameMode(name: "easy", scoreToBeat: 200, rerollCount: 5, timer: 0)
    private let mediumMode = GameMode(name: "medium", scoreToBeat: 250, rerollCount: 4, timer: 200)
    private let hardMode = GameMode(name: "hard", scoreToBeat: 300, rerollCount: 3, timer: 120)
    
    // MARK: METHODS
    /**
     Function: set the game playing values
     @param rerollCount: number of reroll times per turn
     @param scoreToBeat: target score to achieve in order to win the game
     @param timer: countdown timer for medium and hard gamemode
     */
    func setGame(rerollCount: Int, scoreToBeat: Int, timer: Int) {
        self.rerollCount = rerollCount
        self.scoreToBeat = scoreToBeat
        self.timer = timer
    }
    
    /* Function: Reset number of rerolls in the game view according to the selected game mode*/
    func resetRollCount() {
        if isEasySelected {
            rerollCount = easyMode.rerollCount
        }
        if isMediumSelected {
            rerollCount = mediumMode.rerollCount
        }
        if isHardSelected {
            rerollCount = hardMode.rerollCount
        }
    }
    
    /* Function: Set easy game mode for the game view*/
    func setEasyMode() {
        isEasySelected = true
        isMediumSelected = false
        isHardSelected = false
        setGame(rerollCount: easyMode.rerollCount, scoreToBeat: easyMode.scoreToBeat, timer: easyMode.timer)
    }
    
    /* Function: Set medium game mode for the game view*/
    func setMediumMode() {
        isEasySelected = false
        isMediumSelected = true
        isHardSelected = false
        setGame(rerollCount: mediumMode.rerollCount, scoreToBeat: mediumMode.scoreToBeat, timer: mediumMode.timer)
    }
    
    /* Function: set hard game mode for the game view*/
    func setHardMode() {
        isEasySelected = false
        isMediumSelected = false
        isHardSelected = true
        setGame(rerollCount: hardMode.rerollCount, scoreToBeat: hardMode.scoreToBeat, timer: hardMode.timer)
    }
    
    
}
