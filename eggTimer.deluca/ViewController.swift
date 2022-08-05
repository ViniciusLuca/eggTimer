//
//  ViewController.swift
//  eggTimer.deluca
//
//  Created by user226569 on 8/2/22.
//

import UIKit
import AVFoundation

class Presenter{
    let softTime = 5
    let mediumTime = 7
    let hardTime = 12
    let eggTimes = ["Soft": 300.0, "Medium": 420.0, "Hard": 720.0]
    
    var totalTime = 0.0
    var secondsPassed = 0.0
    var player: AVAudioPlayer!
    
    func typeEgg(hardness: String) {
        secondsPassed = 0.0
        totalTime = eggTimes[hardness]!
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
    }
    func checkIfTimeFinished() -> Bool {
        return secondsPassed <= totalTime
    }
    func getProgress() -> Double {
        return secondsPassed / totalTime
    }
    func countSeconds() {
        secondsPassed += 1
    }
        
}
                    
class ViewController: UIViewController {
    
    var presenter = Presenter()
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var timer =  Timer()
    
    @IBAction func typeEgg(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        print(hardness)
        
        progressBar.progress = 0.0
        
        titleLabel.text = hardness
        
        timer.invalidate()
        presenter.typeEgg(hardness: hardness)
        
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
       
    }
        @objc func updateTimer() {
            if  presenter.checkIfTimeFinished() {
            progressBar.progress = Float(presenter.getProgress())
            presenter.countSeconds()
        }
        else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            presenter.playSound()
        }
        
        
}

}


