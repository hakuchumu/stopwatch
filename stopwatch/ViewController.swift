//
//  ViewController.swift
//  stopwatch
//
//  Created by Nakata chisato on 2020/07/03.
//  Copyright © 2020 Ajima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
       
    @IBOutlet weak var timerMinute: UILabel!
    @IBOutlet weak var timerSecond: UILabel!
    
    @IBOutlet weak var startOrStopButton: UIButton!
    
    weak var timer: Timer!
    var startTime = Date()
    var totalTime = 0.0
       
    override func viewDidLoad() {
       super.viewDidLoad()
        //ラベルと画面全体の背景色設定
        self.view.backgroundColor = #colorLiteral(red: 0.2128436267, green: 0.646464169, blue: 0.6198984981, alpha: 1)
        timerMinute.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        timerSecond.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        timer.invalidate()
    }

    @IBAction func startOrStopButton(_ sender: Any) {
         
        if startOrStopButton.titleLabel?.text == "Start" {
            
             if timer != nil{
                
                timer.invalidate()
             } else {
                startTime = Date();
             }
             
             timer = Timer.scheduledTimer(
                 timeInterval: 1,
                 target: self,
                 selector: #selector(self.timerCounter),
                 userInfo: nil,
                 repeats: true)
            
            startOrStopButton.setTitle("Stop", for: .normal)
            
        } else if startOrStopButton.titleLabel?.text == "Stop" {
            
             if timer != nil {
                 totalTime += Date().timeIntervalSince(startTime)
                 timer.invalidate()
                 timer = nil
             }
             displayTime(totalTime)
            
            startOrStopButton.setTitle("Restart", for: .normal)
            
        } else if startOrStopButton.titleLabel?.text == "Restart" {
            
            if timer != nil {
                timer.invalidate()
            }
            else {
                startTime = Date();
            }
            timer = Timer.scheduledTimer(
                timeInterval: 0.01,
                target: self,
                selector: #selector(self.timerCounter),
                userInfo: nil,
                repeats: true)
            
            startOrStopButton.setTitle("Stop", for: .normal)
        }
    }
       
    @IBAction func resetButton(_ sender: Any) {
        timer.invalidate()
        startTime = Date();
        totalTime = 0.0
        displayTime(totalTime)
        startOrStopButton.setTitle("Start", for: .normal)
    }
       
     @objc func timerCounter() {
         let currentTime = totalTime + Date().timeIntervalSince(startTime)
         displayTime(currentTime)
     }
    
     func displayTime(_ time: TimeInterval) {
         let minute = (Int)(fmod((time/60), 60))
         let second = (Int)(fmod(time, 60))
    
         timerMinute.text = String(format:"%02d", minute)
         timerSecond.text = String(format:"%02d", second)
     }
    
}
