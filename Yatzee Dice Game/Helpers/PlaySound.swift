/*
  PlaySound.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created  date: 22/08/2023
  Last modified: 05/09/2023
  Acknowledgement:
  - Play sound from imported files: Lecturer's Example - RMIT Casino App, Week 8 Lecture's Slides and Lab Tutorial
  - Play, stop sounds, and add background music: from "Learn how to add sound effects and a background music to the SwiftUI game in Xcode", Youtube, accessed via <URL: https://www.youtube.com/watch?v=6l5nJgrXTfc> 
*/

import UIKit
import AVFoundation

var audioPlayer: AVAudioPlayer?

/* Function: play music*/
func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("ERROR: Could not find and play the sound file!")
        }
    }
}

/* Function: stop music from playing */
func stopSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.stop()
        } catch {
            print("ERROR: Could not find and play the sound file!")
        }
    }
}

/* Function: play background music */
func playBackgroundMusic(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            if let canPlayAudio = audioPlayer {
                if !canPlayAudio.isPlaying {
                    canPlayAudio.play()
                }
            }
        } catch {
            print("ERROR: Could not find and play the sound file!")
        }
    }
}


