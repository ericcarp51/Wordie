//
//  FlashCardsGameTests.swift
//  WordieTests
//
//  Created by Eric Carp on 5/8/21.
//

import XCTest
@testable import Wordie

class FlashCardsGameTests: XCTestCase {
    
    // MARK: - Mock objects
    
    private let word1 = Word(
        spelling: "Spelling1",
        components: [
            WordComponent(id: .definition, words: ["Defintion11", "Definition12"]),
            WordComponent(id: .synonym, words: ["Synonym11", "Synonym12"]),
            WordComponent(id: .antonym, words: ["Antonym11", "Antonym12"]),
            WordComponent(id: .example, words: ["Example11", "Example12"])
        ])
    
    private let word2 = Word(
        spelling: "Spelling2",
        components: [
            WordComponent(id: .definition, words: ["Defintion21", "Definition22"]),
            WordComponent(id: .synonym, words: ["Synonym21", "Synonym22"]),
            WordComponent(id: .antonym, words: ["Antonym21", "Antonym22"]),
            WordComponent(id: .example, words: ["Example21", "Example22"])
        ])
    
    private let word3 = Word(
        spelling: "Spelling3",
        components: [
            WordComponent(id: .definition, words: ["Defintion31", "Definition32"]),
            WordComponent(id: .synonym, words: ["Synonym31", "Synonym32"]),
            WordComponent(id: .antonym, words: ["Antonym31", "Antonym32"]),
            WordComponent(id: .example, words: ["Example31", "Example32"])
        ])
    
    lazy private var flashCardsGame = FlashCardsGame(words: [word1, word2, word3])
    
    // MARK: - Tests
    
    func testSpelling() {
        XCTAssertEqual(flashCardsGame.spelling, "Spelling1")
    }
    
    func testDefinitionStr() {
        XCTAssertEqual(flashCardsGame.definitions, "1: Defintion11\n2: Definition12\n")
    }
    
    func testCount() {
        XCTAssertEqual(flashCardsGame.count, 0)
    }
    
    func testIsFaceUp() {
        XCTAssertTrue(flashCardsGame.isFaceUp)
    }
    
    func testIsFirstWord() {
        XCTAssertTrue(flashCardsGame.isFirstWord)
    }
    
    func testIsLastWord1() {
        XCTAssertFalse(flashCardsGame.isLastWord)
    }
    
    func testIsLastWord2() {
        flashCardsGame.count = flashCardsGame.words.count - 1
        XCTAssertEqual(flashCardsGame.isLastWord, true)
    }
    
    func testFlipCard() {
        flashCardsGame.flipCard()
        XCTAssertEqual(flashCardsGame.isFaceUp, false)
    }
    
    func testNextWord() {
        flashCardsGame.nextCard()
        XCTAssertEqual(flashCardsGame.count, 1)
    }
    
    func testPreviousWord() {
        flashCardsGame.count = 1
        flashCardsGame.previousCard()
        XCTAssertEqual(flashCardsGame.count, 0)
    }
    
}
