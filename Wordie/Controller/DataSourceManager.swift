//
//  DataSourceManager.swift
//  Wordie
//
//  Created by Eric Carp on 4/29/21.
//

import UIKit

class DataSourceManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    /// Used to store category words (definitions, synonyms, antonyms or examples)
    var words = [String]()
    
    /// Identifier to determine which category is stored in the self.words property
    var id: WordID!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: id.rawValue, for: indexPath)
        cell.textLabel?.text = words[indexPath.row]
        return cell
    }
    
}
