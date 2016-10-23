//
//  ViewController.swift
//  sound_app
//
//  Created by Kevin Woods on 10/22/16.
//  Copyright © 2016 C-Rails. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate {
    var audioRec: AVAudioRecorder?
    let audioUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("sound.m4a")
    var player: AVAudioPlayer?
    func prepareSound() {
        let url = Bundle.main.url(forResource: "beep-01a", withExtension: "wav")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
           
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSound()
        AVAudioSession.sharedInstance().requestRecordPermission () {
            [unowned self] allowed in
            if allowed {
                // Microphone allowed, do what you like!
              print("allowed")
            } else {
                // User denied microphone. Tell them off!
                
            }
        }
//        let systemSoundID: SystemSoundID = 1016
        
        // to play sound
        self.view.addSubview(recordButton())
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func recordButton() -> UIButton{
        let myButton = UIButton(frame: CGRect(x: 0,y: 50,width: 200, height: 40))
        myButton.addTarget(self, action: #selector(self.recordAction(_:)), for: UIControlEvents.touchUpInside)
        myButton.setTitle("start recording", for: UIControlState.normal)
        myButton.backgroundColor = UIColor.red
        return myButton
    }
    func recordAction(_ sender: UIButton) {
        if (audioRec == nil) {
            self.record()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("done")
        print(audioUrl)
        audioRec = nil
        
    }
    func record(){
       
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docsDirect = paths[0]
        
        
        let session = AVAudioSession.sharedInstance()
        
        do {
            // 2. configure the session for recording and playback
            
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
            try session.setActive(true)
            // 3. set up a high-quality recording session
            let settings = [
                AVFormatIDKey: Int(kAudioFormatAppleLossless),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            // 4. create the audio recording, and assign ourselves as the delegate
            audioRec = try AVAudioRecorder(url: audioUrl, settings: settings)
            audioRec?.delegate = self
            audioRec?.record()
            self.player?.play()
            let when = DispatchTime.now() + 1 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                // Your code with delay
                print("should stop")
                self.audioRec?.stop()
            }
            
          
        } 
        catch let error {
            print(error)
            // failed to record!
        }
        
        
    }
}

