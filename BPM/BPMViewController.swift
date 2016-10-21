//
//  BPMViewController.swift
//  BPM
//
//  Created by Luke Newman on 10/20/16.
//  Copyright © 2016 Luke Newman. All rights reserved.
//

import UIKit

class BPMViewController: UIViewController {

    @IBOutlet var bpmLabel: UILabel!
    @IBOutlet var resetButton: UIButton!

    var timestamps = [TimeInterval]()
    var deltas = [Double]()
    var totalDelta = 0.0
    
    var averageBPM: Double = 0.0
    var roundedBPM: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetButton.layer.borderColor = UIColor.white.cgColor
        resetButton.layer.borderWidth = 1.0
        resetButton.layer.cornerRadius = resetButton.bounds.height / 2.0
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let timestamp = touches[touches.startIndex].timestamp
        timestamps.append(timestamp)
        updateBPM()
    }
    
    func updateBPM() {
        if timestamps.count > 0 {
            let latestTimestamp = timestamps[timestamps.count - 1]
            if timestamps.count > 1 {
                let penultimateTimestamp = timestamps[timestamps.count - 2]
                let delta = latestTimestamp - penultimateTimestamp
                deltas.append(delta)
                totalDelta = totalDelta + delta
                let averageDelta = totalDelta / Double(deltas.count)
                averageBPM = 60.0 / averageDelta
                roundedBPM = Int(round(averageBPM))
                bpmLabel.text = "\(roundedBPM)"
            }
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: AnyObject) {
        timestamps = [TimeInterval]()
        deltas = [Double]()
        totalDelta = 0.0
        averageBPM = 0.0
        roundedBPM = 0
        bpmLabel.text = "BPM"
    }
}

