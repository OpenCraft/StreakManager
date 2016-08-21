//
//  ViewController.swift
//  StreakManager
//
//  Created by Henrique Morbin on 08/21/2016.
//  Copyright (c) 2016 Henrique Morbin. All rights reserved.
//

import UIKit
import StreakManager

class ViewController: UIViewController {

    @IBOutlet weak var labelDays: UILabel!
    @IBOutlet weak var labelWeeks: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelDays.text = "\(Streak.ofDays()) day(s) using this app"
        labelWeeks.text = "\(Streak.ofWeeks()) week(s) using this app"
    }

}

