/*
  AnimatingView.swift
  Yatzee Dice Game
 
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Nguyen Anh Duy
  ID: 3878141
  Created  date: 25/08/2023
  Last modified: 26/08/2023
  Acknowledgement:
  - Custom Splash Screen: https://www.youtube.com/watch?v=0ytO3wCRKZU&ab_channel=Indently
  - Running code after a delay using asyncAfter: https://www.hackingwithswift.com/example-code/system/how-to-run-code-after-a-delay-using-asyncafter-and-perform
*/

import SwiftUI

struct AnimatingView: View {
    // State variables to define the initial value of logo size, position, angles, and opacity for later animation modified
    @State private var isSplashActive = false
    @State private var size = 0.8
    @State private var opacity = 0.2
    @State private var yOffset: CGFloat = 20
    
    var body: some View {
        // Check if the splash screen is available or disabled (only appeared once for each time the app start/restart)
        if (isSplashActive) {
            ContentView()
        } else {
            ZStack {
                Color(.white)
                    .edgesIgnoringSafeArea(.all)
                Image("logo-mini")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                // Set Animation Effects for logo
                    .scaleEffect(size)
                    .opacity(opacity)
                    .offset(y: yOffset)
                    .onAppear{
                        // Perform the series of animated action by adjusting the self-defined variables
                        withAnimation(.easeIn(duration: 1.0)) {
                            self.size = 1.2
                            self.opacity = 1.0
                            self.yOffset = 0
                        }
                    }
            }
            .onAppear {
                // Asynchronously display the splash screen when launching the app
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isSplashActive = true
                    }
                }
            }
        }
    }
}

struct AnimatingView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatingView()
    }
}
