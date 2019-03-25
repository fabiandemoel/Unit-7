//
//  ResultsViewViewController.swift
//  Trivia
//
//  Created by Fabian de Moel on 04/03/2019.
//  Copyright © 2019 Fabian de Moel. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITextFieldDelegate {

    // Outlets
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    
    
    // Variables
    var score: Int!
    var userScore: Score?
    
    
    // Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        updateUI()
    }
    
    func updateUI() {
        scoreLabel.text = "\(String(score)) points!"
    }
    
    // Submit score
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let name = nameField.text!
        let postScore = ["name": name, "score": String(score)]
        
        ResultsController.shared.addScore(forScore: postScore)
        { (score) in
            DispatchQueue.main.async {
                print(score)
                if let score = score {
                    self.userScore = score
                    self.performSegue(withIdentifier: "HighscoresSegue", sender: nil)
                }
            }
        }
        return true
    }
    
    // Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HighscoresSegue" {
            let highscoresViewController = segue.destination as! HighscoresViewController
            highscoresViewController.userScore = userScore
        }
    }
}
