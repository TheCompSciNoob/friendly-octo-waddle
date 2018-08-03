//
//  EnglishIntroController.swift
//  iOS
//
//  Created by Cluster 5 on 7/27/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import UIKit
import MetaWear
import AVFoundation

class EnglishIntroController: UIViewController {
    @IBOutlet weak var nextButton: TextureButton!
    
    var device: MBLMetaWear? = nil
    private var soundManager: SoundManager! {
        didSet {
            soundManager.updatePosition(index: 0, position: AVAudio3DPoint(x: 0, y: 0, z: 3))
            soundManager.changeVolume(index: 0, vol: 0.5)
            soundManager.updatePosition(index: 1, position: AVAudio3DPoint(x: 0, y: 10, z: -10))
            soundManager.changeVolume(index: 1, vol: 0.01)
            for index in 0..<soundManager.fileNames.count {
                soundManager.play(index: index, options: .loops)
            }
        }
    }
    private var preloadedManager: SoundManager! {
        didSet {
            nextButton.isEnabled = true
        }
    }
    
    override func viewDidLoad() {
        loadMapBackground(root: self.view)
        
        //0: story (parth)
        //1: Huma
        //2: Emma
        //3: Chi
        //4: lol 1
        //5: lol 2
        //6: lol 3
        //7: Parth's footsteps
        //8: campfire
        //9: crickets
        DispatchQueue.global(qos: .background).async {
            let sm = SoundManager(fileNames: ["PARTH FINAL AUDIO.wav", "Huma's audio.wav", "EMMA AUDIO FINAL.wav", "CHI FINAL AUDIO.wav", "Ourlaughingaudio1.wav", "OurLaughing2.wav", "ourlaughing3.wav", "249921__launemax__walking-slow-on-stones.wav", "433783__cagancelik__campfire.flac", "129678__freethinkeranon__crickets.mp3"])
            DispatchQueue.main.async {
                self.preloadedManager = sm
            }
        }
        
        //ambient noises for this page
        DispatchQueue.global(qos: .background).async {
            let sm = SoundManager(fileNames: ["433783__cagancelik__campfire.flac", "129678__freethinkeranon__crickets.mp3"])
            DispatchQueue.main.async {
                self.soundManager = sm
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        for index in 0..<soundManager.fileNames.count {
            soundManager.pause(index: index)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let englishStoryController = segue.destination as? EnglishStoryController {
            englishStoryController.soundManager = self.preloadedManager
            englishStoryController.device = self.device
        }
    }
}


