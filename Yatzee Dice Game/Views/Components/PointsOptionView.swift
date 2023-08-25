//
//  PointsOptionView.swift
//  Yatzee Dice Game
//
//  Created by Nguyễn Anh Duy on 22/08/2023.
//

import SwiftUI

struct PointsOptionView: View {
    let id: String
    let diceImage: Image
    let points: Int
    @Binding var selected: [String: Bool]
    @Binding var isOtherOptionSelected: Bool
    @Binding var canPlay: Bool
    @Binding var hasPlayed: [String: Bool]
    
    var body: some View {
        let disabledStatus = !(selected[id]!) && isOtherOptionSelected
        ZStack {
            HStack {
                DiceView(image: diceImage)
                Button {
                    selected[id]!.toggle()
                    if (selected[id]! == true) {
                        playSound(sound: "select", type: "mp3")
                    }
                    isOtherOptionSelected.toggle()
                    canPlay.toggle()
                } label: {
                    PointsView(points: points, selected: selected[id]!)
                }
                .disabled(hasPlayed[id] == false ? disabledStatus : true)
            }
            
            Image(systemName: "checkmark.circle.fill")
                .offset(x: 28, y: -28)
                .opacity(hasPlayed[id] == true ? 1 : 0)
            
        }
        
    }
}

struct PointsOptionView_Previews: PreviewProvider {
    static var previews: some View {
        PointsOptionView(id: "ones", diceImage: Image("dice-face-1"), points: 50, selected: .constant(["ones": false]), isOtherOptionSelected: .constant(false), canPlay: .constant(true), hasPlayed: .constant(["ones": true]))
    }
}
