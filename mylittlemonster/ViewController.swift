//
//  ViewController.swift
//  mylittlemonster
//
//  Created by Monica Arnon on 4/10/16.
//  Copyright © 2016 TouchingFreedom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var monsterImage:    UIImageView!
    //In order for these to actually be draggable, you need to check 
    //the "User Interaction enabled" checkbox in the attribute inspector
    @IBOutlet weak var foodImage:       DragImage!
    @IBOutlet weak var healthImage:     DragImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMonster()
    }
    
    func setupMonster() {
        var imageArr = [UIImage]()
        
        for x in 1...4 {
            let img = UIImage(named: "idle\(x).png")
            imageArr.append(img!)
        }
        
        monsterImage.animationImages = imageArr
        monsterImage.animationDuration = 0.8
        monsterImage.animationRepeatCount = 0
        monsterImage.startAnimating()
    }

}

