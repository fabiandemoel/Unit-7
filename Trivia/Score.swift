//
//  Score.swift
//  Trivia
//
//  Created by Fabian de Moel on 27/02/2019.
//  Copyright © 2019 Fabian de Moel. All rights reserved.
//

import Foundation

struct Score: Codable {
    var id: Int
    var name: String
    var score: String
}

// List of Scores

struct HighscoreList: Codable {
    var highscores: [Score]

    static func loadSampleHighscores() -> [Score] {
        let list = [Score(id: 1, name: "John", score: "10"),
                    Score(id: 2, name: "Hank", score: "50"),
                    Score(id: 3, name: "Linda", score: "100")]
        return list
    }
}

struct List: Codable {
    var id: Int
}
