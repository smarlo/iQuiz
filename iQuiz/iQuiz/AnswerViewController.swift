//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Sabrina Niklaus on 5/3/17.
//  Copyright © 2017 Sabrina Niklaus. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    var questions: [String] = [""]
    var options: [[String]] = [[""]]
    var answers: [String] = [""]
    var questionIndex = 0
    var correct = 0
    var selectedAnswer = ""
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var correctLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let correctIndex = Int(answers[questionIndex])! - 1
        let currentOptions = options[questionIndex]
        questionLabel.text = "Question: \n \(questions[questionIndex])"
        answerLabel.text = "Answer: \n \(currentOptions[correctIndex])"
        
        if currentOptions[correctIndex] == selectedAnswer {
            correctLabel.text = "You answered correct :)"
            correct += 1
        } else {
            correctLabel.text = "You answered incorrect :("
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func nextClicked(_ sender: UIButton) {
        if questionIndex < questions.count - 1 {
            questionIndex += 1
            performSegue(withIdentifier: "QuestionSegue", sender: self)
        } else {
            performSegue(withIdentifier: "FinishedSegue", sender: self)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "FinishedSegue") {
            let fvc = segue.destination as! FinishedViewController
            fvc.correct = correct
            fvc.total = questions.count
        } else {
            let qvc = segue.destination as! QuestionViewController
            qvc.questions = questions
            qvc.options = options
            qvc.answers = answers
            qvc.questionIndex = questionIndex
            qvc.correct = correct
        }
    }

}
