//
//  HighscoresViewController.swift
//  Trivia
//
//  Created by Fabian de Moel on 04/03/2019.
//  Copyright © 2019 Fabian de Moel. All rights reserved.
//

import UIKit

class HighscoresViewController: UITableViewController {
    
    // Variables
    var highscores = [Score]()
    var userScore: Score?
  
    // Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        ResultsController.shared.fetchHighscores { (highscores) in
            if let highscores = highscores{
                self.updateUI(with: highscores)
            }
        }
    }
    
    
    func updateUI(with highscores: [Score]) {
        
        // load highscores
        DispatchQueue.main.async {
            self.highscores = highscores
            if let newScore = self.userScore {
                self.highscores.append(newScore)
            }
            self.highscores = self.highscores.sorted(by: { Int($0.score)! > Int($1.score)! })
            self.tableView.reloadData()
        }
        
        // load sample highscores
//        self.highscores = HighscoreList.loadSampleHighscores()
//        self.highscores = self.highscores.sorted(by: { Int($0.score)! > Int($1.score)! })
//        self.tableView.reloadData()

    }
    
    // load tables
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highscores.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HighscoreIdentifier") else {fatalError("Could not dequeue a cell")}
        let highscore = highscores[indexPath.row]
        cell.textLabel?.text = highscore.name
        cell.detailTextLabel?.text = String(highscore.score)
        return cell
    }
}
