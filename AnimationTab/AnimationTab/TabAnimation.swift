//
//  TabAnimation.swift
//  AnimationTab
//
//  Created by merge on 2015/07/14.
//  Copyright (c) 2015年 merge. All rights reserved.
//

import UIKit

class TabAnimation: NSObject,UIViewControllerAnimatedTransitioning {
    
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 1.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let from:UIViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let to:UIViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var container:UIView = transitionContext.containerView()
        container.insertSubview(to.view, aboveSubview: from.view)
        to.view.alpha = 0.0;
        
        UIView.animateWithDuration(self.transitionDuration(transitionContext),
            animations: {() -> Void in

                println("begin")
                from.view.alpha = 0.0;
                to.view.alpha = 1.0;

            },
            completion: {(value: Bool) in
                transitionContext.completeTransition(true)
        })
    }
   
}
