//
//  ListOfWordsTableViewController.swift
//  Wordie
//
//  Created by Eric Carp on 4/27/21.
//

import UIKit

class ListOfWordsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    /// Used to manage data persistence
    private let dataManager = DataManager()
    
    /// Used to hold the words to display in the table view
    private var listOfWords = [Word]()

    // MARK: - Lifecycle points
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Checks if the user already has words in their dictionary
        if let wordsFromFile = dataManager.read() {
            listOfWords = wordsFromFile
        } else {
            print("No saved data")
        }
        
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfWords.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.wordieListOfWordsCellIdentifier, for: indexPath)
        let word = listOfWords[indexPath.row]
        cell.textLabel?.text = word.spelling
        return cell
        
    }
    
    // MARK: - Actions
    
    /// Activates when the user taps a cell or add "+" bar button item
    @IBSegueAction private func addEditWord(_ coder: NSCoder, sender: Any?, segueIdentifier: String?) -> WordViewController? {
        /// Check if the user taps a cell or the add "+" bar button item
        switch segueIdentifier {
        /// If the user taps the add "+" bar button item this case gets triggered; it initializes a WordViewController asigning to its word property a default value
        case K.newWordSegueIdentifier:
            let numberOfCategories = WordID.allCases
            var newWord = Word()
            for category in numberOfCategories {
                newWord.components.append(WordComponent(id: category))
            }
            return WordViewController(coder: coder, word: newWord)
        /// If the user taps a cell this case gets triggered; it initializes a WordViewController asigning to its word property the word that is stored in the cell
        case K.editWordSegueIdentifier:
            let cell = sender as! UITableViewCell
            let index = tableView.indexPath(for: cell)!.row
            let wordToEdit = listOfWords[index]
            return WordViewController(coder: coder, word: wordToEdit)
        default:
            fatalError("Fail to initialize WordViewController")
        }
    }
    
    // MARK: - Unwind segue
    
    /// Activates when the user taps the save bar button item in the WordViewController
    @IBAction private func unwindToListOfWords(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source as! WordViewController
        let word = sourceViewController.word
        /// If the user selected a sell to edit a word the tableView.indexPathForSelectedRow property isn't nil so the cell gets updated with the changes the user makes alternatively a new cell gets added
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            listOfWords[selectedIndexPath.row] = word
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: listOfWords.count, section: 0)
            listOfWords.append(word)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        /// Saving listOfWords to the plist file
        dataManager.save(listOfWords)
    }
    
}
