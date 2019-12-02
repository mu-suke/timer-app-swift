//
//  ViewController.swift
//  TimerApp
//
//  Created by 村上祐亮 on 2019/11/28.
//  Copyright © 2019 村上祐亮. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer: Timer?
    // durationは経過時間
    var duration = 0
    let settingKey = "timerValue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // UserDefaultsは前回アプリが使われた際の値を保持する役割を持っている
        let settings = UserDefaults.standard
        // デフォルト値を60秒に設定
        settings.register(defaults: [settingKey: 60])
    }
    
    // このページが再表示された際の動作
    override func viewDidAppear(_ animated: Bool) {
        duration = 0
        _ = displayUpdate()
    }


    @IBOutlet weak var timeDisplay: UILabel!
    
    
    
    @IBAction func settingButtonAction(_ sender: Any) {
        if let nowTimer = timer {
            if nowTimer.isValid == true {
                nowTimer.invalidate()
            }
        }
        // withIdenfifier: segueの名前
        performSegue(withIdentifier: "openSetting", sender: nil)
    }
    @IBAction func startTimerAction(_ sender: Any) {
        if let nowTimer = timer {
            if nowTimer.isValid == true {
                return
            }
        }
        // Timer.scheduledTimer(timeInterval: 実行する間隔, target: 返す画面(この場合はメインなのでself), selector: 何を実行するか, userInfo: 不明, repeats: 繰り返し呼び出すか否か)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerStop(_:)), userInfo: nil, repeats: true)
    }
    @IBAction func stopTimerAction(_ sender: Any) {
        if let nowTimer = timer {
            if nowTimer.isValid == true {
                nowTimer.invalidate()
            }
        }
    }
    
    // 残り秒数を表示
    func displayUpdate() -> Int {
        let settings = UserDefaults.standard
        // integerは整数
        let timerValue = settings.integer(forKey: settingKey)
        let remainSeconds = timerValue - duration
        timeDisplay.text = "あと\(remainSeconds)秒です"
        return remainSeconds
    }
    
    // "_" はラベルを省略する voidなのか？
    // タイマーを監視する
    @objc func timerStop (_ timer:Timer){
        duration += 1
        if displayUpdate() <= 0 {
            duration = 0
            // invalidate()は無効化
            timer.invalidate()
        }
    }
}

