//
//  ViewController.m
//  Demo
//
//  Created by kfzx-linz on 16/6/15.
//  Copyright © 2016年 ICBC. All rights reserved.
//

#import "ViewController.h"
#import "ZinkPhotoVideo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)actionPhoto:(id)sender {
    [ZinkPhotoVideo zinkShowPhotoWithActionSheetInController:self
                                                    complete:^(UIImage *image) {
                                                        
                                                    } cancel:^{
                                                        
                                                    }];
}
- (IBAction)actionVideo:(id)sender {
    [ZinkPhotoVideo zinkShowVideoWithActionSheetInController:self
                                                    complete:^(NSURL *url) {
                                                        
                                                    } cancel:^{
                                                        
                                                    }];
}
@end
