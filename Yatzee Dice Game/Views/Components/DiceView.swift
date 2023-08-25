//
//  DiceView.swift
//  Yatzee Dice Game
//
//  Created by Nguyễn Anh Duy on 21/08/2023.
//

import SwiftUI

struct DiceView: View {
    let image: Image
    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("secondary-color"),lineWidth: 3)
            )
            .frame(height: 50)
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(image: Image("dice-face-1"))
    }
}
