//
//  Trivia.swift
//  Trivia
//
//  Created by Fabian de Moel on 06/03/2019.
//  Copyright © 2019 Fabian de Moel. All rights reserved.
//

import Foundation

class TriviaController {
    
    let baseUrl = URL(string: "https://opentdb.com/api.php?")!
    
    static let shared = TriviaController()
    
    let questionsUrl = URL(string: "https://opentdb.com/api.php?amount=10")!
    
    // Extended URL = "https://opentdb.com/api.php?amount=10&category=11&difficulty=easy&type=multiple"
    // URL Variables:
    //  var amount: Int (max 50)
    //  var category: Int
    //  var difficulty: String(easy/medium/hard)
    //  var type: String (multiple/boolean)
    
    
    // GET questions
    func fetchQuestions(completion: @escaping ([Question]?) -> Void) {
        // Decoding data
        let task = URLSession.shared.dataTask(with: questionsUrl)
        { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let questions = try? jsonDecoder.decode(Questions.self, from: data) {
                completion(questions.results)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }

    
    
    func categoryList() {
        // Category Lookup: Returns the entire list of categories and ids in the database.
        // https://opentdb.com/api_category.php
    }
    
    
    func categoryQuestionCount() {
        // Category Question Count Lookup: Returns the number of questions in the database, in a specific category.
        // https://opentdb.com/api_count.php?category=CATEGORY_ID_HERE
    }
    
    
    // Format result: {String: Int, String: [{String: Any}]}
    // {"response_code":0,"results":[{"category":"General Knowledge","type":"multiple","difficulty":"easy","question":"Virgin Trains, Virgin Atlantic and Virgin Racing, are all companies owned by which famous entrepreneur?   ","correct_answer":"Richard Branson","incorrect_answers":["Alan Sugar","Donald Trump","Bill Gates"]},{"category":"General Knowledge","type":"boolean","difficulty":"easy","question":"The Great Wall of China is visible from the moon.","correct_answer":"False","incorrect_answers":["True"]}]}
}


