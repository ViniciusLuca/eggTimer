//
//  ViewController.swift
//  eggTimer.deluca
//
//  Created by user226569 on 8/2/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let softTime = 5
    let mediumTime = 7
    let hardTime = 12
    
    let eggTimes = ["Soft": 300.0, "Medium": 420.0, "Hard": 720.0]
    
    var totalTime = 0.0
    var secondsPassed = 0.0
    
    var timer =  Timer()
    
    var player: AVAudioPlayer!
    
    @IBAction func typeEgg(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        print(hardness)
        
        progressBar.progress = 0.0
        secondsPassed = 0.0
        titleLabel.text = hardness
        
        timer.invalidate()
        
        totalTime = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        if hardness == "Hard"{
            print("minutes: \(hardTime)")
        }
        else if hardness == "Medium"{
            print("minutes: \(mediumTime)")
        }
        else if hardness == "Soft"{
            print("minutes: \(softTime)")
        }
            
    }
        @objc func updateTimer() {
        if  secondsPassed <= totalTime {
            
            let percentProgress = secondsPassed / totalTime
            progressBar.progress = Float(percentProgress)
            secondsPassed += 1
        }
        else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            playSound()
        }
        
        func playSound() {
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
    }
}

}


