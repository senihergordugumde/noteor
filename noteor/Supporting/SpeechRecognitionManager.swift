//
//  SpeechRecognitionManager.swift
//  noteor
//
//  Created by Emir AKSU on 11.03.2024.
//

import Foundation
import UIKit
import Speech
import AVFoundation


protocol SpeechRecognitionProtocol{
    func configureAudioEngine(textField : UITextField?, button : UIButton, textView : UITextView?)
}


class SpeechRecognitionManager : SpeechRecognitionProtocol{
    
  
    
    let audioEngine = AVAudioEngine()
    let audioSession = AVAudioSession()
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "tr-TR"))
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognizerTask : SFSpeechRecognitionTask?
   

    func configureAudioEngine(textField : UITextField?, button : UIButton, textView : UITextView?){
         
         
         //Configure Indicator
         let indicator = UIActivityIndicatorView()

         indicator.hidesWhenStopped = true
         indicator.style = .large
         indicator.color = .white
         button.addSubview(indicator)
         
         indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.isUserInteractionEnabled = false
         NSLayoutConstraint.activate([
         
            indicator.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            indicator.heightAnchor.constraint(equalToConstant: 50),
            indicator.widthAnchor.constraint(equalToConstant: 50)
         
         ])
    
         if audioEngine.isRunning{
             audioEngine.stop()
             request.endAudio()
             indicator.stopAnimating()
             
             return
         }
        indicator.startAnimating()
        if recognizerTask != nil{
            recognizerTask?.cancel()
            recognizerTask = nil
        }
        
        do{
            try audioSession.setCategory(.record)
            try audioSession.setMode(.measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        }
        catch{
            print("Audio Session Error")
        }
      
        
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
            
        
     
        node.installTap(onBus: 0, bufferSize: .max, format:recordingFormat){ buffer, _ in
            
            self.request.append(buffer)
            
            
        }
        
        audioEngine.prepare()
        
        do{
            try audioEngine.start()
        }
        
        catch{
            print("Audio engine start error")
        }
        
        var isFinal = false
        
        guard let speechRecognizer = speechRecognizer else {return}
        recognizerTask = speechRecognizer.recognitionTask(with: request, resultHandler: { result, error in
            
            if let result = result{
                
                
                if let textField = textField {
                    textField.text = result.bestTranscription.formattedString

                }else{
                    textView?.text = result.bestTranscription.formattedString
                }
                
                
                
                isFinal = result.isFinal
                
            }
            
            if error != nil || isFinal {
                indicator.stopAnimating()

                self.audioEngine.stop()
                self.recognizerTask?.cancel()
                self.recognizerTask = nil
                node.removeTap(onBus: 0)
                
            }
            
        })
    
        
         
         
    }
    
    
   
    
}
