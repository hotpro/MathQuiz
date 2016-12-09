//
//  QuizViewController.swift
//  MathQuiz
//
//  Created by Yutao Hou on 10/11/16.
//  Copyright © 2016 Yutao Hou. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController, KeyboardDelegate {
    // MARK: Properties
    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var numberText1: UITextField!
    
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
        initKeyboard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initKeyboard() {
        
        let keyboardView = Keyboard(frame: CGRect(x: 0, y: self.view.frame.height - 300, width: self.view.frame.width, height: 300))
        
        keyboardView.delegate = self
        
        self.view.addSubview(keyboardView)
        
    }
    
    func keyWasTapped(_ character: String) {
        numberText1.insertText(character)
    }
    
    func backspace() {
        numberText1.deleteBackward()
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
