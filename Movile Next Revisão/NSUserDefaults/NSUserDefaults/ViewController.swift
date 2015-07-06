//
//  ViewController.swift
//  NSUserDefaults
//
//  Created by Dennis de Oliveira on 28/06/15.
//  Copyright (c) 2015 Dennis de Oliveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Outlets
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var retrieveButton: UIButton!
    
    // User Defaults
    let defaults = UserDefaultsManager()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Actions
    
    @IBAction func savePressed(sender: AnyObject) {
        
        /*if var text = self.textTextField.text {
            self.defaults.saveDefaults(text)
            self.textTextField.text = ""
            println("Texto salvo")
            UIAlertView(title: "Feedback", message: "Texto salvo com sucesso!", delegate: self, cancelButtonTitle: "OK").show()
        }*/
        
        if let id = self.textTextField.text.toInt() {
            self.defaults.setFavorite(id)
            self.textTextField.text = ""
        }
        
        
        
    }
    
    @IBAction func retrievePressed(sender: AnyObject) {
        
        /*if let retrieveText = self.defaults.retrieveDefaults() {
            self.textLabel.text = retrieveText
        }*/
        
        if self.defaults.favoritesIdentifiers.contains(1) {
            println("Número 1 está no set")
        }
        
        var array: Array<Int> = Array(self.defaults.favoritesIdentifiers)
        println("Todos os elementos do array")
        for id in array {
            println("Id: \(id)")
        }
        
    }
}

