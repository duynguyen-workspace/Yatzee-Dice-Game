/*
  ModelData.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created  date: 30/08/2023
  Last modified: 01/09/2023
  Acknowledgement:
  - Parsing data from JSON file: Lecturer's Example - Week 5 Lecture Slides & Lab Tutorial
*/

import Foundation

// List of dice structs after parsing from JSON file
var dices: [Dice] = decodeJsonFromJsonFile(jsonFileName: "dices.json")

/***
  @param T: an object (class or struct) that conforms to Codable  protocol
  @return: an array of T objects
 */
func decodeJsonFromJsonFile<T: Codable>(jsonFileName: String) -> [T] {
    // Check if the file is existed in the directory
    if let file = Bundle.main.url(forResource: jsonFileName, withExtension: nil){
        // Check if the file can be decodable
        if let data = try? Data(contentsOf: file) {
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([T].self, from: data)
                return decoded
            } catch let error { // Display error message if JSON data is corrupted
                fatalError("Failed to decode JSON: \(error)")
            }
        }
    } else { // Display error message if file cannot found
        fatalError("Couldn't load \(jsonFileName) file")
    }
    return [] as [T]
}

