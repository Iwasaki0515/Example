//
//  ViewController.swift
//  NonTinderUI
//
//  Created by merge on 2016/07/22.
//  Copyright © 2016年 merge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    var startX:CGFloat = 0.0
    var coordinateX:CGFloat = 0.0
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

        guard let touch = touches.first else{return}

        startX = touch.locationInView(nil).x
        print(coordinateX)

    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else{return}
        coordinateX = touch.locationInView(nil).x
        print(coordinateX - startX)
        
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        guard let touches = touches,
              let touch = touches.first else{
                return
        }
        coordinateX = touch.locationInView(nil).x
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else{return}
        coordinateX = touch.locationInView(nil).x
        print(startX - coordinateX)
        startX = 0.0
        
    }
    
    override func touchesEstimatedPropertiesUpdated(touches: Set<NSObject>) {
//        print(touches)
        
    }

}

