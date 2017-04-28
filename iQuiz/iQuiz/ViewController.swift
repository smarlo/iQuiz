//
//  ViewController.swift
//  iQuiz
//
//  Created by Sabrina Niklaus on 4/27/17.
//  Copyright © 2017 Sabrina Niklaus. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    let quizzes = ["Mathematics", "Marvel Super Heroes", "Science"]
    
    @IBAction func settingsPressed(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: "Settings go here", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            // ...
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell?.textLabel?.text = quizzes[indexPath.row]
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

