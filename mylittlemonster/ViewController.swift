//
//  ViewController.swift
//  mylittlemonster
//
//  Created by Monica Arnon on 4/10/16.
//  Copyright © 2016 TouchingFreedom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var monsterImage:    MonsterImage!
    //In order for these to actually be draggable, you need to check 
    //the "User Interaction enabled" checkbox in the attribute inspector
    @IBOutlet weak var foodImage:       DragImage!
    @IBOutlet weak var healthImage:     DragImage!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}

