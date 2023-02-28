//
//  CircleGroupView.swift
//  Restart
//
//  Created by nasser on 28/2/2023.
//

import SwiftUI

struct CircleGroupView: View {
    
    // MARK: PROPERTY
    
    @State var shapOpacity: Double
    @State var shapeColor: Color
    @State private var isAnimating: Bool = false
    
    // MARK: BODY
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(shapeColor.opacity(shapOpacity), lineWidth: 40)
                .frame(width: 260, height: 260, alignment: .center)
            Circle()
                .stroke(shapeColor.opacity(shapOpacity), lineWidth: 80)
                .frame(width: 260, height: 260, alignment: .center)
        }
        .blur(radius: isAnimating ? 0 : 10)
        .opacity(isAnimating ? 1 : 0)
        .scaleEffect(isAnimating ? 1 : 0.5)
        .animation(.easeOut(duration: 1), value: isAnimating)
        .onAppear(perform: {
            isAnimating = true
        })
    }
}

struct CircleGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            CircleGroupView(shapOpacity: 0.2, shapeColor: .white)
        }
    }
}
