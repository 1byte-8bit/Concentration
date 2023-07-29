//
//  Concentration.swift
//  Concentration
//
//  Created by Alexandr on 23.03.2023.
//

import Foundation

class Concentration {
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set(newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int){
        assert(cards.indices.contains(index),
               "Concentration.choseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            print("not isMatched \(!cards[index].isMatched)")
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                print("matchIndex \(matchIndex)")
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    private func shuffleCards(){
        self.cards.shuffle()
    }
    
    init(numbersOfPairsOfCards: Int){
        assert(numbersOfPairsOfCards > 0,
               "Concentration.init(\(numbersOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numbersOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        shuffleCards()
    }

}
