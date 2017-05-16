//
//  ViewController.swift
//  iQuiz
//
//  Created by Sabrina Niklaus on 4/27/17.
//  Copyright © 2017 Sabrina Niklaus. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var url = "http://tednewardsandbox.site44.com/questions.json"
    var subjects: [String] = []
    var descriptions: [String] = []
    let icons: [UIImage] = [#imageLiteral(resourceName: "science"), #imageLiteral(resourceName: "marvel"), #imageLiteral(resourceName: "math")]
    var questions = [String: [(String, String)]]()
    var answers = [String: [[String]]]()
    var dataLoaded: Bool = false
    
    var refreshController : UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshController = UIRefreshControl()
        refreshController.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshController.addTarget(self, action: Selector("refresh"), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshController)
        
        DispatchQueue.global().async {
            self.getQuizzes()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    func refresh() {
        getQuizzes()
        refreshController?.endRefreshing()
    }
    
    func getQuizzes() {
        self.subjects = []
        let urlString: URL = URL(string: url)!
        URLSession.shared.dataTask(with: urlString) { (data, response, error) in
            if error != nil {
                print(error!)
                
                let savedJson = UserDefaults.standard
                if (savedJson.value(forKey: "savedJson") != nil) {
                    let json = savedJson.value(forKey: "savedJson") as! [[String: Any]]
                    for section in json {
                        print(section)
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

                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String:Any]]
                    
                    // local storage
                    let localStorage = UserDefaults.standard
                    localStorage.set(json, forKey: "savedJson")
                    localStorage.synchronize()
                    
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
                    self.dataLoaded = true
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
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
        if self.dataLoaded {
        cell.textLabel?.text = subjects[indexPath.row]
        cell.detailTextLabel?.text = descriptions[indexPath.row]
        cell.imageView?.image = icons[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
    }
    
    @IBAction func settingsPressed(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Settings", message: "Enter a url to retrieve quizzes from", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .default)
        alertController.addAction(cancel)
        alertController.addTextField { (textField) in
            textField.text = self.url
        }
        alertController.addAction(UIAlertAction(title: "Check Now", style: .default, handler: { (_) in
            self.url = alertController.textFields![0].text!
            self.getQuizzes()
        }))
        self.present(alertController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! QuestionViewController
        let selected = self.tableView.indexPathForSelectedRow!
        let subject = subjects[selected[1]]
        vc.subject = subject 
        vc.questions = questions
        vc.answers = answers
        vc.questionIndex = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

