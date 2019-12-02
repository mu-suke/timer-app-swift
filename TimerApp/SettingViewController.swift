//
//  SettingViewController.swift
//  TimerApp
//
//  Created by 村上祐亮 on 2019/11/28.
//  Copyright © 2019 村上祐亮. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // 変数の型指定宣言
    let valueArray : [Int] = [10,30,60,120,180]
    let settingKey = "timerValue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerPicker.delegate = self
        timerPicker.dataSource = self
        
        let settings = UserDefaults.standard
        let timerValue = settings.integer(forKey: settingKey)
        
        for row in 0..<valueArray.count {
            if valueArray[row] == timerValue {
                timerPicker.selectRow(row, inComponent: 0, animated: true
                )
            }
        }
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBOutlet weak var timerPicker: UIPickerView!
    // 前の画面に戻る
    @IBAction func chooseAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    // 列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // 行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return valueArray.count
    }
    // 配列の番号とタイトルの紐付け？
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(valueArray[row])
    }
    // 選択された値をsettingsにset setValue(値, 代入先)
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let settings = UserDefaults.standard
        settings.setValue(valueArray[row], forKey: settingKey)
        settings.synchronize()
    }
}
