//
//  FlashCardsViewController.swift
//  Wordie
//
//  Created by Eric Carp on 5/5/21.
//

import UIKit

class FlashCardsViewController: UIViewController {
    
    // MARK: - Properties
    
    /// Used to manage data persistence
    private let dataManager = DataManager()
    
    /// Used to manage flash cards logic
    private var flashCardsGame = FlashCardsGame()
    
    // MARK: - Outlets

    @IBOutlet private weak var cardLabel: UILabel!
    @IBOutlet private weak var previousWordButton: UIButton!
    @IBOutlet private weak var nextWordButton: UIButton!
    
    // MARK: - Lifecycle points
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Checks if the user has already added words to their dictionary otherwise disables the buttons and provides a message to inform the user that their dictionary is empty
        if let words = dataManager.read() {
            flashCardsGame.words = words
            cardLabel.text = flashCardsGame.spelling
        } else {
            cardLabel.text = "Add words"
            nextWordButton.isEnabled = false
        }
        previousWordButton.isEnabled = false
    }
    
    // MARK: - Actions
    
    /// Activates a series of methods when the user taps the card
    @IBAction private func flipCard(_ sender: UITapGestureRecognizer) {
        flashCardsGame.flipCard()
        updateUI()
        animateCardFlip()
    }
    
    /// Activates a series of methods when the user taps previousWordButton or nextWordButton
    @IBAction private func nextWord(_ sender: UIButton) {
        if sender.currentTitle == K.nextWordButtonTitle {
            flashCardsGame.nextCard()
        } else {
            flashCardsGame.previousCard()
        }
        updateUI()
        animateCardTransition(sender)
    }
    
    // MARK: - Methods
    
    /// Updates cardLabel.text and isEnable property of previousWordButton and nextWordButton accordingly
    private func updateUI() {
        if flashCardsGame.isFaceUp {
            cardLabel.text = flashCardsGame.spelling
        } else {
            cardLabel.text = flashCardsGame.definitions
        }
        
        previousWordButton.isEnabled = flashCardsGame.isFirstWord ? false : true
        nextWordButton.isEnabled = flashCardsGame.isLastWord ? false : true
    }
    
    /// Provides animation of flipping a card
    private func animateCardFlip() {
        UIView.transition(with: cardLabel, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    
    /// Determines which one of previousWordButton or nextWordButton the user taps and animates accordingly
    private func animateCardTransition(_ sender: UIButton) {
        let animation = sender.currentTitle == K.nextWordButtonTitle ? UIView.AnimationOptions.transitionCurlDown : UIView.AnimationOptions.transitionCurlUp
        UIView.transition(with: cardLabel, duration: 0.3, options: animation, animations: nil, completion: nil)
    }
    
}
