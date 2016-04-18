//
//  VCSide.h
//  VCsideMenu
//
//  Created by  Nomad on 2016. 4. 18..
//  Copyright © 2016년 dongmin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCSide : UIViewController
//왼쪽 메뉴추가
- (void)leftMenuAdd;
//오른쪽 메뉴추가
- (void)rightMenuAdd;

//왼쪽 열기
- (void)leftMenuOpen;
//왼쪽 닫기
- (void)leftMenuClose;

//오른쪽 열기
- (void)rightMenuOpen;
//오른쪽 닫기
- (void)rigthMenuClose;

@end
