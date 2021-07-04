//
//  Question.swift
//  FinalProject Questionnaire App
//
//  Created by Gurjeet KJ on 03/07/21.
//  Copyright © 2021 Gurjeet KJ. All rights reserved.
//

import Foundation

class Question {
  
     let questionTitle: String
     let answers: [String]
     let correctAnswerIndex: Int
   
    
    init(questionTitle: String, answers: [String], correctAnswerIndex: Int) {
        self.questionTitle = questionTitle
        self.answers = answers
        self.correctAnswerIndex = correctAnswerIndex
    }
    
    
    func validateAnswer(to givenAnswer: String) -> Bool {
        return (givenAnswer == answers[correctAnswerIndex])
    }
    
    func getQuestionTitle() -> String {
        return questionTitle
    }
    
    func getAnswer() -> String {
        return answers[correctAnswerIndex]
    }
    
    func getChoices() -> [String] {
        return answers
    }
    
    func getAnswerAt(index: Int) -> String {
        return answers[index]
    }
}


class Score{
    
    fileprivate var correctAnswers: Int = 0
    fileprivate var incorrectAnswers: Int = 0
    var questionPerRound = 5
    func reset() {
        correctAnswers = 0
        incorrectAnswers = 0
    }

    func incrementCorrectAnswers() {
        correctAnswers += 1
    }
    
    func incrementIncorrectAnswers() {
        incorrectAnswers += 1
    }
    
   func numberOfQuestionsAsked() -> Int {
        return correctAnswers + incorrectAnswers
    }
    
    func getScore() -> String {
        if (correctAnswers == 5) {
            return "You are a genius!\n\n Your score \(correctAnswers) out of \(questionPerRound) !"
        } else if (correctAnswers == 4) {
            return "Excellent Work!\n\n Your score \(correctAnswers) out of \(questionPerRound) !"
        }else if (correctAnswers == 3) {
            return "Good Job!\n\n Your score \(correctAnswers) out of \(questionPerRound) !"
        } else {
            return "Please Try Again!\n\n You got \(correctAnswers) out of \(questionPerRound) !"
        }
    }
}


