//
//  VCTest.m
//  VCsideMenu
//
//  Created by  Nomad on 2016. 4. 18..
//  Copyright © 2016년 dongmin. All rights reserved.
//

#import "VCTest.h"

@interface VCTest ()

@end

@implementation VCTest

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [self leftMenuAdd];
    [self rightMenuAdd];
}


- (IBAction)onBtnLeftMenTouch:(id)sender {
    
    [self leftMenuOpen];
    
}
- (IBAction)onBtnRightMenuTouch:(id)sender {
    
    [self rightMenuOpen];
    
}

@end
