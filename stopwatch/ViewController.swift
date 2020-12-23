//
//  ViewController.swift
//  stopwatch
//
//  Created by Nakata chisato on 2020/07/03.
//  Copyright © 2020 Ajima. All rights reserved.
//

import UIKit

/*
 外部から参照される想定をしていないクラスやインスタンスの
 メソッド・プロパティには必ずアクセス修飾子をつける（privateなど）
 パッとみた時にprivateなどがついていることによって外部から内部でしか使わない関数なんだなとかがわかるようになる。
 */

class ViewController: UIViewController {
    
    @IBOutlet weak var timerMinute: UILabel!
    @IBOutlet weak var timerSecond: UILabel!
    @IBOutlet weak var deliName: UITextField!
    @IBAction func addButton(_ sender: Any) {
        //ボタン押下時に文字列が存在しない場合を考えてコード足す
        print(deliName.text)
    }
    
    //カスタムボタンを適用
    @IBOutlet weak var startOrStopButton: StateToggleButton!
    
    /*
     Timerはnilをセットしている部分がなさそうなのでリセットする時は必ずリセットを行うようにする。！だとnilが入っているかの意識をすることを忘れてしまうため?に変更
     */
    
    private var timer: Timer?
    
    private var startTime = Date()
    private var totalTime = 0.1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ラベルと画面全体の背景色設定
        self.view.backgroundColor = #colorLiteral(red: 0.2128436267, green: 0.646464169, blue: 0.6198984981, alpha: 1)
        timerMinute.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        timerSecond.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        deliName.delegate = self
    }
    
    //viewWillDisappearビューがビュー階層から削除されることをビューコントローラーに通知
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        //画面が切り替わる前に、もし現在timerが存在している場合にはTimerを破棄してから
        timer?.invalidate()
    }
    
    //TextFieldでEnterが押下されたらキーボードを格納
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func startTimer() {
        startTime = Date()
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(self.timerCounter),
            userInfo: nil,
            repeats: true)
    }
    
    private func displayTime(_ time: TimeInterval) {
        let minute = (Int)(fmod((time/60), 60))
        let second = (Int)(fmod(time, 60))
        
        timerMinute.text = String(format:"%02d", minute)
        timerSecond.text = String(format:"%02d", second)
    }
    
    @objc func timerCounter() {
        let currentTime = totalTime + Date().timeIntervalSince(startTime)
        displayTime(currentTime)
    }
    
    
    @IBAction func StateToggleButtonDidTapped(_ sender: StateToggleButton) {
        
        //senderは押されたボタンのインスタンス
        switch sender.buttonState {
        case .start, .reStart:
            //StartおよびreStartの時はTimerはnilで実行されていないので分岐は必要がなくなる。
            startTimer()
            
        case .stop:
            //Stop押す時には絶対にTimerは動いているはずなのでnilじゃなかったらの分岐はいらない。
            totalTime += Date().timeIntervalSince(startTime)
            removeTimer()
        }
        //ボタンタイプとテキストの切り替え
        sender.toggleAction()
        
    }    
    
    @IBAction func resetButton(_ sender: Any) {
        removeTimer()
        startTime = Date()
        totalTime = 0.0
        displayTime(totalTime)
        startOrStopButton.buttonState = .start
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        deliName.text = textField.text
        return true
    }
}
