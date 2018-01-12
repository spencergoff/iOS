//
//  ViewController.swift
//  Quiz
//
//  Created by Spencer Goff on 5/9/17.
//  Copyright © 2017 Spencer Goff. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    
    
    let questions: [String] = ["From what is cognac made?",
                               "What is 7 + 7?",
                               "What is the capital of Vermont?"]
    
    let answers: [String] = ["Grape",
                             "14",
                             "Montpelier"]
    
    var currentQuestionIndex: Int = 0
    
    @IBAction func showAnswer(sender: AnyObject)
    {
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    
    @IBAction func showNextQuestion(sender: AnyObject)
    {
        currentQuestionIndex += 1
        if(currentQuestionIndex == questions.count)
        {
            currentQuestionIndex = 0
        }
        let question: String = questions[currentQuestionIndex]
        currentQuestionLabel.text = question
        //nextQuestionLabel.text = question
        answerLabel.text = "???"
        //animateLabelTransitions()
    }
    
    func animateLabelTransitions() {
        let space1 = UILayoutGuide()
        let space2 = UILayoutGuide()
        view.layoutIfNeeded() //force any remaining layout changes to occur first
        
        view.addLayoutGuide(space1)
        view.addLayoutGuide(space2)
        
        space1.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        space2.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        currentQuestionLabel.trailingAnchor.constraint(equalTo: space1.leadingAnchor).isActive = true
        nextQuestionLabel.leadingAnchor.constraint(equalTo: space1.trailingAnchor).isActive = true
        nextQuestionLabel.trailingAnchor.constraint(equalTo: space2.leadingAnchor).isActive = true
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveLinear], animations: { //fade questions in/out and move labels right
            self.currentQuestionLabel.alpha = 0
            self.nextQuestionLabel.alpha = 1
            self.view.layoutIfNeeded() //updates frames as needed
        },
        completion: {_ in swap(&self.currentQuestionLabel,
                               &self.nextQuestionLabel)
            swap(&self.currentQuestionLabelCenterXConstraint, &self.nextQuestionLabelCenterXConstraint) //rotates question labels
            //self.updateOffScreenLabel()
        })
    }
    
    func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
        //nextQuestionLabel.leadingAnchor.constraint(equalTo: space1.trailingAnchor).isActive = true
        //nextQuestionLabel.trailingAnchor.constraint(equalTo: space2.leadingAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) { //executes each time view comes onscreen
        super.viewWillAppear(animated)
        //nextQuestionLabel.alpha = 0 //quesion is initially invisible until animateLabelTransitions fades it in
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestionLabel.text = questions[currentQuestionIndex]
        //updateOffScreenLabel()
    }
}





























