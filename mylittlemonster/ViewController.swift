//
//  ViewController.swift
//  mylittlemonster
//
//  Created by Monica Arnon on 4/10/16.
//  Copyright © 2016 TouchingFreedom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var monsterImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupMonster()
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

