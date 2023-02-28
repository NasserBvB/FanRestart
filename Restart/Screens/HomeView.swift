//
//  HomeView.swift
//  Restart
//
//  Created by nasser on 28/2/2023.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: PROPERTY
    
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
    @State private var isAnimating: Bool = false
    
    // MARK: BODY
    
    var body: some View {
        VStack(spacing: 20) {
            
            // MARK: HEADER
            
            Spacer()
            
            ZStack {
                CircleGroupView(shapOpacity: 0.1, shapeColor: .gray)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                .padding()
                .offset(y: isAnimating ? 35 : -35)
                .animation(
                Animation
                    .easeOut(duration: 4)
                    .repeatForever()
                ,
                value: isAnimating
                
                )
            }
            
            // MARK: CENTER
            
            Text("The time that leads to mastery is dependent on the intensity of our focus.")
                .font(.system(.title3, weight: .light))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            // MARK: FOOTER
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    isOnboardingViewActive = true
                    playSound(sound: "chimeup", type: "mp3")
                }
            }) {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("Restart")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            } //: Button
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        } //: VSTACK
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                isAnimating = true
            })
        })
        .preferredColorScheme(.dark)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
