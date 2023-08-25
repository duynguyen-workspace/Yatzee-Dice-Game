//
//  BannerView.swift
//  Yatzee Dice Game
//
//  Created by Nguyễn Anh Duy on 22/08/2023.
//

import SwiftUI

struct ScoreBannerView: View {
    let currentScore: Int
    let highScore: Int
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .modifier(BannerModifier(color: Color("secondary-color")))
                HStack {
                    AvatarView(image: Image("bot-avatar-1"))
                        .frame(height: 70)
                        .offset(x: -10)
                    ScoreInfoView(label: "Your Score", score: currentScore)
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
                    ScoreInfoView(label: "High Score", score: highScore)
                    AvatarView(image: Image("bot-avatar-2"))
                        .frame(height: 70)
                        .offset(x: 10)
                }
            }
            .frame(width: 170, height: 70)
        }
        .padding(.horizontal, 15)
        
    }
}

struct ScoreBannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreBannerView(currentScore: 0, highScore: 1000)
    }
}
