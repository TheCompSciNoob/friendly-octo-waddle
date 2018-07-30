//
//  MainTestController.swift
//  iOS
//
//  Created by Cluster 5 on 7/26/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import Foundation
import UIKit
import MetaWear

class MainTestController: UIViewController, ScanTableViewControllerDelegate {
    
    private var device: MBLMetaWear? = nil
    private var cocktailEffectManager: CocktailEffectManager? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        if device != nil {
            print("Device ready.")
        }
    }
  
    override func viewDidLoad() {
        
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scanTableViewController = segue.destination as? ScanTableViewController {
            scanTableViewController.delegate = self
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        device?.disconnectAsync()
        device = nil
    }
    
    func scanTableViewController(_ controller: ScanTableViewController, didSelectDevice device: MBLMetaWear) {
        print("Device received from ScanTableViewController.")
        self.device = device
    }
    
    @IBAction func startManager(_ sender: UIButton) {
        cocktailEffectManager = CocktailEffectManager(fileNames: ["water.WAV", "carson.WAV"], device: device!)
        cocktailEffectManager?.placeSoundsDefault()
        cocktailEffectManager?.subscribeToDeviceUpdates()
        cocktailEffectManager?.start()
    }
}
