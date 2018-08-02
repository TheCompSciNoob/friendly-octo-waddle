//
//  MainTestController.swift
//  iOS
//
//  Created by Cluster 5 on 7/26/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import UIKit
import MetaWear

class MainTestController: UIViewController, ScanTableViewControllerDelegate {
    @IBOutlet weak var cocktailButton: UIButton!
    
    private var device: MBLMetaWear? = nil
    private var cocktailEffectManager: CocktailEffectManager? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        if device != nil {
            print("Device ready.")
            cocktailButton.isEnabled = true
        } else {
            cocktailButton.isEnabled = false
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
        //test line
        //cocktailEffectManager = CocktailEffectManager(targets: ["line1.wav", "line3.wav", "line5.wav"], device: device!)
        cocktailEffectManager?.placeSoundsDefault()
        cocktailEffectManager?.subscribeToDeviceUpdates()
        cocktailEffectManager?.start()
    }
}
