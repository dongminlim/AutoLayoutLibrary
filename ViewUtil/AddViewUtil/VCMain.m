//
//  VCMain.m
//  AddViewUtil
//
//  Created by  Nomad on 2016. 4. 19..
//  Copyright © 2016년 dongmin. All rights reserved.
//

#import "VCMain.h"
#import "VCAddHorizon.h"
#import "VCAddVertical.h"

@interface VCMain ()

@end

@implementation VCMain

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//옆으로 AddView
- (IBAction)onBtnAddHorizonTouch:(id)sender {
    
    VCAddHorizon *iVCAddHorizon = [[VCAddHorizon alloc]initWithNibName:@"VCAddHorizon" bundle:nil];
    [self.navigationController pushViewController:iVCAddHorizon animated:YES];
    
}

//아래로 AddView
- (IBAction)onBtnAddVerticalTouch:(id)sender {
    
    VCAddVertical *iVCAddVertical = [[VCAddVertical alloc]initWithNibName:@"VCAddVertical" bundle:nil];
    [self.navigationController pushViewController:iVCAddVertical animated:YES];
    
}

@end
