//
//  ViewController.swift
//  iQuiz
//
//  Created by Sabrina Niklaus on 4/27/17.
//  Copyright © 2017 Sabrina Niklaus. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var loaded: Bool = false
    let url = "http://tednewardsandbox.site44.com/questions.json"
    
    var subjects: [String] = []
    var descriptions: [String] = []
    let icons: [UIImage] = [#imageLiteral(resourceName: "science"), #imageLiteral(resourceName: "marvel"), #imageLiteral(resourceName: "math")]
    var questions = [String: [(String, String)]]()
    var answers = [String: [[String]]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getQuizzes()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func getQuizzes() {
        let urlString: URL = URL(string: url)!
        URLSession.shared.dataTask(with: urlString) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String:Any]]
                    for section in json {
                        let title = section["title"]! as! String
                        if let subjectQuestions = section["questions"] as? [[String:Any]] {
                            var quest: [(String,String)] = []
                            var ans: [[String]] = []
                            for val in subjectQuestions {
                                var array = val["answers"]! as! [String]
                                let answerIndex = Int(val["answer"]! as! String)! - 1
                                quest.append((val["text"]! as! String, array[answerIndex]))
                                ans.append(array)
                            }
                            self.questions[title] = quest
                            self.answers[title] = ans
                        }
                        self.subjects.append(title)
                        self.descriptions.append(section["desc"]! as! String)
                    }
                    self.loaded = true
                    self.tableView.reloadData()
                } catch {
                    print("error serializing JSON \(error)")
                }
            }
            }.resume()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if self.loaded {
            cell.textLabel?.text = subjects[indexPath.row]
            cell.detailTextLabel?.text = descriptions[indexPath.row]
            cell.imageView?.image = icons[indexPath.row]
        }
    
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
        let selected = self.tableView.indexPathForSelectedRow!
        let subject = subjects[selected[1]]
        vc.subject = subject 
        vc.questions = questions
        vc.answers = answers 
//        vc.questions = questions
//        vc.options = options
//        vc.answers = answers
        vc.questionIndex = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

