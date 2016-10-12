//
//  QuizViewController.swift
//  MathQuiz
//
//  Created by Yutao Hou on 10/11/16.
//  Copyright © 2016 Yutao Hou. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var operatorLabel: UILabel!
    
    
    
    
    var operatorType: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if operatorType == 0 {
            operatorLabel.text = "+"
        } else if operatorType == 1 {
            operatorLabel.text = "-"
        } else if operatorType == 2 {
            operatorLabel.text = "*"
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
