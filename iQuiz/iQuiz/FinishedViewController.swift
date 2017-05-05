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
        finalScoreLabel.text = "You finished! \n You got \(correct) out of \(total) correct!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
