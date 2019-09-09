//
//  ViewController.swift
//  StopWatch
//
//  Created by 駿河優輝長 on 2019/09/07.
//  Copyright © 2019 tsunousaLab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var miliSecondsLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    var timer: Timer!
    var startTime = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopButton.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        timer.invalidate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func startTimer(_ sender: Any) {
        if timer != nil{
            // timerが起動中なら一旦破棄する
            timer.invalidate()
        }
        setTimer()
        
        startTime = Date()
        
        stopButton.isHidden = false
        startButton.isHidden = true
    }
    
    func setTimer()  {
        timer = Timer.scheduledTimer(
            timeInterval: 0.01,
            target: self,
            selector: #selector(self.timerCounter),
            userInfo: nil,
            repeats: true
        )
    }

    @IBAction func stopCounter(_ sender: Any) {
        if timer != nil{
            timer.invalidate()
            
//            minutesLabel.text = "00"
//            secondsLabel.text = "00"
//            miliSecondsLabel.text = "00"
            stopButton.isHidden = true
            startButton.isHidden = false
        }
    }
    
    @IBAction func resetCounter(_ sender: Any) {
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
        
        minutesLabel.text = sMinute
        secondsLabel.text = sSecond
        miliSecondsLabel.text = sMsec
    }
    


}

