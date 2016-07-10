//
//  ViewController.m
//  ImageTrial
//
//  Created by merge on 2015/07/22.
//  Copyright (c) 2015年 merge. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _image.image = [_image.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _image2.image = [_image2.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _image3.image = [_image3.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _image4.image = [_image4.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
