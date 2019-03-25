//
//  QuestionViewController.swift
//  Trivia
//
//  Created by Fabian de Moel on 04/03/2019.
//  Copyright © 2019 Fabian de Moel. All rights reserved.
//

import UIKit
import HTMLString

class QuestionViewController: UIViewController {
    
    
    // Outlets
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerButton0: UIButton!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var trueButton: UIButton!
    
    @IBOutlet weak var trueFalseStackView: UIStackView!
    @IBOutlet weak var multipleStackView: UIStackView!
    
    
    // Actions
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        switch sender {
        case answerButton0:
            answersChosen.append(currentAnswers[0])
        case answerButton1:
            answersChosen.append(currentAnswers[1])
        case answerButton2:
            answersChosen.append(currentAnswers[2])
        case answerButton3:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        nextQuestion()
    }
    
    @IBAction func trueFalseButtonPressed(_ sender: UIButton) {
        switch sender {
        case falseButton:
          answersChosen.append("False")
        case trueButton:
          answersChosen.append("True")
        default:
            break
        }
        nextQuestion()
    }
    
    
    // Variables
    var questionIndex = 0
    var currentAnswers: [String] = []
    
    var answersChosen: [String] = []
    var correctAnswers: [String] = []
    var questionDifficulty: [String] = []
    
        // Testing questions
    var questions: [Question] = [
        Question(category: "music",
                 type: "multiple",
                 difficulty: "easy",
                 question: "What was Prince?",
                 rightAnswer: "Awesome",
                 wrongAnswers: ["Not bad", "Okay", "Good"]),
        Question(category: "music",
                 type: "boolean",
                 difficulty: "easy",
                 question: "Did Jimi Hendrix play guitar?",
                 rightAnswer: "True",
                 wrongAnswers: ["False"])
    ]
    
    /// Functions
    
    // Initialize view
    override func viewDidLoad() {
        super.viewDidLoad()
        TriviaController.shared.fetchQuestions { (questions) in
            if let questions = questions{
                self.updateUI(with: questions)
            }
        }
    }

    func updateUI(with questions: [Question]) {
        DispatchQueue.main.async {
            self.questions = questions
            
            let index = self.questionIndex
            
            // Update titles
            self.navigationItem.title = "Question #\(index+1)"
            let currentQuestion = questions[index]
            let question = currentQuestion.question.removingHTMLEntities
            self.questionLabel.text = question
        
            self.currentAnswers = currentQuestion.wrongAnswers
            let answerIndex = index % 3
            if currentQuestion.type == "multiple" {
                self.currentAnswers.insert(currentQuestion.rightAnswer, at: answerIndex)
            }
        
            // Show relevant stack
            switch currentQuestion.type {
            case "boolean":
                self.updateTrueFalseStack()
            case "multiple":
                self.updateMultipleStack()
            default:
                break
            }
        }
    }
    
    func nextQuestion() {
        correctAnswers.append(questions[questionIndex].rightAnswer)
        questionDifficulty.append(questions[questionIndex].difficulty)
        
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI(with: self.questions)
        } else {
            performSegue(withIdentifier: "ResultSegue", sender: nil)
        }
    }
    
    func updateTrueFalseStack() {
        multipleStackView.isHidden = true
        trueFalseStackView.isHidden = false
        
    }
    
    func updateMultipleStack() {
        trueFalseStackView.isHidden = true
        multipleStackView.isHidden = false
        
        let answer0 = currentAnswers[0].removingHTMLEntities
        let answer1 = currentAnswers[1].removingHTMLEntities
        let answer2 = currentAnswers[2].removingHTMLEntities
        let answer3 = currentAnswers[3].removingHTMLEntities
        
        answerButton0.setTitle(answer0, for: .normal)
        answerButton1.setTitle(answer1, for: .normal)
        answerButton2.setTitle(answer2, for: .normal)
        answerButton3.setTitle(answer3, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultSegue" {
            var totalScore = 0
            let resultViewController = segue.destination as! ResultViewController
            for question in 0...questionIndex-1 {
                if answersChosen[question] == correctAnswers[question] {
                    switch questionDifficulty[question] {
                    case "easy":
                        totalScore += 10
                    case "medium":
                        totalScore += 20
                    case "hard":
                        totalScore += 35
                    default:
                        break
                    }
                }
            }
            resultViewController.score = totalScore
        }
    }
}
