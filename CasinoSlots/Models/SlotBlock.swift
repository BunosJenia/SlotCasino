//
//  SlotBlock.swift
//  CasinoSlots
//
//  Created by Yauheni Bunas on 6/18/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import SwiftUI

class SlotBlocks: Identifiable {
    var id = UUID()
    var topLine: SlotBlockLine
    var mainLine: SlotBlockLine
    var bottomLine: SlotBlockLine
    
    init() {
        self.topLine = SlotBlockLine()
        self.mainLine = SlotBlockLine()
        self.bottomLine = SlotBlockLine()
    }
    
    func updateAllBlocksToRandomSymbols() {
        self.topLine.updateBlockToRandomSymbols()
        self.mainLine.updateBlockToRandomSymbols()
        self.bottomLine.updateBlockToRandomSymbols()
    }
    
    func getMatches() -> Int {
        var matches = 0
        
        if self.topLine.isValidLine() {
            matches += 1
            self.topLine.updateValidBlock()
        }
        
        if self.mainLine.isValidLine() {
            matches += 1
            self.mainLine.updateValidBlock()
        }
        
        if self.bottomLine.isValidLine() {
            matches += 1
            self.bottomLine.updateValidBlock()
        }
        
        if self.isValidFirstDiagonal() {
            matches += 1
            
            self.topLine.firstBlock.updateToValid()
            self.mainLine.secondBlock.updateToValid()
            self.bottomLine.thirdBlock.updateToValid()
        }
        
        if self.isValidSecondDiagonal() {
            matches += 1

            self.topLine.thirdBlock.updateToValid()
            self.mainLine.secondBlock.updateToValid()
            self.bottomLine.firstBlock.updateToValid()
        }
        
        return matches
    }
    
    func isValidFirstDiagonal() -> Bool {
        if self.topLine.firstBlock.symbol == self.mainLine.secondBlock.symbol && self.topLine.firstBlock.symbol == self.bottomLine.thirdBlock.symbol {
            return true
        }
        
        return false
    }
    
    func isValidSecondDiagonal() -> Bool {
        if self.topLine.thirdBlock.symbol == self.mainLine.secondBlock.symbol && self.topLine.thirdBlock.symbol == self.bottomLine.firstBlock.symbol {
            return true
        }

        return false
    }
}

class SlotBlockLine: Identifiable {
    var id = UUID()
    var firstBlock: SlotBlock = SlotBlock(symbol: Symbols.allCases.randomElement()!)
    var secondBlock: SlotBlock = SlotBlock(symbol: Symbols.allCases.randomElement()!)
    var thirdBlock: SlotBlock = SlotBlock(symbol: Symbols.allCases.randomElement()!)
    
    func isValidLine() -> Bool {
        if firstBlock.symbol == secondBlock.symbol && secondBlock.symbol == thirdBlock.symbol {
            return true
        }
        
        return false
    }
    
    func updateBlockToRandomSymbols() {
        self.firstBlock = SlotBlock(symbol: Symbols.allCases.randomElement()!)
        self.secondBlock = SlotBlock(symbol: Symbols.allCases.randomElement()!)
        self.thirdBlock = SlotBlock(symbol: Symbols.allCases.randomElement()!)
    }
    
    func updateValidBlock() {
        self.firstBlock.updateToValid()
        self.secondBlock.updateToValid()
        self.thirdBlock.updateToValid()
    }
}

class SlotBlock: Identifiable {
    var id = UUID()
    var symbol: Symbols = Symbols.apple
    var background: Color = Color.white
    var isValid: Bool = false
    
    init(symbol: Symbols, isValid: Bool = false) {
        self.symbol = symbol
        
        if isValid {
            self.background = Color.green
            self.isValid = true
        } else {
            self.background = Color.white
            self.isValid = false
        }
    }
    
    func updateToValid() {
        self.isValid = true
        self.background = Color.green
    }
}

enum Symbols: String, CaseIterable, Hashable {
    case apple = "apple"
    case lemon = "lemon"
    case donut = "donut"
}
