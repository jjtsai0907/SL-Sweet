//
//  SpeechService.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2022-01-04.
//

import Foundation
import AVKit

class SpeechService: NSObject {
    
    static let shared = SpeechService()
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    // MARK: - Speech Methods
    
    func startSpeech(text: String) {
        
        self.stopSpeech()
        
        if let language = NSLinguisticTagger.dominantLanguage(for: text){
            let utterence = AVSpeechUtterance(string: text)
            utterence.voice = AVSpeechSynthesisVoice(language: language)
            
            speechSynthesizer.speak(utterence)
        }
        
        
    }
    
    func stopSpeech() {
        speechSynthesizer.stopSpeaking(at: .immediate)
    }
    
}
