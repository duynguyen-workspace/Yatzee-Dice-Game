/*
  LeaderBoardViewModel.swift
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

class LeaderBoardViewModel: ObservableObject {
    // MARK: PROPERTIES
    @Published var players : [Player] = [] // Array of Player structs
    @Published var showAlert = false // Boolean status of showing the alert
    @Published var alertMessage = "" // String message of the alert
    private let key = "leaderboardKey" // UserDefault key for leaderboard model
    
    // MARK: CONSTRUCTOR
    init() {
        if players.isEmpty { // Create random players if the player list is empty
            createRandomPlayers()
        }
        loadPlayers()
        
    }
    
    // MARK: METHODS
    /* Private function: load the players data from user default storage */
    private func loadPlayers() {
        if let savedData = UserDefaults.standard.data(forKey: key),
           let decodedData = try? JSONDecoder().decode([Player].self, from: savedData) {
            players = decodedData
        }
    }

    /* Private function: save the players data to user default storage*/
    private func savePlayers() {
        if let encodedData = try? JSONEncoder().encode(players) {
            UserDefaults.standard.set(encodedData, forKey: key)
        }
    }
    
    /* Function: generate default players data */
    func createRandomPlayers() {
        players = [Player(name: "Bot 1", score: 258, rank: 0, badges: ["badge-medium, badge-200"], imageName: "bot-avatar-1"), Player(name: "Bot 2", score: 302, rank: 0, badges: ["badge-hard, badge-300"], imageName: "bot-avatar-2"), Player(name: "Andy", score: 312, rank: 0, badges: ["badge-hard, badge-300, badge-5x"], imageName: "game-avatar"), Player(name: "Bot 3", score: 210, rank: 0, badges: ["badge-easy, badge-200"], imageName: "bot-avatar-3"), Player(name: "Jun", score: 228, rank: 0, badges: ["badge-easy, badge-200"], imageName: "game-avatar"), Player(name: "John", score: 258, rank: 0, badges: ["badge-easy, badge-200, badge-5x"], imageName: "game-avatar")]
        savePlayers()
    }
    
    /**
     Function: append player data to the list
     @param name: player name
     @param score: player score
     @param badges: player badges earned from playing the games
     */
    func addPlayer(name: String, score: Int, badges: [String]) {
        let player = Player(name: name, score: score, rank: 0, badges: badges, imageName: "game-avatar")
        players.append(player)
        savePlayers()
    }
    
    /**
     Function: append player data to the list
     @param player: struct of player data
     */
    func validatePlayer(player: Player) -> Bool {
        // Validate if player name is empty
        if player.name.isEmpty {
            showAlert = true
            alertMessage = "Player name cannot be empty!"
            return false
        }
        
        // Initialise a list of player names from the players list
        var playerNames : [String] = []
        for p in players {
            playerNames.append(p.name)
        }
        
        // Validate if player name is existed (not unique)
        if playerNames.contains(player.name) {
            showAlert = true
            alertMessage = "Player name is not unique! Please select another name."
            return false
        }
        return true
    }
    
    /* Function: sort the player list in descending order according to their current score */
    func sortPlayers() {
        players.sort {
            $0.score > $1.score
        }
        savePlayers()
    }
    
    /* Function: provide the player ranks according to their current positions in the list*/
    func givePlayerRank() {
        for i in players.indices {
            players[i].rank = i + 1
        }
        savePlayers()
    }
}
