//
//  MainView.swift
//  CasinoSlots
//
//  Created by Yauheni Bunas on 6/18/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import SwiftUI

struct MainView: View {
//    @State private var topSlotsLine: [SlotBlock] = MainView.generateSlotLineData()
//    @State private var mainSlotsLine: [SlotBlock] = MainView.generateSlotLineData()
//    @State private var bottomSlotsLine: [SlotBlock] = MainView.generateSlotLineData()
    
    @State private var slotBlocks: SlotBlocks = SlotBlocks()
//    @State private var mainSlotBlockLine: SlotBlockLine = SlotBlockLine()
//    @State private var bottomSlotBlockLine: SlotBlockLine = SlotBlockLine()

    @State private var credits = 1000
    @State private var betAmount = 5
    
    @State private var isJackPot: Bool = true
    
    private var maxBetAmountCoefficient = 5
    
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
                        CardView(slotBlock: self.$slotBlocks.topLine.firstBlock)
                        CardView(slotBlock: self.$slotBlocks.topLine.secondBlock)
                        CardView(slotBlock: self.$slotBlocks.topLine.thirdBlock)
                    }
                    
                    HStack {
                        CardView(slotBlock: self.$slotBlocks.mainLine.firstBlock)
                        CardView(slotBlock: self.$slotBlocks.mainLine.secondBlock)
                        CardView(slotBlock: self.$slotBlocks.mainLine.thirdBlock)
                    }
                    
                    HStack {
                        CardView(slotBlock: self.$slotBlocks.bottomLine.firstBlock)
                        CardView(slotBlock: self.$slotBlocks.bottomLine.secondBlock)
                        CardView(slotBlock: self.$slotBlocks.bottomLine.thirdBlock)
                    }
                    
                }
                
                Spacer()
                
                HStack {
                    VStack {
                        Button(action: {
                            self.mainLineSpin()
                        }) {
                            Text("Spin")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.all, 10)
                                .padding(.horizontal, 30)
                                .frame(width: (UIScreen.main.bounds.width / 2) - 30)
                                .background(Color.pink)
                                .clipShape(Capsule())
                        }
                        
                        Text("\(betAmount) credits")
                            .padding()
                            .font(.callout)
                    }
                    
                    VStack {
                        Button(action: {
                            self.allLinesSpin()
                        }) {
                            Text("Max Spin")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.all, 10)
                                .padding(.horizontal, 30)
                                .frame(width: (UIScreen.main.bounds.width / 2) - 30)
                                .background(Color.pink)
                                .clipShape(Capsule())
                        }
                        
                        Text("\(betAmount * maxBetAmountCoefficient) credits")
                            .padding()
                            .font(.callout)
                    }
                }
                
                Spacer()
            }
            
            if self.isJackPot {
                JackPotView(isJackPot: self.$isJackPot)
            }
        }
    }
}

extension MainView {
    private func allLinesSpin() {
        self.slotBlocks.updateAllBlocksToRandomSymbols()

        let matches = self.slotBlocks.getMatches()

        if matches == 5 {
            self.isJackPot = true
            self.credits += self.betAmount * matches * 10 * 5
        } else if matches > 0 {
            self.credits += self.betAmount * matches * 10
        } else {
            self.credits -= self.betAmount * self.maxBetAmountCoefficient
        }
    }
    
    private func mainLineSpin() {
        self.slotBlocks.mainLine.updateBlockToRandomSymbols()
        
        if self.slotBlocks.mainLine.isValidLine() {
            self.credits += self.betAmount * 10
            
            self.slotBlocks.mainLine.updateValidBlock()
        } else {
            self.credits -= self.betAmount
        }
    }
}
