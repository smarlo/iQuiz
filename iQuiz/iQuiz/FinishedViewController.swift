//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Sabrina Niklaus on 5/4/17.
//  Copyright © 2017 Sabrina Niklaus. All rights reserved.
//

import UIKit

class FinishedViewController: UIViewController {
    var correct = 0
    var total = 0
    
    @IBOutlet weak var finalScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let score = Double(correct) / Double(total)
        var description = "You finished"
        if score == 1 {
            description = "Perfect!"
        } else if score >= 0.8 {
            description = "Almost!"
        } else if score < 0.8 && score >= 0.6 {
            description = "Good Job!"
        } else {
            description = "Good Try!"
        }
        finalScoreLabel.text = "\(description) \n You got \(correct) out of \(total) correct!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
