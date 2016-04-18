//
//  VLeftMenu.h
//  Test
//
//  Created by  Nomad on 2016. 4. 15..
//  Copyright © 2016년 dongmin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VLeftMenu : UIView

@property (strong, nonatomic) IBOutlet UIView *vMenu;
@property (strong, nonatomic) IBOutlet UIView *vAlpha;
@property (strong, nonatomic) id    delegate;
@property (nonatomic) NSInteger slideStatus;

- (id)initAddSubView;
- (void)sideOpen ;
- (void)sideClose ;

@end

@protocol ViewLeftSideMenuDelegate <NSObject>

- (void)leftSideMenuIsOpen:(BOOL)open;

@end