//
//  DragImage.swift
//  mylittlemonster
//
//  Created by Monica Arnon on 4/10/16.
//  Copyright © 2016 TouchingFreedom. All rights reserved.
//

import Foundation
import UIKit

class DragImage: UIImageView {
    
    var originalPosition: CGPoint!
    
    //Even though we know this project's target for the dragging and dropping
    //is a UIImageView, think bigger picture in the instance that we want to 
    //re-use this class to drag and drop things on something other than a
    //UIImageView. Since it inherits from UIView (and so does most everything else)
    //use UIView instead.
    var dropTarget: UIView?
    
    override init(frame: CGRect) {
        //Must call the parent initializer which means this one that overrides 
        //has at least the same parameter requirements
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        //Must call the parent initializer which means this one that overrides
        //has at least the same parameter requirements
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //Need to know where to send the object back to if it's not a good drag
        //The X and Y coordinates of whatever is being touched
        originalPosition = self.center
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //A set of touches is passed in when called so attempt to grab the very 
        //first in the set which will be where the touch began
        if let touch = touches.first {
            
            //If there is a touches.first we'll enter into this if branch 
            //and we can now assign the position variable to be the 
            //location of that touch within the larger superview
            //(Superview being a reserved word for the entire container that's holding 
            //all our content)
            let position = touch.locationInView(self.superview)
            
            //Assign the new center as it's being moved
            self.center = CGPointMake(position.x, position.y)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //See initial comment in touchesMoved for touches.first explanation
        if let touch = touches.first, let target = dropTarget {
            
            //Grab the position where the touch ended
            let position = touch.locationInView(self.superview)
            
            //Is where the image was dragged anywhere inside the frame of the
            //intended target? Intended target is first param, the current position
            //is the second
            if CGRectContainsPoint(target.frame, position) {
                
                //When the item is confirmed to be dropped on the intended target,
                //create a notification which the ViewController must listen for.
                //Must add the observer of the notification when you create one.
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "onTargetDropped", object: nil))
            }
            
        }

        self.center = originalPosition
        
        
    }
    
}












