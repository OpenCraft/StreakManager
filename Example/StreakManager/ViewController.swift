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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\(Streak.ofDays()) days using this app")
        print("\(Streak.ofWeeks()) weeks using this app")
    }

}

