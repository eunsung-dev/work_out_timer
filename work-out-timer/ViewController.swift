//
//  ViewController.swift
//  work-out-timer
//
//  Created by 최은성 on 2022/02/11.
//

import UIKit
import SRCountdownTimer

class ViewController: UIViewController, SRCountdownTimerDelegate {
    
    // status bar 색상을 흰색으로 함
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }



    @IBOutlet weak var timer: SRCountdownTimer!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // 시작 버튼 클릭시 첫번째 클릭시와 두번째 클릭시를 구분하기 위함
    var flag:Bool = false
    
    // segmented Control에서 사용하는 시간과 관련한 변수들
    let timeList:[Int] = [60,90,180,300]
    var timeIndex:Int = 0

    // UserDefaults
    let defaults = UserDefaults.standard


    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer.delegate = self
        
        
        // 분, 초로 표시
        timer.useMinutesAndSecondsRepresentation = true
        

        // 타이머에 표시되는 숫자 사이즈 정함
        timer.labelFont = .systemFont(ofSize: 60)
        
        // 버튼을 원형으로 만듦
        cancelButton.layer.cornerRadius = 0.5 * cancelButton.bounds.size.width
        startButton.layer.cornerRadius = 0.5 * startButton.bounds.size.width
        calculateButton.layer.cornerRadius = 15
        
        // 타이머에 초기값 보여주기 위해
        timeIndex = defaults.integer(forKey: "Timer")
        timerShowValue(value: timeList[timeIndex])
        
        // segmented Control을 이전에 저장된 타이머 값으로 보여주기 위해
        segmentedControl.selectedSegmentIndex = timeIndex
        
    }
    @IBAction func startButtonPressed(_ sender: UIButton) {
        if !flag {
            if startButton.currentTitle == "재개" {
                timer.resume()
                startButton.setTitle("일시정지", for: .normal)
            }
            else {
                timer.start(beginingValue: timeList[timeIndex])
                startButton.setTitle("일시정지", for: .normal)
            }
            flag = true
        }
        else {
            timer.pause()
            startButton.setTitle("재개", for: .normal)
            flag = false
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        timer.reset()
        startButton.setTitle("시작", for: .normal)
        flag = false
        timerShowValue(value: timeList[timeIndex])
    }
    
    func timerDidEnd(sender: SRCountdownTimer, elapsedTime: TimeInterval) {

        // 타이머가 끝났으면 alert을 통해 타이머가 끝났음을 알림
        let alert = UIAlertController(title: "타이머 종료", message: "타이머가 종료되었습니다.", preferredStyle: UIAlertController.Style.alert)
        let defaultAction = UIAlertAction(title: "확인", style: .default, handler : nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)

        startButton.setTitle("시작", for: .normal)
        timerShowValue(value: timeList[timeIndex])
        flag = false
    }

    func timerShowValue(value: Int) {
        timer.start(beginingValue: value)
        timer.pause()
    }
    
    @IBAction func rmButtonPressed(_ sender: UIButton) {
    performSegue(withIdentifier: "goTo1rm", sender: sender)
    }
    
    @IBAction func segmentedControlPressed(_ sender: UISegmentedControl) {
        timeIndex = sender.selectedSegmentIndex
        timer.reset()
        startButton.setTitle("시작", for: .normal)
        flag = false
        timerShowValue(value: timeList[timeIndex])
        // timeIndex 저장
        defaults.set(timeIndex, forKey: "Timer")
    }
    
}

