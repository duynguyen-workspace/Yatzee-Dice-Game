/*
  Modifiers.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created date: 22/08/2023
  Last modified: 07/09/2023
*/

import SwiftUI

struct ShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color("black-transparent"),radius: 7)
    }
}

struct BannerModifier: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .foregroundColor(color)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color("gradient-color-purple"), lineWidth: 2)
            )
    }
}

struct IconModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color("icon-color"))
            .font(.system(size: 18))
    }
}

struct AnimationModifier: ViewModifier {
    let animatingIcon: Bool
    func body(content: Content) -> some View {
        content
            .opacity(animatingIcon ? 1 : 0)
            .offset(y: animatingIcon ? 0 : -50)
            .rotation3DEffect(.degrees(animatingIcon ? 1 : 360), axis: (x: 1, y: 0, z: 0))
            .animation(.easeOut, value: animatingIcon)
    }
}

struct EmptyModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .opacity(1)
            .offset(y: 0)
    }
}


    

    
