//
//  OnboardingView.swift
//  Restart
//
//  Created by nasser on 28/2/2023.
//

import SwiftUI

struct OnboardingView: View {
    // MARK: PROPERTY
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var textTitle: String = "Share."
    let hapticFeedback = UINotificationFeedbackGenerator()
    // MARK: BODY
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            VStack(spacing: 20.0) {
                
                // MARK: HEADER
                
                Spacer()
                
                VStack(spacing: 0.0) {
                    
                    Text(textTitle)
                        .font(.system(size: 60.0))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)
                    Text("""
                    It's nt how much we give but
                    how much love we put into giving.
                    """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                } //: HEADER
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                // MARK: CENTER
                
                ZStack {
                    ZStack {
                        CircleGroupView(shapOpacity: 0.2, shapeColor: .white)
                            .offset(x: imageOffset.width * -1, y: 0)
                            .blur(radius: abs(imageOffset.width) / 5.0)
                            .animation(.easeOut(duration: 0.5), value: imageOffset)
                        Image("character-1")
                            .resizable()
                            .scaledToFit()
                            .offset(x: imageOffset.width * 1.2, y: 0.0)
                            .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                            .opacity(isAnimating ? 1 : 0)
                            .animation(.easeOut(duration: 0.5), value: isAnimating)
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        withAnimation(Animation.linear(duration: 0.25)){
                                            imageOffset = gesture.translation
                                            if abs(gesture.translation.width) <= 150 {
                                                indicatorOpacity = 0.0
                                                textTitle = "Give."
                                            }
                                        }
                                    }
                                    .onEnded{ _ in
                                        imageOffset = .zero
                                        withAnimation(Animation.linear(duration: 0.25)){
                                            indicatorOpacity = 1.0
                                            textTitle = "Share."
                                        }
                                    }
                            ) //: GESTURE
                            .animation(.easeOut(duration: 0.5), value: imageOffset)
                        
                            
                    } //: ZSTACK
                } //: CENTER
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44.0, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y: 20)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                        .opacity(indicatorOpacity)
                    ,
                    alignment: .bottom
                )
                Spacer()
                // MARK: FOOTER
                
                ZStack {
                    // PARTS OF THE CUSTOM BUTTON
                    
                    // 1. BACKGROUND (STATIC)
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    // 2. CALL-TO-ACTION (STATIC)
                    
                    Text("Get started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    // 3. CAPSULE (DYNALic WIDTH)
                    
                    HStack {
                        
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80)
                        Spacer()
                    } //: HSTACK
                    
                    // 4. CIRCLE (DRAGGABLE)
                    
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(Color.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        } //: ZSTACK
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if gesture.translation.width > 0  && buttonOffset < buttonWidth - 80 {
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded{ _ in
                                    withAnimation(Animation.easeOut(duration: 0.4)) {
                                        if buttonOffset <= buttonWidth / 2 {
                                            buttonOffset = 0
                                            hapticFeedback.notificationOccurred(.warning)
                                        } else {
                                            buttonOffset = buttonWidth - 80
                                            isOnboardingViewActive = false
                                            hapticFeedback.notificationOccurred(.success)
                                            playSound(sound: "success", type: "m4a")
                                        }
                                    }
                                }
                        ) //: GESTURE
                        Spacer()
                    } //: HSTACK
                    
                } //: FOOTER
                .frame(width: buttonWidth,height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            } //: VSTACK
        } //: ZSTACK
        .onAppear(perform: {
            isAnimating = true
        })
        .preferredColorScheme(.dark)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
