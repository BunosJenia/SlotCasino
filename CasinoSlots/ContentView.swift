//
//  ContentView.swift
//  CasinoSlots
//
//  Created by Yauheni Bunas on 6/17/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    
    @State private var firstSlotsLine: [SlotBlock] = [
        SlotBlock(background: Color.white, symbol: Symbols.allCases.randomElement()!),
        SlotBlock(background: Color.white, symbol: Symbols.allCases.randomElement()!),
        SlotBlock(background: Color.white, symbol: Symbols.allCases.randomElement()!)
    ]
    @State private var credits = 1000
    @State private var betAmount = 5
    
    @State private var isValid = false
    
    var body: some View {
        ZStack {
            
            // BACKGROUND
            Rectangle()
                .foregroundColor(Color(red: 200/255, green: 143/255, blue: 32/255))
                .edgesIgnoringSafeArea(.all)
            
            Rectangle()
                .foregroundColor(Color(red: 228/255, green: 195/255, blue: 76/255))
                .rotationEffect(Angle(degrees: 45))
            .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                Spacer()
                
                // HEADER TITLE
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Text("Casino Slots")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
                .scaleEffect(2)
                
                Spacer()
                
                // CREDIT
                Text("Credits: " + String(credits))
                    .foregroundColor(.black)
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(20)
                
                Spacer()
                
                // SLOTS
                VStack {
                    HStack {
                        ForEach(firstSlotsLine, id: \.self) { slotBlock in
                            CardView(slotBlock: slotBlock)
                        }
                    }
                }
                
                Spacer()
                
                Button(action: {
                    self.firstSlotsLine = self.firstSlotsLine.map { _ in
                        SlotBlock(background: Color.white, symbol: Symbols.allCases.randomElement()!)
                    }
                    
                    self.isValid = self.firstSlotsLine.allSatisfy { slotBlock in
                        return slotBlock.symbol == self.firstSlotsLine.first!.symbol
                    }
                    
                    if self.isValid {
                        self.credits += self.betAmount * 10
                        
                        self.firstSlotsLine = self.firstSlotsLine.map { slotBlock in
                            SlotBlock(background: Color.green, symbol: slotBlock.symbol)
                        }
                    } else {
                        self.credits -= self.betAmount
                    }
                }) {
                    Text("Spin")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.all, 10)
                        .padding(.horizontal, 30)
                        .background(Color.pink)
                        .clipShape(Capsule())
                }
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SlotBlock: Hashable {
    var background: Color = Color.white
    var symbol: Symbols
}

enum Symbols: String, CaseIterable, Hashable {
    case apple = "apple"
    case lemon = "lemon"
    case donut = "donut"
}
