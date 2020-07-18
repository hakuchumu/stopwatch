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
    @IBOutlet weak var timerMsec: UILabel!
    
    weak var timer: Timer!
    var startTime = Date()
       
    override func viewDidLoad() {
       super.viewDidLoad()
        
        //ラベルと画面全体の背景色設定
        self.view.backgroundColor = #colorLiteral(red: 0.2128436267, green: 0.646464169, blue: 0.6198984981, alpha: 1)
        timerMinute.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        timerSecond.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        timerMsec.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
   }

    @IBAction func startTimer(_ sender: Any) {
        // timerが起動中なら一旦破棄する
        if timer != nil{
            timer.invalidate()
        }
        
        timer = Timer.scheduledTimer(
            timeInterval: 0.01,
            target: self,
            selector: #selector(self.timerCounter),
            userInfo: nil,
            repeats: true)
       
       startTime = Date()
    }
       
    @IBAction func stopTimer(_ sender: Any) {
        
        if timer != nil{
            timer.invalidate()

            timerMinute.text = "00"
            timerSecond.text = "00"
            timerMsec.text = "00"
        }
    }
       
    @objc func timerCounter() {
           // タイマー開始からのインターバル時間
           let currentTime = Date().timeIntervalSince(startTime)
           // fmod() 余りを計算
           let minute = (Int)(fmod((currentTime/60), 60))
           // currentTime/60 の余り
           let second = (Int)(fmod(currentTime, 60))
           // floor 切り捨て、小数点以下を取り出して *100
           let msec = (Int)((currentTime - floor(currentTime))*100)
           
           // %02d： ２桁表示、0で埋める
           let sMinute = String(format:"%02d", minute)
           let sSecond = String(format:"%02d", second)
           let sMsec = String(format:"%02d", msec)
           
           timerMinute.text = sMinute
           timerSecond.text = sSecond
           timerMsec.text = sMsec
        
    }
       
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(true)
           timer.invalidate()
    }


}

