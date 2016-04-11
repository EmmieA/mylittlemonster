//
//  MonsterImage.swift
//  mylittlemonster
//
//  Created by Monica Arnon on 4/10/16.
//  Copyright © 2016 TouchingFreedom. All rights reserved.
//

import Foundation
import UIKit

class MonsterImage: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //When first loading, the monster is alive and breathing
        playIdleAnimation()
    }
    
    func playIdleAnimation() {
        
        self.image = UIImage(named: "idle1.png")
        self.animationImages = nil
        
        var imageArr = [UIImage]()
        
        for x in 1...4 {
            let img = UIImage(named: "idle\(x).png")
            imageArr.append(img!)
        }
        
        self.animationImages = imageArr
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()
    }
    
    func playDeathAnimation() {
        
        self.image = UIImage(named: "dead5.png")
        self.animationImages = nil
        
        var imageArr = [UIImage]()
        
        for x in 1...5 {
            let img = UIImage(named: "dead\(x).png")
            imageArr.append(img!)
        }
        
        self.animationImages = imageArr
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()
    }
    
}
