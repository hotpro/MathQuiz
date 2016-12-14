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
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var operandLabel1: UILabel!
    @IBOutlet weak var operandLabel2: UILabel!
    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var numberText1: UITextField!
    
    var operatorType: Int!
    var questionId: Int!
    var operand1: Int!
    var operand2: Int!
    var expectedAns: Int!
    var correctAnswerCnt: Int!
    var counter: Int!
    var timer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if operatorType == 0 {
            operatorLabel.text = "+"
        } else if operatorType == 1 {
            operatorLabel.text = "-"
        } else if operatorType == 2 {
            operatorLabel.text = "*"
        }
        
        let line = UIView(frame: CGRect(x: 110, y: 230, width: 150, height: 1))
        line.backgroundColor = UIColor.black
        self.view.addSubview(line)
        
        numberText1.textAlignment = .right
        
        // Do any additional setup after loading the view.
        initKeyboard()
        
        // init question
        questionId = 0
        correctAnswerCnt = 0
        counter = 0
        

        generateQuestion()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func timerUpdate() {
        if(counter < 5) {
            counter = counter + 1
        }
        else {
            alertAnswerCorrectness(msg: "Wrong!!!")
        }
    }
    
    func generateQuestion() {
        if (questionId == 10) {
            let scoreAlert = UIAlertController(title: "", message: "Score: " + String(correctAnswerCnt) + "/10", preferredStyle: .alert)
            let returnAction = UIAlertAction(title:"Return", style:.default) { action -> Void in
                self.dismiss(animated: true, completion: nil)
                self.returnHome()
            }
            scoreAlert.addAction(returnAction)
            present(scoreAlert, animated: true, completion: nil)
            
            questionId = 0
            correctAnswerCnt = 0
            
            return
        }
        
        questionId = questionId + 1
        operand1 = Int(arc4random_uniform(10))
        operand2 = Int(arc4random_uniform((UInt32(operand1) + 1)))
        
        if operatorType == 0 {
            expectedAns = operand1 + operand2
        } else if operatorType == 1 {
            expectedAns = operand1 - operand2
        } else if operatorType == 2 {
            expectedAns = operand1 * operand2
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
        
        questionLabel.text = "Question " + String(questionId) + "/10"
        operandLabel1.text = String(operand1)
        operandLabel2.text = String(operand2)
        numberText1.text = ""

    }
    
    func returnHome() {
//        performSegue(withIdentifier: "return")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "return" {
            let vc:ViewController = segue.destination as! ViewController
            
        }
    }

    
    func alertAnswerCorrectness(msg: String) {
        let ansAlert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        present(ansAlert, animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
        
        timer.invalidate()
        counter = 0
        self.generateQuestion()
        
    }
    
    func initKeyboard() {
        
        let keyboardView = Keyboard(frame: CGRect(x: 0, y: self.view.frame.height - 300, width: self.view.frame.width, height: 300))
        
        keyboardView.delegate = self
        
        self.view.addSubview(keyboardView)
        
    }
    
    func keyWasTapped(_ character: String) {
//        numberText1.insertText(character)

        numberText1.text = numberText1.text! + character
        let ans = (Int)(numberText1.text!)
        if (ans == expectedAns) {
            correctAnswerCnt = correctAnswerCnt + 1
            alertAnswerCorrectness(msg: "Correct!!!")
        }
    }
    
    func backspace() {
//        numberText1.deleteBackward()

        var str = numberText1.text!
        var len = str.characters.count
        if (len > 0) {
            let index = str.index(str.startIndex, offsetBy: len - 1)
            numberText1.text = str.substring(to: index)  // Hello

        }
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
