//
//  ViewController.swift
//  Concentration
//
//  Created by Alexandr on 22.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    
    private lazy var game = Concentration(numbersOfPairsOfCards: numberOfPairsOfCards)
    
    // Computed Property
    var numberOfPairsOfCards: Int {
        get {
            return (cardButtons.count + 1) / 2
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    private var emojiChoises = ["👻", "🎃", "🦋", "🍎", "🍭", "😱", "🥶", "🤪", "🦇", "🪲", "🐝"]
    
    private var emoji = [Int:String]()
    
    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        print("Touch")
        
        flipCount += 1
        changeCardBackground(on: sender)
    }
    
    private func changeCardBackground(on button: UIButton){
        
        if let cardNumber = cardButtons.firstIndex(of: button){
            print("Card Number \(cardNumber)")
            game.chooseCard(at: cardNumber)
        } else {
            print("chosen card was not in cardButtons")
        }
        
        updateViewFromModel()
    }
    
    // MARK: Handle
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]

            if card.isFaceUp {
                button.backgroundColor = .white
                button.setTitle(emoji(for: card), for: .normal)
                button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16) // .systemFont(ofSize: 16)
                
            } else {
                button.backgroundColor = card.isMatched ? .init(white: .zero, alpha: 0) : .orange// #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                button.setTitle("", for: .normal)
            }
        }
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoises.count > 0 {
            emoji[card.identifier] = emojiChoises.remove(at: emojiChoises.count.arc4random)
        }
        
        return emoji[card.identifier] ?? "?"
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
