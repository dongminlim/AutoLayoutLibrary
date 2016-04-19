//
//  ViewUtil.m
//  DukkubiSesang
//
//  Created by dev01 on 2015. 9. 21..
//
//

#import "ViewUtil.h"


@implementation ViewUtil

+ (void)addViewBottomByContainer:(UIView*)container Cell:(UIView*)cell CellSpacing:(CGFloat)cellSpacing {
    
    UIView *lastView ;
    // 컨테이너에 마지막 뷰
    if ([container.subviews count] > 0) {
        lastView = [container.subviews lastObject] ;
        
        // 컨테이너에 관계설정 확인
        for(NSLayoutConstraint *constraint in container.constraints) {
            
            // 컨테이너와 마지막 뷰의 관계
            if(constraint.firstItem == lastView || constraint.secondItem == lastView) {
                
                // 컨테이너와 마지막 뷰의 관계 중 Bottom : Bottom
                if(constraint.firstAttribute == NSLayoutAttributeBottom && constraint.secondAttribute == NSLayoutAttributeBottom) {
                    
                    // 관계 제거
                    [container removeConstraint:constraint] ;
                    
                }
                
            }
            
        }
        
    }
    

    
    // 컨테이너에 로우 추가
    [container addSubview:cell] ;
    
    // 서브뷰 관계 설정
    cell.translatesAutoresizingMaskIntoConstraints = NO ;
    
    NSLayoutConstraint *constHeight = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:cell.frame.size.height] ;
    
    NSLayoutConstraint *constTop = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeTop multiplier:1 constant:0.0f] ;
    
    NSLayoutConstraint *constBottom = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeBottom multiplier:1 constant:0.0f] ;
    
    NSLayoutConstraint *constLeft = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeLeading multiplier:1 constant:0.0f] ;
    
    NSLayoutConstraint *constRight = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeTrailing multiplier:1 constant:0.0f] ;
    
    
    // 2번째 뷰 부터는 상단 : 직전 뷰 하단의 관계 설정
    if(container.subviews.count > 1) {
        
        constTop = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:lastView attribute:NSLayoutAttributeBottom multiplier:1 constant:cellSpacing] ;
        
    }
    
    [cell.superview addConstraint:constHeight] ;
    [cell.superview addConstraint:constTop] ;
    [cell.superview addConstraint:constBottom] ;
    [cell.superview addConstraint:constLeft] ;
    [cell.superview addConstraint:constRight] ;

}



+ (void)addViewRightyContainer:(UIView*)container Cell:(UIView*)cell CellSpacing:(CGFloat)cellSpacing {
    
    // 컨테이너에 마지막 이미지뷰
    UIView *lastView = [container.subviews lastObject] ;
    
    // 컨테이너에 관계설정 확인
    for(NSLayoutConstraint *constraint in container.constraints) {
        
        // 컨테이너와 마지막 뷰의 관계
        if(constraint.firstItem == lastView || constraint.secondItem == lastView) {
            
            // 컨테이너와 마지막 뷰의 관계 중 Bottom : Bottom
            if(constraint.firstAttribute == NSLayoutAttributeTrailing && constraint.secondAttribute == NSLayoutAttributeTrailing) {
                
                // 관계 제거
                [container removeConstraint:constraint] ;
                
            }
            
        }
        
    }
    
    // 컨테이너에 로우 추가
    [container addSubview:cell] ;
    
    // 서브뷰 관계 설정
    cell.translatesAutoresizingMaskIntoConstraints = NO ;
    
    NSLayoutConstraint *constHeight = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:cell.frame.size.height] ;
    
    NSLayoutConstraint *constTop = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeTop multiplier:1 constant:0.0f] ;
    
    NSLayoutConstraint *constBottom = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeBottom multiplier:1 constant:0.0f] ;
    
    NSLayoutConstraint *constLeft = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeLeading multiplier:1 constant:0.0f] ;
    
    NSLayoutConstraint *constRight = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeTrailing multiplier:1 constant:0.0f] ;
    
    
    // 2번째 뷰 부터는 상단 : 직전 뷰 우측의 관계 설정
    if(container.subviews.count > 1) {
        
        constRight = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:lastView attribute:NSLayoutAttributeTrailing multiplier:1 constant:cellSpacing] ;
        
    }
    
    [cell.superview addConstraint:constHeight] ;
    [cell.superview addConstraint:constTop] ;
    [cell.superview addConstraint:constBottom] ;
    [cell.superview addConstraint:constLeft] ;
    [cell.superview addConstraint:constRight] ;
    
}




