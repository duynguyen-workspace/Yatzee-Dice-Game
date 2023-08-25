//
//  PointsView.swift
//  Yatzee Dice Game
//
//  Created by Nguyễn Anh Duy on 22/08/2023.
//

import SwiftUI

struct PointsView: View {
    let points: Int
    let selected: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color(selected ? "secondary-color" : "secondary-color-transparent"))
                .frame(width: 60, height: 60)
            Text("\(points)")
                .font(.custom("Play-Regular", size: 25))
                .foregroundColor(.white)
                .bold()
                
        }
    }
}

struct PointsView_Previews: PreviewProvider {
    static var previews: some View {
        PointsView(points: 50, selected: true)
    }
}
