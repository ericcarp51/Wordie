//
//  Word.swift
//  Wordie
//
//  Created by Eric Carp on 4/28/21.
//

import Foundation

/// Structure to represent a word in the user's dictionary
struct Word: Codable {
    /// Word's spelling
    var spelling = String()
    /// Array of components a word has; this property has a strong connection with WordID and stores exact number of WordComponents as WordID.allCaces.count
    var components = [WordComponent]()
}

/// Structure to represent a component in a word; a component is obligated to have an id even though the words property can be empty array of strings
struct WordComponent: Codable {
    var id: WordID
    var words = [String]()
}

/// Limited categories a word has
enum WordID: String, CaseIterable, Codable {
    case definition = "definition"
    case synonym = "synonym"
    case antonym = "antonym"
    case example = "example"
}
