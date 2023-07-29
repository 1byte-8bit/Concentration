//
//  Card.swift
//  Concentration
//
//  Created by Alexandr on 23.03.2023.
//

import Foundation

struct Card {
    var isMatched = false
    var isFaceUp = false
    var identifier: Int
    
    private static var identifireFactory = 0
    
    private static func getUnicIdentifire() -> Int{
        identifireFactory += 1
        return identifireFactory
    }
    
    init(){
        self.identifier = Card.getUnicIdentifire()
    }
}
