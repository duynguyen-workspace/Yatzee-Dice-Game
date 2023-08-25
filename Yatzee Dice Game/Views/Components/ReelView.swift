//
//  ReelView.swift
//  Yatzee Dice Game
//
//  Created by Nguyễn Anh Duy on 22/08/2023.
//

import SwiftUI

struct ReelView: View {
    let image: Image
    let animatingIcon: Bool
    let isLocked: Bool
    
    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(!isLocked ? Color("black-transparent") : .blue,lineWidth: 3)
            )
            .frame(height: 50)
            .opacity(!isLocked ? (animatingIcon ? 1 : 0) : 1)
            .offset(y: !isLocked ? (animatingIcon ? 0 : -50) : 0)
            .rotation3DEffect(.degrees(!isLocked ? (animatingIcon ? 1 : 360) : 0), axis: (x: 1, y: 0, z: 0))
            .animation(.easeOut, value: animatingIcon)
    }
}

struct ReelView_Previews: PreviewProvider {
    static var previews: some View {
        ReelView(image: Image("dice-face-1"), animatingIcon: true, isLocked: true)
    }
}
