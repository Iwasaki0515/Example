//
//  ModalViewController.m
//  NavigationTrial
//
//  Created by merge on 2015/07/13.
//  Copyright (c) 2015年 merge. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()

@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)close:(id)sender {
    NSLog(@"モーダル閉じる");
    [self dismissViewControllerAnimated:YES completion:^(void){
        [_mvc.navigationController popViewControllerAnimated:YES];
    }];

}
@end
