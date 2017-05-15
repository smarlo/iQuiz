//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Sabrina Niklaus on 5/3/17.
//  Copyright © 2017 Sabrina Niklaus. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    var questions = [String: [(String, String)]]()
    var answers = [String: [[String]]]()
    var currentQuestion = ""
    var questionIndex = 0
    var correct = 0
    var selectedAnswer = ""
    var correctAnswer = ""
    var subject = "" 
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var correctLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        questionLabel.text = "Question: \n \(currentQuestion)"
        answerLabel.text = "Answer: \n \(correctAnswer)"
        
        if correctAnswer == selectedAnswer {
            correctLabel.text = "You answered correct :)"
            correct += 1
        } else {
            correctLabel.text = "You answered incorrect :("
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func nextClicked(_ sender: UIButton) {
        if questionIndex < (questions[subject]?.count)! - 1 {
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
            fvc.total = (questions[subject]?.count)!
        } else {
            let qvc = segue.destination as! QuestionViewController
            qvc.questions = questions
            qvc.answers = answers
            qvc.questionIndex = questionIndex
            qvc.subject = subject
            qvc.correct = correct
        }
    }

}
