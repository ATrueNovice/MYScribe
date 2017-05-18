//
//  ViewController.swift
//  MyScribe
//
//  Created by New on 5/17/17.
//  Copyright © 2017 HSI. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var transcriptionTextField: UITextView!

    var audioPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        activitySpinner.isHidden = true


    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
    }

    //Required authorization for using speech on iPhone
    func requestSpeechAuth() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {

                //Defines the path to the audio file. So if the file is there...
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a"){
                    //Start playing the tuunnneessssss

                    do {
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer = sound
                        self.audioPlayer.delegate = self
                        sound.play()
                    } catch {
                        print("Error")
                    }

                    //Recognizer recognizes it.
                    let recognizer = SFSpeechRecognizer()
                    //Pulls the file and turns it into text
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    //Recognizes the text and prints
                    recognizer?.recognitionTask(with: request) { (result, error) in
                        if let error = error {
                            print("There was an error: \(error)")

                        }else {
                            //Prints the transcription.
                            self.transcriptionTextField.text = result!.bestTranscription.formattedString
                        }
                }

            }
    }


}
}
    @IBAction func playBtnPressed(_ sender: Any) {

        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        requestSpeechAuth()
    }
}
