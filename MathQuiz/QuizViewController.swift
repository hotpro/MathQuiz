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
    @IBOutlet weak var ansLabel: UILabel!
    
    var operatorType: Int!
    var questionId: Int!
    var operand1: Int!
    var operand2: Int!
    var expectedAns: Int!
    var correctAnswerCnt: Int!
    var counter: Int!
    var questionTimer:Timer!
    var ansTimer:Timer!
    
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
        
        
        // Do any additional setup after loading the view.
        initKeyboard()
        
        // init question
        questionId = 0
        correctAnswerCnt = 0
        counter = 0
        
        // generate the first question
        generateQuestion()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     * Xingxing:
     * Generate a new question, and update the UI
     * 1) Disable answer correctness timer
     * 2) If reaching 10 questions, alert the quiz score and return to quiz home page
     * 3) For a new question: set question id; generate two operands; set expected answer; set question timer; update UI
     */
    func generateQuestion() {
        if (ansTimer != nil) {
            ansTimer.invalidate()
        }
        
        if (questionId == 10) {
            let scoreAlert = UIAlertController(title: "", message: "Score: " + String(correctAnswerCnt) + " / 10", preferredStyle: .alert)

            let okAction = UIAlertAction(title:"OK", style:.default) { action -> Void in
                self.performSegue(withIdentifier: "returnHome", sender: self)
            }
            scoreAlert.addAction(okAction)
            present(scoreAlert, animated: true, completion: nil)

            questionId = 0
            correctAnswerCnt = 0
            
            return
        }
        
        questionId = questionId + 1
        operand1 = Int(arc4random_uniform(10))
        
        
        if operatorType == 0 {
            operand2 = Int(arc4random_uniform(10))
            expectedAns = operand1 + operand2
        } else if operatorType == 1 {
            operand2 = Int(arc4random_uniform((UInt32(operand1) + 1)))
            expectedAns = operand1 - operand2
        } else if operatorType == 2 {
            operand2 = Int(arc4random_uniform(10))
            expectedAns = operand1 * operand2
        }
        
        questionTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
        
        questionLabel.text = "Question " + String(questionId) + "/10"
        operandLabel1.text = String(operand1)
        operandLabel2.text = String(operand2)
        numberText1.text = ""
        ansLabel.text = ""

    }
    
    /*
     * Xingxing: 
     * update function for question timer
     */
    func timerUpdate() {
        if(counter < 5) {
            counter = counter + 1
        }
        else {
            alertAnswerCorrectness(msg: "Wrong :(")
        }
    }
    
    /*
     * Xingxing:
     * update function for answer timer
     */
    func answerUpdate() {
        ansLabel.text = ""
        self.generateQuestion()
    }
    
    
    /*
     * Xingxing:
     * alert the answer correctness; 
     * need timer to keep the correctness information visible to user for 1 seconds
     */
    func alertAnswerCorrectness(msg: String) {
        questionTimer.invalidate()
        counter = 0

        ansLabel.text = msg
        ansTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(answerUpdate), userInfo: nil, repeats:false)
        
    }
    
    func initKeyboard() {
        
        let keyboardView = Keyboard(frame: CGRect(x: 0, y: self.view.frame.height - 300, width: self.view.frame.width, height: 300))
        
        keyboardView.delegate = self
        
        self.view.addSubview(keyboardView)
        
    }
    
    
    /*
     * Xingxing:
     * process key event for number key
     * update the answer text display; 
     * check if it is correct answer already, if yes, trigger alert to show correctness and move to next question
     */
    func keyWasTapped(_ character: String) {
        numberText1.text = numberText1.text! + character
        let ans = (Int)(numberText1.text!)
        if (ans == expectedAns) {
            correctAnswerCnt = correctAnswerCnt + 1
            alertAnswerCorrectness(msg: "Correct :)")
        }
    }
    
    
    /*
     * Xingxing:
     * process key event for enter key
     * need to validate answer correctness and trigger the alert
     */
    func backspace() {
        let ans = (Int)(numberText1.text!)
        if (ans == expectedAns) {
            correctAnswerCnt = correctAnswerCnt + 1
            alertAnswerCorrectness(msg: "Correct :)")
        }
        else {
            alertAnswerCorrectness(msg: "Wrong :(")
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
