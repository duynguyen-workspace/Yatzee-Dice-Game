/*
  PlayerRow.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created  date: 05/09/2023
  Last modified: 05/09/2023
*/

import SwiftUI

struct PlayerRow: View {
    // MARK: ***** PROPERTIES *****
    @Binding var player: Player // Player information
    
    // MARK: ***** BODY VIEW *****
    var body: some View {
        // MARK: PLAYER ROW INFORMATION
        HStack {
            // MARK: RANKING BADGE
            if player.rank == 1 {
                Badge(image: Image("rank-1"))
                    .frame(width: 30)
            } else if player.rank == 2 {
                Badge(image: Image("rank-2"))
                    .frame(width: 30)
            } else if player.rank == 3 {
                    Badge(image: Image("rank-3"))
                        .frame(width: 30)
            } else {
                Badge(image: Image("rank"))
                    .frame(width: 30)
            }
            // MARK: PLAYER AVATAR
            HStack(spacing: 5) {
                Badge(image: player.image)
                    .frame(width: 50)
                Text(player.name)
                    .font(.custom("Play-Regular", size: 20))
            }
            
            Spacer()
            
            // MARK: LIST OF ACHIEVED GAME BADGES
            HStack {
                ForEach(player.badges, id: \.self) { badge in
                    Badge(image: Image(badge))
                        .frame(width: 35)
                }
            }
            
            Spacer()
            
            // MARK: SAVED SCORE
            HStack {
                Image(systemName: "flag.checkered")
                Text("\(player.score)")
                    .font(.custom("Play-Bold", size: 25))
            }
            
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("secondary-color"), lineWidth: 5)
        )
        .background(.white)
    }
}

struct PlayerRow_Previews: PreviewProvider {
    @State static var samplePlayer = Player(name: "Duy", score: 50, rank: 0, badges: ["badge-easy","badge-100","badge-5x"], imageName: "game-avatar")
    
    static var previews: some View {
        PlayerRow(player: $samplePlayer)
    }
}
