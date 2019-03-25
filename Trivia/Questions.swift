//
//  Questions.swift
//  Trivia
//
//  Created by Fabian de Moel on 27/02/2019.
//  Copyright © 2019 Fabian de Moel. All rights reserved.
//

import Foundation

struct Question: Codable {
    var category: String
    var type: String
    var difficulty: String
    var question: String
    var rightAnswer: String
    var wrongAnswers: [String]
    
    enum CodingKeys: String, CodingKey {
        case category
        case type
        case difficulty
        case question
        case rightAnswer = "correct_answer"
        case wrongAnswers = "incorrect_answers"
    }
}

struct Questions: Codable {
    var response_code: Int
    var results: [Question]
}


    // {"response_code":0,"results":[{"category":"General Knowledge","type":"multiple","difficulty":"easy","question":"Virgin Trains, Virgin Atlantic and Virgin Racing, are all companies owned by which famous entrepreneur?   ","correct_answer":"Richard Branson","incorrect_answers":["Alan Sugar","Donald Trump","Bill Gates"]},{"category":"General Knowledge","type":"boolean","difficulty":"easy","question":"The Great Wall of China is visible from the moon.","correct_answer":"False","incorrect_answers":["True"]}]}
