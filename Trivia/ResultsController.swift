//
//  ResultController.swift
//  Trivia
//
//  Created by Fabian de Moel on 17/03/2019.
//  Copyright © 2019 Fabian de Moel. All rights reserved.
//

import Foundation

class ResultsController {
    
    static let shared = ResultsController()
    
    let baseUrl = URL(string: "https://ide50-a10778403.legacy.cs50.io:8080/highscores")!
    
    func fetchHighscores(completion: @escaping ([Score]?) -> Void) {
        
        // Decoding data
        let task = URLSession.shared.dataTask(with: baseUrl)
        { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let scores = try? jsonDecoder.decode(HighscoreList.self, from: data) {
                completion(scores.highscores)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    

        // Add new score
        // curl http://ide50-a10778403.legacy.cs50.io:8080/highscores -d "name=score.userName&score=score.score" -X POST
    
    func addScore(forScore score: [String: Any], completion: @escaping (Score?) -> Void) {
        var request = URLRequest(url: baseUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Score
        let data: [String: Any] = score
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        request.httpBody = jsonData
        
        // Submit Score
        let task = URLSession.shared.dataTask(with: request) { (data,
            response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let score = try?
                    jsonDecoder.decode(Score.self, from: data) {
                completion(score)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
