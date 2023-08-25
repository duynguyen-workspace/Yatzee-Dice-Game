//
//  ScoreView.swift
//  Yatzee Dice Game
//
//  Created by Nguyễn Anh Duy on 22/08/2023.
//

import SwiftUI

struct ScoreInfoView: View {
    let label: String
    let score: Int
    
    var body: some View {
        VStack {
            Text("\(score)")
                .font(.custom("Play-Bold", size: 25))
            Text(label)
                .font(.custom("Play-Regular", size: 15))
        }
    }
}

struct ScoreInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreInfoView(label: "High Score", score: 1000)
    }
}