//아래로 Item의 높이만큼
+ (void)addViewBottomInContainer:(UIView*)container Cell:(UIView*)cell CellSpacing:(CGFloat)cellSpacing index:(NSInteger)index dataCount:(NSInteger)dataCount {
    
    [container addSubview:cell] ;
    
    cell.translatesAutoresizingMaskIntoConstraints = NO ;
    
    // 뷰 상단을 컨테이너 상단에 맞춤
    NSLayoutConstraint *constTop = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeTop multiplier:1 constant:cellSpacing] ;
    
    NSLayoutConstraint *constHeight = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:cell.frame.size.height] ;
    
    NSLayoutConstraint *constright = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeRight multiplier:1 constant:0] ;
    
    NSLayoutConstraint *constleft = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeLeft multiplier:1 constant:0] ;
    
    if (index == 0) {
        // 뷰 상단을 컨테이너 상단에 맞춤
        constTop = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeTop multiplier:1 constant:0] ;
    } else {
        // 두번째 이후부터   전 뷰 아래로 위치
        constTop = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:[container.subviews objectAtIndex:(index-1)] attribute:NSLayoutAttributeBottom multiplier:1 constant:cellSpacing] ;
    }
    
    [cell.superview addConstraint:constHeight] ;
    [cell.superview addConstraint:constleft] ;
    [cell.superview addConstraint:constright] ;
    [cell.superview addConstraint:constTop] ;
    
    
    //1개의 데이터만 올때에는 Container의 높이와 같아야 에러가 나지않는다.
    //1개의 높이가 정해져 있고 Bottom을 정하는순간 높이가 Container의 높이로 맞춰지는데 에러가난다.
    
    if (dataCount==1 || dataCount==2) {
        NSLog(@"스킵") ;
        return ;
    }else {
        if (index == (dataCount-1)) {
            NSLayoutConstraint *constBottom = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeBottom multiplier:1 constant:0.0f] ;
            [cell.superview addConstraint:constBottom] ;
        }
    }
    
    
    
}


//오른쪽으로
+ (void)addViewTrailingInContainer:(UIView*)container Cell:(UIView*)cell CellSpacing:(CGFloat)cellSpacing index:(NSInteger)index dataCount:(NSInteger)dataCount {
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    [container addSubview:cell] ;
    
    cell.translatesAutoresizingMaskIntoConstraints = NO ;

    // 뷰 상단을 컨테이너 상단에 맞춤
    NSLayoutConstraint *constTop = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeTop multiplier:1 constant:0] ;
    
    NSLayoutConstraint *constBottom = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeBottom multiplier:1 constant:0] ;
    
    NSLayoutConstraint *constWidth = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:screenWidth] ;
    
    NSLayoutConstraint *constleft = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeLeft multiplier:1 constant:0] ;
    
    
    if (index == 0) {
        // 뷰 상단을 컨테이너 왼쪽에 맞춤
        constleft = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeLeft multiplier:1 constant:0] ;
    } else {
        // 두번째 이후부터   전 뷰 아래로 위치
        constleft = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:[container.subviews objectAtIndex:(index-1)] attribute:NSLayoutAttributeTrailing multiplier:1 constant:0.0f] ;
    }
    
    [cell.superview addConstraint:constTop] ;
    [cell.superview addConstraint:constBottom] ;
    [cell.superview addConstraint:constWidth] ;
    [cell.superview addConstraint:constleft] ;
    
    //마지막 일때
    if (index == (dataCount-1)) {
        
       NSLayoutConstraint *constright = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeRight multiplier:1 constant:0] ;
        [cell.superview addConstraint:constright] ;
        
    }
    
}



