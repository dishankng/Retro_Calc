//
//  ViewController.swift
//  Retro_Calc
//
//  Created by Dishank on 12/25/15.
//  Copyright © 2015 Dishank. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String{
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var Screen: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var result = ""
    var operand1: String = ""
    var operand2: String = ""
    var currentOperation: Operation = Operation.Empty
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do{
            
        try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)       //Use 'try' in a do loop when throw error is shown
            btnSound.prepareToPlay()
            
        } catch let err as NSError{
            print(err.debugDescription)
        }
    }


    @IBAction func numberPressed(btn: UIButton!){
        playSound()
        
        runningNumber += "\(btn.tag)"
        Screen.text = runningNumber
        
    }

    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }

    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }

    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }

    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }

    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
//        currentOperation = Operation.Empty
    }

    @IBAction func onClearPressed(sender: AnyObject) {
        playSound()
        runningNumber = ""
        operand1 = ""
        operand2 = ""
        result = ""
        currentOperation = Operation.Empty
        Screen.text = "0.0"
    }
    
    func processOperation(op: Operation){
        playSound()
        
        
        
        if currentOperation != Operation.Empty{
            
            if runningNumber != ""{
                operand2 = runningNumber
                runningNumber = ""
                
            switch currentOperation {
            case Operation.Divide : result = "\(Double(operand1)! / Double(operand2)!)"
            
            case Operation.Multiply : result = "\(Double(operand1)! * Double(operand2)!)"
            
            case Operation.Subtract: result = "\(Double(operand1)! - Double(operand2)!)"
                
            case Operation.Add : result = "\(Double(operand1)! + Double(operand2)!)"
                
                
            default:    result = ""
            }
            
            operand1 = result
            Screen.text = result
         }
            
            currentOperation = op
            
        } else{
            operand1 = runningNumber
            runningNumber = ""
            currentOperation = op
            
        }
        
        
    }
    
    func playSound(){
        if btnSound.playing{
            btnSound.stop()
        }
        btnSound.play()
    }
    
    


}





