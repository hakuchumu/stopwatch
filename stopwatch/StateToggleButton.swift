//
//  StateToggleButton.swift
//  stopwatch
//
//  Created by 吉澤翔吾 on 2020/07/22.
//  Copyright © 2020 Ajima. All rights reserved.
//

import UIKit

enum ButtonState: String {
    case start = "Start"
    case stop = "Stop"
    case reStart = "ReStart"
}

class StateToggleButton: UIButton {
    
    /*
     初期値はスタートボタンタイプ
     変数buttonStateに値がセットされるたびにボタンのテキストを変更
     */

    var buttonState: ButtonState = .start{
        didSet {
            setTitle(buttonState.rawValue, for: .normal)
        }
    }

    func toggleAction() {
        switch buttonState {
        case .start, .reStart:
            buttonState = .stop
        case .stop:
            buttonState = .reStart
        }
    }
}
