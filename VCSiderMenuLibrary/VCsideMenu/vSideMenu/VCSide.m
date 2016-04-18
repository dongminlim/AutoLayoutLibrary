//
//  VCSide.m
//  VCsideMenu
//
//  Created by  Nomad on 2016. 4. 18..
//  Copyright © 2016년 dongmin. All rights reserved.
//

#import "VCSide.h"
#import "VLeftMenu.h"
#import "VRightMenu.h"
@interface VCSide ()

@end

@implementation VCSide
{
    VLeftMenu *vLeftMenu;
    VRightMenu *vRightMenu;
    UIPanGestureRecognizer *_panGesture;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated] ;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


#pragma mark LeftMenu
- (IBAction)slideGesture:(UIGestureRecognizer *)sender {
    NSLog(@"handleGesture");
    
    UIGestureRecognizer *gesture = (UIGestureRecognizer *)sender;
    if ([[gesture accessibilityHint] isEqualToString:@"leftMenu"]) {
        
        [self.view bringSubviewToFront:vLeftMenu] ;
        CGPoint point = [sender locationInView:self.view] ;
        
        NSMutableDictionary *dtData = [NSMutableDictionary dictionaryWithObject:sender forKey:@"sender"] ;
        [dtData setObject:[NSNumber numberWithDouble:point.x] forKey:@"pointX"] ;
        [dtData setObject:[NSNumber numberWithDouble:point.y] forKey:@"pointY"] ;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gesture" object:sender userInfo:dtData] ;
        
        [self.view layoutIfNeeded];
        return;
        
    }else {
        
        [self.view bringSubviewToFront:vRightMenu];
        CGPoint point = [sender locationInView:self.view];
        
        NSMutableDictionary *dtData = [NSMutableDictionary dictionaryWithObject:sender forKey:@"sender"] ;
        [dtData setObject:[NSNumber numberWithDouble:point.x] forKey:@"pointX"] ;
        [dtData setObject:[NSNumber numberWithDouble:point.y] forKey:@"pointY"] ;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gesture" object:sender userInfo:dtData] ;
        
        [self.view layoutIfNeeded];
        return ;
        
    }
    
}

- (void)leftMenuAdd {
    
    if (vLeftMenu == nil) {
        //사이드 메뉴 셋팅
        vLeftMenu = [[VLeftMenu alloc]initAddSubView] ;
        [vLeftMenu setDelegate:self];
        [self.view addSubview:vLeftMenu] ;
        
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slideGesture:)] ;
        _panGesture.accessibilityHint = @"leftMenu";
        
        [self.view addGestureRecognizer:_panGesture];
    }
    
}

- (void)rightMenuAdd {
    
    if (vRightMenu == nil) {
        //사이드 메뉴 셋팅
        vRightMenu = [[VRightMenu alloc]initAddSubView];
        [vRightMenu setDelegate:self];
        [self.view addSubview:vRightMenu] ;
        
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slideGesture:)] ;
        _panGesture.accessibilityHint = @"rightMenu";
        
        [self.view addGestureRecognizer:_panGesture];
    }
    
}



- (void)leftMenuOpen {
    [vLeftMenu sideOpen];
}
- (void)leftMenuClose {
    [vLeftMenu sideClose];
}
- (void)rightMenuOpen {
    [vRightMenu sideOpen];
}
- (void)rigthMenuClose {
    [vRightMenu sideClose];
}

@end
