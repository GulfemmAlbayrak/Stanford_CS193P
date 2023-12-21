//
//  ViewController.swift
//  PlayingCard
//
//  Created by Gülfem Albayrak on 21.12.2023.
//

import UIKit

class ViewController: UIViewController {
var deck = PlayingCardDeck()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 1...10 {
            if let card = deck.draw() {
                print("\(card)")
            }
        }
    }


}

