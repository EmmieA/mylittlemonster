//
//  ViewController.swift
//  mylittlemonster
//
//  Created by Monica Arnon on 4/10/16.
//  Copyright © 2016 TouchingFreedom. All rights reserved.
//

import UIKit
import AVFoundation

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
    var monsterHappy: Bool      = true
    var currentItem             = 0
    
    //Sounds
    var musicPlayer:            AVAudioPlayer!
    var sfxBite:                AVAudioPlayer!
    var sfxHeart:               AVAudioPlayer!
    var sfxDeath:               AVAudioPlayer!
    var sfxSkull:               AVAudioPlayer!

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
        
        do {
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:
                NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!))
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:
                NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:
                NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:
                NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:
                NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            
            musicPlayer.prepareToPlay()
            musicPlayer.volume = 0.3
            musicPlayer.play()
            
            sfxBite.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxDeath.prepareToPlay()
            sfxSkull.prepareToPlay()
            
            sfxBite.volume = 0.4
            sfxHeart.volume = 0.4
            sfxDeath.volume = 0.4
            sfxSkull.volume = 0.4
            
        } catch let err as NSError {
            print(err.debugDescription)
        }

        disableItems()
        startTimer()
        
    }
    
    
    //Function called by the event listener (observer) for the itemDroppedOnCharacter
    //event
    func itemDroppedOnCharacter(notif: AnyObject) {
        //Use for testing
        //print("ITEM DROPPED ON CHARACTER")
        
        monsterHappy = true
        startTimer()
        disableItems()
        
        //Play the right sound
        if currentItem == 0 {
            sfxHeart.play()
        } else {
            sfxBite.play()
        }
    }
    
    func startTimer() {
        if timer != nil {
            //Safety measure if the timer is found to be running
            timer.invalidate()
        }
        
        //repeats: true means the timer is executed every [n] seconds
        //Which means the changeGameState function is called every [n] seconds
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0,
                                                       target: self,
                                                       selector: #selector(ViewController.changeGameState),
                                                       userInfo: nil,
                                                       repeats: true)
    }
    
    func changeGameState() {
        
        if !monsterHappy {
            currentPenalities += 1
            
            sfxSkull.play()
            
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

        //Determine what need the monster has next
        //0 will be health, 1 will be food
        let rand = Int(arc4random_uniform(2))
        
        if rand == 0 {
            healthImage.alpha = OPAQUE
            healthImage.userInteractionEnabled = true
            
            foodImage.alpha = DIM_ALPHA
            foodImage.userInteractionEnabled = false
        } else {
            foodImage.alpha = OPAQUE
            foodImage.userInteractionEnabled = true
            
            healthImage.alpha = DIM_ALPHA
            healthImage.userInteractionEnabled = false
            
        }
        
        currentItem = rand
        //Turn the happy indicator off which ensures if the user does nothing after 
        //this iteration of the timer, when the function is entered again, the logic
        //in the if branch will be executed
        monsterHappy = false
    }
    
    func gameEnd() {
        timer.invalidate()
        sfxDeath.play()
        monsterImage.playDeathAnimation()
    }
    
    func disableItems() {
        foodImage.alpha = DIM_ALPHA
        foodImage.userInteractionEnabled = false
        healthImage.alpha = DIM_ALPHA
        healthImage.userInteractionEnabled = false
    }
    

}

