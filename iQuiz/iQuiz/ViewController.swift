//
//  ViewController.swift
//  iQuiz
//
//  Created by Sabrina Niklaus on 4/27/17.
//  Copyright © 2017 Sabrina Niklaus. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    struct Subject {
        let name: String
        let image: UIImage
        let description: String
    }
    
    let subjects: [Subject] = [
        Subject(name: "Mathematics", image: #imageLiteral(resourceName: "math"), description: "1 + 1 = 2"),
        Subject(name: "Marvel Super Heroes", image: #imageLiteral(resourceName: "marvel"), description: "There aren't enough movies!"),
        Subject(name: "Science", image: #imageLiteral(resourceName: "science"), description: "f = ma")
    ]
    
    let questions = ["What is fire?", "Who is Iron Man?", "Who founded the x-men?", "How did Spider-Man get his powers?", "What is 2 + 2?"]
    
    let options = [
        ["One of the four classical elements",
         "A magical reaction given to us by God",
         "A band that hasn't yet been discovered",
         "Fire! Fire! Fire! heh-heh"],
        ["Tony Stark",
         "Obadiah Stane",
         "A rock hit by Megadeth",
         "Nobody knows"],
        ["Tony Stark",
         "Professor X",
         "The X-Institute",
         "Erik Lensherr"],
        ["He was bitten by a radioactive spider",
         "He ate a radioactive spider",
         "He is a radioactive spider",
         "He looked at a radioactive spider"],
        ["4",
         "22",
         "An irrational number",
         "Nobody knows"]
    ]
    
    let answers = ["1", "1", "2", "1", "1"]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = subjects[indexPath.row].name
        cell.detailTextLabel?.text = subjects[indexPath.row].description
        cell.imageView?.image = subjects[indexPath.row].image
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
    }
    
    @IBAction func settingsPressed(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: "Settings go here", preferredStyle: UIAlertControllerStyle.actionSheet)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! QuestionViewController
        vc.questions = questions
        vc.options = options
        vc.answers = answers
        vc.questionIndex = 0
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

