//
//  CardView.swift
//  CasinoSlots
//
//  Created by Yauheni Bunas on 6/17/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import SwiftUI

struct CardView: View {
    @Binding var slotBlock: SlotBlock
    
    var body: some View {
        Image(slotBlock.symbol.rawValue)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .padding(.all, 5)
            .background(slotBlock.background.opacity(0.5))
            .cornerRadius(20)
            .frame(width: 100, height: 100)
            .padding(.all, 5)
            .scaleEffect(slotBlock.isValid ? 1 : 1.03)
            .animation(slotBlock.isValid ? Animation.easeInOut(duration: 0.3).repeatCount(7, autoreverses: true) : nil)
            .shadow(radius: slotBlock.isValid ? 7 : 5)
            
    }
}
