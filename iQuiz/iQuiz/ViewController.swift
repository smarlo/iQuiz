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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

