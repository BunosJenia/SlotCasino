//
//  CardView.swift
//  CasinoSlots
//
//  Created by Yauheni Bunas on 6/17/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import SwiftUI

struct CardView: View {
//    @Binding var symbol: String
//    //@Binding var isMatched: Bool
//    @Binding var background: Color
    
    @State var slotBlock: SlotBlock
    
    var body: some View {
        Image(slotBlock.symbol.rawValue)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .padding(.all, 5)
            .background(slotBlock.background.opacity(0.5))
            .cornerRadius(20)
            .frame(width: 100, height: 100)
    }
}
