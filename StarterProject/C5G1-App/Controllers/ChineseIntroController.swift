//
//  ChineseIntroController.swift
//  iOS
//
//  Created by Cluster 5 on 7/27/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import UIKit
import MetaWear

class ChineseIntroController: UIViewController, CocktailDelegate {
    @IBOutlet weak var nextButton: UIButton!
    
    var device: MBLMetaWear? = nil
    private let infos = [ChineseIntroInfo(textDescription: "Chinese Mall 1", audioDescription: "line1.wav", storyLine: Stories.CHINESE_MALL_1), ChineseIntroInfo(textDescription: "Chinese Mall 2", audioDescription: "line18.wav", storyLine: Stories.CHINESE_MALL_2)]
    private var cocktailEffectManager: CocktailEffectManager!
    private var angle: Double = 0.0
    private var index = 0
    
    override func viewDidLoad() {
        loadMapBackground(root: self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.cocktailEffectManager = CocktailEffectManager(fileNames: infos.map { $0.audioDescription }, device: self.device!)
        self.cocktailEffectManager.cocktailDelegate = self
        self.cocktailEffectManager.subscribeToDeviceUpdates()
        self.cocktailEffectManager.start()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("View will disappear.")
        self.cocktailEffectManager.unsubscribeToDeviceUpdates()
        self.cocktailEffectManager.pause()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let chineseAnswersController = segue.destination as? ChineseAnswersController {
            self.cocktailEffectManager.unsubscribeToDeviceUpdates()
            chineseAnswersController.device = self.device
            chineseAnswersController.storyLine = infos[index].storyLine
        }
    }
    
    func onFocusedIndexUpdated(index: Int) {
        self.index = index
        updateTextInButton()
    }
    
    func onAngleUpdated(newAngle: Double) {
        self.angle = newAngle
        updateTextInButton()
    }
    
    private func updateTextInButton() {
        UIView.performWithoutAnimation {
            self.nextButton.setTitle("NEXT: \(infos[index].textDescription), (\(Int(angle))°)", for: .normal)
            self.nextButton.layoutIfNeeded()
        }
    }
}

struct ChineseIntroInfo {
    let textDescription: String
    let audioDescription: String
    let storyLine: [PromptAndResponse]
}
