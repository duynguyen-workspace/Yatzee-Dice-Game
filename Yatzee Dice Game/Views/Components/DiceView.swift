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
            .frame(width: 100)
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(image: Image("dice-face-1"))
    }
}
