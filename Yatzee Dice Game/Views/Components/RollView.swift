//
//  RollVie.swift
//  Yatzee Dice Game
//
//  Created by Nguyễn Anh Duy on 22/08/2023.
//

import SwiftUI

struct RollView: View {
    // MARK: PROPERTIES
    let columns: Int // Number of columns for the grid layout
    let dices: [String]  // Array stores a list of dice faces
    let rerollCount: Int
    @Binding var reels: [Int] // Array stores a list of playing reels
    @Binding var locks: [Bool]  // Array stores the lock status of each dice reel
    @Binding var animatingIcon: Bool
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "dice.fill")
                    .modifier(IconModifier())
                Text("\(rerollCount)")
                    .font(.custom("Play-Regular", size: 20))
                    .foregroundColor(.white)
                    .bold()
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: columns)) {
                // Iterate through the array
                ForEach(0..<5) { i in
                    Button {
                        print("Dice \(dices[i])")
                        locks[i].toggle()
                        if locks[i] == true {
                            playSound(sound: "lock", type: "mp3")
                        }
                    } label: {
                        ZStack(alignment: .top) {
                            ReelView(image: Image(dices[reels[i]]), animatingIcon: animatingIcon, isLocked: locks[i])
                            if locks[i] {
                                Image(systemName: "lock.fill")
                                    .font(.system(size: 20))
                                    .offset(y:-15)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            
        } // VStack
        .padding(.top, 5)
    }
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView(columns: 5, dices:["dice-face-1","dice-face-2","dice-face-3","dice-face-4","dice-face-5","dice-face-6"], rerollCount: 5, reels: .constant([0,1,2,3,4]), locks: .constant([false,false,false,false,false]), animatingIcon: .constant(true))
    }
}
