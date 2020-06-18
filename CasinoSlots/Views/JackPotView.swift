//
//  JackPotView.swift
//  CasinoSlots
//
//  Created by Yauheni Bunas on 6/18/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import SwiftUI

struct JackPotView: View {
    @Binding var isJackPot: Bool
    
    var anglesToRotate = [0, 11.25, 22.5, 33.75, 45, 56.25, 67.5, 78.75]
    var degree = 0
    var degreeStep = 11.25
    
    @State var show = false
    
    
    
    var body: some View {
        ZStack {
            Rectangle()
                .edgesIgnoringSafeArea(.all)
                .foregroundColor(Color.black.opacity(0.5))
            
            ForEach(anglesToRotate, id: \.self) { degree in
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width / 1.7, height: UIScreen.main.bounds.width / 1.7)
                    .rotationEffect(Angle(degrees: degree))
                    .foregroundColor(Color.yellow)
                    .rotationEffect(.init(degrees: self.show ? 360 : 0))
                    .scaleEffect(self.show ? 1 : 0.8)
            }
            
            Circle()
                .frame(width: UIScreen.main.bounds.width / 1.35)
                .foregroundColor(Color.yellow)
                .scaleEffect(self.show ? 1 : 0.85)
            
            VStack {
                Text("You won")
                    .font(.title)
                    .fontWeight(.bold)
                    .shadow(radius: 5)
                
                Text("JACKPOT!")
                    .font(.title)
                    .fontWeight(.bold)
                    .shadow(radius: 5)
            }
            .scaleEffect(self.show ? 1.2 : 1)
        }
        .onAppear {
            withAnimation(Animation.default.speed(0.3).repeatForever(autoreverses: true)) {
                self.show.toggle()
            }
        }
        .onTapGesture {
            self.isJackPot.toggle()
        }
    }
}
