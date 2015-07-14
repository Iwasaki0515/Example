//
//  TabViewController.swift
//  AnimationTab
//
//  Created by merge on 2015/07/14.
//  Copyright (c) 2015年 merge. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController,UITabBarControllerDelegate {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        println(viewController)
    }
    
    func tabBarController(tabBarController: UITabBarController,
        animationControllerForTransitionFromViewController fromVC: UIViewController,
        toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?{
            return TabAnimation()
    }
    

    
    
}
