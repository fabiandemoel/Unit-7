//
//  Answers.swift
//  Trivia
//
//  Created by Fabian de Moel on 15/03/2019.
//  Copyright © 2019 Fabian de Moel. All rights reserved.
//

import Foundation

struct Answers {
    var correctAnswers: Int
    var correctEasy: Int
    var correctMedium: Int
    var correctHard: Int
    
    func calculateScore() -> Int {
        let score = self.correctEasy * 10 + self.correctMedium * 20 + self.correctHard * 35
        return score
    }
}
