//
//  ModalViewController.h
//  NavigationTrial
//
//  Created by merge on 2015/07/13.
//  Copyright (c) 2015年 merge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MiddleViewController.h"

@interface ModalViewController : UIViewController

@property(nonatomic,weak)MiddleViewController *mvc;


- (IBAction)close:(id)sender;

@end
