//
//  ViewController.swift
//  MathQuiz
//
//  Created by Yutao Hou on 10/11/16.
//  Copyright © 2016 Yutao Hou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // 1. create only one segue
    // 2. Rename this file
    
    // MARK: Outlets
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var subButton: UIButton!
    @IBOutlet weak var multiButton: UIButton!
    
    // MARK: Actions
    @IBAction func takeQuiz(_ sender: UIButton) {
        performSegue(withIdentifier: "takeQuiz", sender: sender)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "takeQuiz" {
            let vc:QuizViewController = segue.destination as! QuizViewController
            let senderButton = sender as! UIButton
            if senderButton == addButton {
                vc.operatorType = 0
            } else if senderButton == subButton {
                vc.operatorType = 1
            } else if senderButton == multiButton {
                vc.operatorType = 2
            }
        }
    }

}

