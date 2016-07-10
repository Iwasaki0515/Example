//
//  FirstViewController.swift
//  tabtrial
//
//  Created by merge on 2016/07/10.
//  Copyright © 2016年 merge. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    var vvview:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)


    }
    
    @IBAction func pushshshsh(sender: AnyObject) {
        self.tabBarItem.badgeValue = nil
        self.tabbaredit(UIColor.greenColor())

    }
    @IBAction func pusshssh(sender: AnyObject) {
        self.tabBarItem.badgeValue = "222"
        self.tabbaredit(UIColor.blueColor())

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarItem.badgeValue = "222"
//        tabbaredit(UIColor.blueColor())


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tabbaredit(color:UIColor){
        let tabbar = self.tabBarController!.tabBar
        // search badgeView
        for barButton in tabbar.subviews{
            for buttonSubView in barButton.subviews{
                if NSStringFromClass(buttonSubView.dynamicType) == "_UIBadgeView"{
                    buttonSubView.backgroundColor = color
                    buttonSubView.layer.cornerRadius = buttonSubView.frame.size.height/2
                    for badgeView in buttonSubView.subviews{
                        // change badge background color
                        if NSStringFromClass(badgeView.dynamicType) == "UILabel"{
                            let label:UILabel = badgeView as! UILabel
                            label.backgroundColor = color
                            label.layer.cornerRadius = label.frame.size.height/2
                        }
                        // remove _UIBadgeBackground
                        if NSStringFromClass(badgeView.dynamicType) == "_UIBadgeBackground"{
                            badgeView.hidden = true
                        }
                    }
                }
            }
        }
    }

}

