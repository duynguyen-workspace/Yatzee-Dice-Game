//
//  BannerView.swift
//  Yatzee Dice Game
//
//  Created by Nguyễn Anh Duy on 22/08/2023.
//

import SwiftUI

struct ScoreBanner: View {
    let userName: String
    let currentScore: Int
    let highScore: Int
    @EnvironmentObject var leaderboardModel : LeaderBoardViewModel
    var body: some View {
        HStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .modifier(BannerModifier(color: Color("secondary-color")))
                HStack {
                    Avatar(image: Image("game-avatar"))
                        .frame(height: 70)
                        .offset(x: -18)
                        
                    Spacer()
                    ScoreInfo(label: userName, score: currentScore)
                    Spacer()
                }
            }
            .frame(width: 170, height: 70)
            
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .modifier(BannerModifier(color: Color("secondary-color")))
                    
                HStack {
                    Spacer()
                    ScoreInfo(label: "High Score", score: highScore)
                    Avatar(image: leaderboardModel.players[0].image)
                        .frame(height: 70)
                        .offset(x: 18)
                }
            }
            .frame(width: 170, height: 70)
            
            Spacer()
        }
        .padding(.horizontal, 15)
        
    }
}

struct ScoreBanner_Previews: PreviewProvider {
    static var previews: some View {
        ScoreBanner(userName: "Duy", currentScore: 0, highScore: 1000)
            .environmentObject(LeaderBoardViewModel())
    }
}