+ (void)addViewTrailingInContainerWithWidthSize:(UIView*)container Cell:(UIView*)cell WidthSize:(CGFloat)widthSize CellSpacing:(CGFloat)cellSpacing index:(NSInteger)index dataCount:(NSInteger)dataCount {
    
    [container addSubview:cell] ;
    
    cell.translatesAutoresizingMaskIntoConstraints = NO ;
    
    // 뷰 상단을 컨테이너 상단에 맞춤
    NSLayoutConstraint *constTop = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeTop multiplier:1 constant:0] ;
    
    NSLayoutConstraint *constBottom = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeBottom multiplier:1 constant:0] ;
    
    NSLayoutConstraint *constWidth = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:widthSize] ;
    
    NSLayoutConstraint *constleft = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeLeft multiplier:1 constant:0] ;
    
    
    if (index == 0) {
        // 뷰 상단을 컨테이너 왼쪽에 맞춤
        constleft = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeLeft multiplier:1 constant:0] ;
    } else {
        // 두번째 이후부터   전 뷰 옆으로
        constleft = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:[container.subviews objectAtIndex:(index-1)] attribute:NSLayoutAttributeTrailing multiplier:1 constant:0.0f] ;
    }
    
    [cell.superview addConstraint:constTop] ;
    [cell.superview addConstraint:constBottom] ;
    [cell.superview addConstraint:constWidth] ;
    [cell.superview addConstraint:constleft] ;
    
    //마지막 일때
    if (index == (dataCount-1)) {
        
        NSLayoutConstraint *constright = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeRight multiplier:1 constant:0] ;
        [cell.superview addConstraint:constright] ;
        
    }

    
}




//아래로 높이 보내는
+ (void)addViewBottomInContainerWithHeight:(UIView*)container Cell:(UIView*)cell HeightSize:(CGFloat)HeightSize CellSpacing:(CGFloat)cellSpacing index:(NSInteger)index dataCount:(NSInteger)dataCount AllHeight:(CGFloat)AllHeight {
    
    NSLog(@"container : %f",container.frame.size.height);
    NSLog(@"AllHeight : %f",AllHeight);
    
    [container addSubview:cell] ;
    
    cell.translatesAutoresizingMaskIntoConstraints = NO ;
    
    // 뷰 상단을 컨테이너 상단에 맞춤
    NSLayoutConstraint *constTop = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeTop multiplier:1 constant:cellSpacing] ;
    
    NSLayoutConstraint *constHeight = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:HeightSize] ;
    
    NSLayoutConstraint *constright = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeRight multiplier:1 constant:0] ;
    
    NSLayoutConstraint *constleft = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeLeft multiplier:1 constant:0] ;
    
    if (index == 0) {
        // 뷰 상단을 컨테이너 상단에 맞춤
        constTop = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeTop multiplier:1 constant:0] ;
    } else {
        // 두번째 이후부터   전 뷰 아래로 위치
        constTop = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:[container.subviews objectAtIndex:(index-1)] attribute:NSLayoutAttributeBottom multiplier:1 constant:cellSpacing] ;
    }
    
    [cell.superview addConstraint:constHeight] ;
    [cell.superview addConstraint:constleft] ;
    [cell.superview addConstraint:constright] ;
    [cell.superview addConstraint:constTop] ;
    
    
    //1개의 데이터만 올때에는 Container의 높이와 같아야 에러가 나지않는다.
    //1개의 높이가 정해져 있고 Bottom을 정하는순간 높이가 Container의 높이로 맞춰지는데 에러가난다.
    
//    NSLog(@" index : %ld ==   %ld:(dataCOunt-1)",index , dataCount-1) ;
    
    if (index == (dataCount-1) && (AllHeight>=container.frame.size.height)) {
//        NSLog(@"바텀");
        NSLayoutConstraint *constBottom = [NSLayoutConstraint constraintWithItem:cell attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeBottom multiplier:1 constant:0.0f] ;
        [cell.superview addConstraint:constBottom] ;
    }
    
    
    
}



@end
