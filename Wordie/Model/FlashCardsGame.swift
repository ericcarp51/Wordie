//
//  FlashCardsGame.swift
//  Wordie
//
//  Created by Eric Carp on 5/6/21.
//

import Foundation

struct FlashCardsGame {
    
    /// Used to hold all the words the user currently has in their dictionary
    var words = [Word]()
    
    /// Returns a string with the word's spelling
    var spelling: String {
        return words[count].spelling
    }
    
    /// Returns a string that has all the definitions of a word
    var definitions: String {
        var str = ""
        let word = words[count]
        let components = word.components
        if let definitions = components.first?.words {
            str = definitions.joined(separator: "\n")
        }
        return str
    }
    
    /// Comunicates the position the user currenty in
    private(set) var count = 0 {
        didSet {
            isFirstWord = count == 0 ? true : false
            isLastWord = count == words.count - 1 ? true : false
        }
    }
    
    /// If it's true the card is up and the user sees a word otherwise the card is down and the user sees all the definitions a word has
    private(set) var isFaceUp = true
    
    /// If it's true comunicates that the user sees the first word in his dictionary
    private(set) var isFirstWord = true
    
    /// If it's true the comunicates that the user sees the last word in his dictionary
    private(set) var isLastWord = false
    
    /// Changes the current isFaceUp property to the oppisite to represent as if the user flips the card
    mutating func flipCard() {
        isFaceUp = !isFaceUp
    }
    
    /// Increases count by 1 to represent as if the user moved to the next word in their dictionary
    mutating func nextCard() {
        count += 1
    }
    
    /// Decreases count by 1 to represent as if the user moved to the previous word in their dictionary
    mutating func previousCard() {
        count -= 1
    }
    
}
