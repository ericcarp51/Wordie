//
//  WordViewController.swift
//  Wordie
//
//  Created by Eric Carp on 4/27/21.
//

import UIKit

class WordViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    /// Property that holds an existing word to edit when the user has tapped a cell in the ListOfWordsTableViewController or is nil when the user wants to add a new word into the dictionary.
    private(set) var word: Word
    
    /// Data sources to manage the table views in the controller.
    private lazy var dataSources = (0..<tableViews.count).map { _ in
        DataSourceManager()
    }
    
    // MARK: - Initializers
    
    init?(coder: NSCoder, word: Word) {
        self.word = word
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Outlets
    
    @IBOutlet private weak var saveBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var wordTextField: UITextField!
    @IBOutlet private var tableViews: [UITableView]!
    
    // MARK: - Load points:
    
    override func viewDidLoad() {
        
        guard WordID.allCases.count == tableViews.count else {
            fatalError("Inadequate number of word components and table views to represent them")
        }
        
        super.viewDidLoad()
        
        /// wordTextField's delegate is assign to the controller to inform it when the user interacts with the textField
        wordTextField.delegate = self
        
        /// Populating of the wordTextField and the tableViews of the self
        wordTextField.text = word.spelling
        
        for (index, tableView) in tableViews.enumerated() {
            tableView.dataSource = dataSources[index]
        }
        
        for (index, dataSource) in dataSources.enumerated() {
            let cases = WordID.allCases
            dataSource.id = cases[index]
            dataSource.words = word.components[index].words
        }
        
        /// Enabling and disabling of the saveBarButton
        if wordTextField.text!.isEmpty {
            saveBarButtonItem.isEnabled = false
        }
    }
    
    // MARK: - Actions
    
    /// Triggers when the user taps an add (with "+" sign) button to add a new word to a particular group (definition, synonym, antonym or example).
    @IBAction private func add(_ sender: UIButton) {
        switch sender.tag {
        case let tag:
            alert(tag, dataSources[tag].id.rawValue)
        }
    }
    
    @IBAction private func editingDidChange(_ sender: UITextField) {
        let textFieldIsEmpty = sender.text!.isEmpty
        saveBarButtonItem.isEnabled = textFieldIsEmpty ? false : true
    }
    
    // MARK: - Methods
    
    /// Presents an alert form for adding a new category word
    /// - Parameters:
    ///   - tag: Corresponding tag of the button that has been tapped
    ///   - category: Corresponding category of the dataSource
    private func alert(_ tag: Int, _ category: String) {
        let alert = UIAlertController(title: "New \(category)", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add \(category)", style: .default) { (action) in
            if let text = alert.textFields?.first?.text {
                self.dataSources[tag].words.append(text)
                DispatchQueue.main.async {
                    self.tableViews[tag].reloadData()
                }
            }
        }
        alert.addTextField { (textField) in
            textField.placeholder = "\(category)".capitalized
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.unwindSegueIdentifier {
            word.spelling = wordTextField.text!
            for (index, dataSource) in dataSources.enumerated() {
                word.components[index].words = dataSource.words
            }
        }
    }
    
    // MARK: - Deinitializer
    
    deinit {
        print("Successfully deinitialized")
    }
    
}
