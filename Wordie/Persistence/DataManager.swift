//
//  DataManager.swift
//  Wordie
//
//  Created by Eric Carp on 5/6/21.
//

import Foundation
import UIKit

class DataManager {
    
    /// File's path
    private let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    /// File's name and extension
    private lazy var archiveURL = documentsDirectory.appendingPathComponent("listOfWords").appendingPathExtension("plist")
    
    /// Saves provided data into the file
    /// - Parameter data: The words the user wants to save to their dictionary
    func save(_ data: [Word]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedData = try? propertyListEncoder.encode(data)
        if let encodedData = encodedData {
            do {
                try encodedData.write(to: archiveURL, options: .noFileProtection)
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("Could not encode data")
        }
    }
    
    /// Reads data from the file
    /// - Returns: The words the user has saved in their dictionary otherwise nil if they haven't
    func read() -> [Word]? {
        let propertyListDecoder = PropertyListDecoder()
        guard let data = try? Data(contentsOf: archiveURL) else { return nil }
        let decodedData = try? propertyListDecoder.decode([Word].self, from: data)
        return decodedData
    }
    
}
