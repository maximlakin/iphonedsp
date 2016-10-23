//
//  ViewController.swift
//  sound_app
//
//  Created by Kevin Woods on 10/22/16.
//  Copyright © 2016 C-Rails. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var audioRecorder:AVAudioRecorder!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func record(){
        let recordSettings = [
            AVFormatIDKey: NSNumber(value:kAudioFormatAppleLossless),
            AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
            AVEncoderBitRateKey : 320000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey : 44100.0
        ]
        print(recordSettings)
        var audioSession:AVAudioSession = AVAudioSession.sharedInstance()
        
        
        
    }
}

