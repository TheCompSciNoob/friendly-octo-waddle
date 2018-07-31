//
//  HomePageController.swift
//  iOS
//
//  Created by Cluster 5 on 7/27/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import Foundation
import UIKit
import MetaWear

class HomePageController: UIViewController, ScanTableViewControllerDelegate {
    
    @IBOutlet weak var configureSensorsButton: UIButton!
    @IBOutlet weak var mandarinButton: UIButton!
    @IBOutlet weak var englishButton: UIButton!
    
    private var device: MBLMetaWear? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        if device != nil && device?.state ==
            .connected{
            print("Device ready.")
            mandarinButton.isEnabled = true
            englishButton.isEnabled = true
        } else {
            print("Device not connected.")
            mandarinButton.isEnabled = false
            englishButton.isEnabled = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scanTableViewController = segue.destination as? ScanTableViewController {
            scanTableViewController.delegate = self
        }
    }
    
    func scanTableViewController(_ controller: ScanTableViewController, didSelectDevice device: MBLMetaWear) {
        print("Device received from ScanTableViewController.")
        self.device = device
    }
}

