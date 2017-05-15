//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Sabrina Niklaus on 5/3/17.
//  Copyright © 2017 Sabrina Niklaus. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    var questions = [String: [(String, String)]]()
    var answers = [String: [[String]]]()
    var subject = ""
    
    var questionIndex: Int = 0
    var correct = 0
    var selectedAnswer = ""
    var answerButtons: [UIButton] = []
    
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var a4: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerButtons = [a1, a2, a3, a4]
        questionLabel.text = questions[subject]?[questionIndex].0
        for i in 0...3 {
            answerButtons[i].setTitle(answers[subject]?[questionIndex][i], for: UIControlState.normal)
        }
    }

    @IBAction func answerClicked(_ sender: UIButton) {
        selectedAnswer = sender.currentTitle!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // modifying questionIndex, passing correct answer
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier != "BackSegue") {
            let vc = segue.destination as! AnswerViewController
            vc.questions = questions
            vc.subject = subject 
            vc.answers = answers
            vc.questionIndex = questionIndex
            vc.correct = correct
            vc.selectedAnswer = selectedAnswer
            vc.correctAnswer = (questions[subject]?[questionIndex].1)!
            vc.currentQuestion = (questions[subject]?[questionIndex].0)!
        } 
    }
    

}
