//
//  ViewController.swift
//  FinalProject Questionnaire App
//
//  Created by Gurjeet KJ on 03/07/21.
//  Copyright © 2021 Gurjeet KJ. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox


class ViewController: UIViewController {
 
    
        
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var correctIncorrectMsg: UILabel!
    @IBOutlet weak var firstChoiceBtn: UIButton!
    @IBOutlet weak var secondChoiceBtn: UIButton!
    @IBOutlet weak var thirdChoiceBtn: UIButton!
    @IBOutlet weak var fourthChoiceBtn: UIButton!
    @IBOutlet weak var nextQuestionBtn: UIButton!
    
    var questionList = [Question]()
    var previouslyUsedNumbers: [Int] = []
    let score = Score()
    let numberOfQuestionPerRound = 5
    var currentQuestion: Question? = nil
    var gameStartSound: SystemSoundID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filldata()
        loadGameStartSound()
        playGameStartSound()
        displayQuestion()
    }
    
    func filldata(){
       questionList.append(Question(questionTitle: "Who is the prime minister of Canada?", answers: ["Joe Bidden", "Justin Trudeau", "Imran Khan", "Boris Johnson"], correctAnswerIndex: 1))
        questionList.append(Question(questionTitle: "Which one is the most populated country?", answers: ["China", "India", "Jordan", "Oman"], correctAnswerIndex: 0))
        questionList.append(Question(questionTitle: "Tower of Pisa is in which country?", answers: ["India", "Italy", "USA", "Turkey"], correctAnswerIndex: 1))
        questionList.append(Question(questionTitle: "Where Eiffel Tower is located?", answers: ["England", "Amsterdam", "Rome", "Paris"], correctAnswerIndex: 3))
        questionList.append(Question(questionTitle: "Which country is completely surronded by sea?", answers: ["Afganistan", "Iran", "Australia", "Denmark"], correctAnswerIndex: 2))
        questionList.append(Question(questionTitle: "What is the capital of Canada?", answers: ["Ottawa", "Toronto", "Montreal", "Vancouver"], correctAnswerIndex: 0))
        questionList.append(Question(questionTitle: "Who is the prime minister of New Zealand in 2021?", answers: ["Nicola Sturgeon", "Donald Trumph", "Jacinda Ardern", "Boris Johnson"], correctAnswerIndex: 2))
        questionList.append(Question(questionTitle: "Which is world's largest country by area?", answers: ["Russia", "Canada", "India", "UK"], correctAnswerIndex: 0))
        questionList.append(Question(questionTitle: "Which is world's smallest country?", answers: ["UK", "Vatican City", "Iraq", "Jordan"], correctAnswerIndex: 1))
        questionList.append(Question(questionTitle: "Sahara desert is in which country?", answers: ["Iraq", "Iran", "India", "North Africa"], correctAnswerIndex: 3))        
    }
    

   func getRandomQuestion() -> Question {
             
             if (previouslyUsedNumbers.count == questionList.count) {
                 previouslyUsedNumbers = []
             }
             var randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: questionList.count)
             
             // Picking a new random number if the previous one has been used
             while (previouslyUsedNumbers.contains(randomNumber)) {
                 randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: questionList.count)
             }
             previouslyUsedNumbers.append(randomNumber)
             
             return questionList[randomNumber]
    }
    
     
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func isGameOver() -> Bool {
        return score.numberOfQuestionsAsked() >= numberOfQuestionPerRound

    }
    
    func displayQuestion() {
       currentQuestion = getRandomQuestion()
        if let question = currentQuestion {
            let choices = question.getChoices()
            
            questionText.text = question.getQuestionTitle()
            firstChoiceBtn.setTitle(choices[0], for: .normal)
            secondChoiceBtn.setTitle(choices[1], for: .normal)
            thirdChoiceBtn.setTitle(choices[2], for: .normal)
            fourthChoiceBtn.setTitle(choices[3], for: .normal)
            
            if (score.numberOfQuestionsAsked() == numberOfQuestionPerRound - 1) {
                nextQuestionBtn.setTitle("End Quiz", for: .normal)
            } else {
                nextQuestionBtn.setTitle("Next Question", for: .normal)
            }
        }
        
        firstChoiceBtn.isEnabled = true
        secondChoiceBtn.isEnabled = true
        thirdChoiceBtn.isEnabled = true
        fourthChoiceBtn.isEnabled = true

        firstChoiceBtn.isHidden = false
        secondChoiceBtn.isHidden = false
        thirdChoiceBtn.isHidden = false
        fourthChoiceBtn.isHidden = false
        correctIncorrectMsg.isHidden = true

        nextQuestionBtn.isEnabled = false
    }
    
   
    
    @IBAction func checkAnswer(_ sender: UIButton) {
       if let question = currentQuestion, let answer = sender.titleLabel?.text {
            if (question.validateAnswer(to: answer)) {
                score.incrementCorrectAnswers()
                correctIncorrectMsg.textColor = UIColor(red:0.15, green:0.61, blue:0.61, alpha:1.0)
                correctIncorrectMsg.text = "Correct!"
            } else {
                score.incrementIncorrectAnswers()
                correctIncorrectMsg.textColor = UIColor(red:0.82, green:0.40, blue:0.26, alpha:1.0)
                correctIncorrectMsg.text = "Sorry, that's not it."
            }
            firstChoiceBtn.isEnabled = false
            secondChoiceBtn.isEnabled = false
            thirdChoiceBtn.isEnabled = false
            fourthChoiceBtn.isEnabled = false
            nextQuestionBtn.isEnabled = true
            
            correctIncorrectMsg.isHidden = false
        }
    }
   
    
    @IBAction func nextQuestionBtnClick(_ sender: Any) {
        if (isGameOver()) {
            displayScore()
        } else {
            displayQuestion()
        }
    }
  
    
    func displayScore() {
        questionText.text = score.getScore()
        score.reset()
        nextQuestionBtn.setTitle("Start again", for: .normal)
        correctIncorrectMsg.isHidden = true
        firstChoiceBtn.isHidden = true
        secondChoiceBtn.isHidden = true
        thirdChoiceBtn.isHidden = true
        fourthChoiceBtn.isHidden = true
    }
    
    
    func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "play", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameStartSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameStartSound)
    }

}

