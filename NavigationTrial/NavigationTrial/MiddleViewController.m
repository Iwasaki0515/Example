//
//  MiddleViewController.m
//  NavigationTrial
//
//  Created by merge on 2015/07/13.
//  Copyright (c) 2015年 merge. All rights reserved.
//

#import "MiddleViewController.h"
#import "ModalViewController.h"
#import "PushViewController.h"

@interface MiddleViewController ()

@end

@implementation MiddleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"modal"]) {
        
        ModalViewController *mvc = segue.destinationViewController;
        [mvc setMvc:self];
        
        
    }else if ([segue.identifier isEqualToString:@"push"]) {
        
        PushViewController *pvc = segue.destinationViewController;
        [pvc setMvc:self];
        
        
    }
    
}

- (IBAction)close:(id)sender {
    [self close];
}

-(void)close{
    NSLog(@"閉じる:中間");
    [self.navigationController popViewControllerAnimated:YES];
}

@end
