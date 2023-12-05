//
//  ViewController.swift
//  Concentration
//
//  Created by Gülfem Albayrak on 2.12.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var playButton: UIButton!
    
    var emojiChoices: Array<String> = ["🦇","😱","🙀","😈","🎃","👻","🍭","🍬","🍎"]
    var emoji = [Int:String]()
    lazy var game: Concentration = Concentration(numberOfPairsOfCards: cardButtons.count / 2)
    var flipCount = 0 { didSet { flipCountLabel.text = "Flips: \(flipCount)" } }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playButton.isHidden = cardButtons.count == 2 ? false : true
    }

    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }

    @IBAction func playButtonTapped(_ sender: Any) {
        playButton.isHidden = true
        resetGame()
    }
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? .orange.withAlphaComponent(0) : .orange
            }
            
        }
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    func resetGame(){
        flipCount = 0
        emoji.removeAll()
        emojiChoices = ["🦇","😱","🙀","😈","🎃","👻","🍭","🍬","🍎"]
        game = Concentration(numberOfPairsOfCards: cardButtons.count / 2)
        updateViewFromModel()
    }
}

