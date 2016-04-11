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
    @IBOutlet weak var penalty1Image:   UIImageView!
    @IBOutlet weak var penalty2Image:   UIImageView!
    @IBOutlet weak var penalty3Image:   UIImageView!

    //In order for these to actually be draggable, you need to check
    //the "User Interaction enabled" checkbox in the attribute inspector
    
    @IBOutlet weak var foodImage:       DragImage!
    @IBOutlet weak var healthImage:     DragImage!
    
    let DIM_ALPHA:  CGFloat     = 0.2
    let OPAQUE:     CGFloat     = 1.0
    let MAX_PENALTY             = 3
    
    var currentPenalities       = 0
    var timer: NSTimer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //The dropTarget property is in the custom class of DragImage.
        //It's needed so that we can ask "When the user dragged the food or 
        //health, did it get released on top of the "dropTarget" which is 
        //set here to the monsterImage. Awesome!
        
        foodImage.dropTarget = monsterImage
        healthImage.dropTarget = monsterImage
        
        //Setup the initial opacity of the penalty images
        penalty1Image.alpha = DIM_ALPHA
        penalty2Image.alpha = DIM_ALPHA
        penalty3Image.alpha = DIM_ALPHA
        
        //A notification is created when the user drops health or food onto 
        //the monster UIView (see Monster.touchesEnded). Here we're creating 
        //the listener for that event.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.itemDroppedOnCharacter(_:)), name: "onTargetDropped", object: nil)
        
        startTimer()
    }
    
    
    //Function called by the event listener (observer) for the itemDroppedOnCharacter
    //event
    func itemDroppedOnCharacter(notif: AnyObject) {
        print("ITEM DROPPED ON CHARACTER")
    }
    
    func startTimer() {
        if timer != nil {
            //Safety measure if the timer is found to be running
            timer.invalidate()
        }
        
        //repeats: true means the timer is executed every 3.0 seconds (in our case)
        //Which means the changeGameState function is called every 3.0 seconds
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(ViewController.changeGameState), userInfo: nil, repeats: true)
    }
    
    func changeGameState() {
        currentPenalities += 1
        
        if currentPenalities == 1 {
            penalty1Image.alpha = OPAQUE
            penalty2Image.alpha = DIM_ALPHA
            penalty3Image.alpha = DIM_ALPHA
        } else if currentPenalities == 2 {
            penalty2Image.alpha = OPAQUE
            penalty3Image.alpha = DIM_ALPHA
        } else if currentPenalities >= 3 {
            penalty3Image.alpha = OPAQUE
        } else {
            penalty1Image.alpha = DIM_ALPHA
            penalty2Image.alpha = DIM_ALPHA
            penalty3Image.alpha = DIM_ALPHA
            
        }
        
        if currentPenalities >= MAX_PENALTY {
            gameEnd()
        }
    }
    
    func gameEnd() {
        timer.invalidate()
        monsterImage.playDeathAnimation()
    }
    

}

