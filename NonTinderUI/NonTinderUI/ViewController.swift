//
//  ViewController.swift
//  NonTinderUI
//
//  Created by merge on 2016/07/22.
//  Copyright © 2016年 merge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.hidden = true

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
        image.hidden=false

    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else{return}
        coordinateX = touch.locationInView(nil).x
        let width = coordinateX - startX
        print(width)
        
        if width > 10.0{image.image = UIImage(named: "1")}
        if width > 20.0{image.image = UIImage(named: "2")}
        if width > 30.0{image.image = UIImage(named: "3")}
        if width > 40.0{image.image = UIImage(named: "4")}
        
        if width < -10.0{image.image = UIImage(named: "-1")}
        if width < -20.0{image.image = UIImage(named: "-2")}
        if width < -30.0{image.image = UIImage(named: "-3")}
        if width < -40.0{image.image = UIImage(named: "-4")}
        
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
        image.hidden=true
        
    }
    
    override func touchesEstimatedPropertiesUpdated(touches: Set<NSObject>) {
//        print(touches)
        
    }

}

