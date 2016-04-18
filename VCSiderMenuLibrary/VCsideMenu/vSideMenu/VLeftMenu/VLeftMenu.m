//
//  VLeftMenu.m
//  Test
//
//  Created by  Nomad on 2016. 4. 15..
//  Copyright © 2016년 dongmin. All rights reserved.
//

#import "VLeftMenu.h"
#define MENUOPEN 1
#define MENUCLOSE 2
#define _RGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
@interface VLeftMenu()

@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@end

@implementation VLeftMenu

- (id)initAddSubView {
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    if(self = [super init]) {
        _slideStatus = 0 ;
        self = [[[NSBundle mainBundle]loadNibNamed:@"VLeftMenu" owner:self options:nil] firstObject];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gesture:) name:@"gesture" object:nil] ;
    self.frame = CGRectMake(-screenRect.size.width, 0, screenRect.size.width, screenRect.size.height) ;
    _slideStatus = 0;
    return self;
    
}



#pragma mark - Gesture Action
- (void) gesture:(NSNotification *)notification {
    
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self] ;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    _width = screenRect.size.width;
    _height = screenRect.size.height ;
    CGPoint getPoint = CGPointMake([[[notification userInfo] objectForKey:@"pointX"] doubleValue], [[[notification userInfo] objectForKey:@"pointY"] doubleValue]) ;
    //    NSLog(@"slideGesture") ;
    
    id sender = [[notification userInfo] objectForKey:@"sender"];
    
    if ([sender isKindOfClass:UIPanGestureRecognizer.class]) {
        NSLog(@"UIPanGestureRecognizer") ;
        CGPoint point = getPoint ;
        UIPanGestureRecognizer *recognizer = sender ;
        
        switch (recognizer.state) {
            case UIGestureRecognizerStateBegan:
            {
                
                if ( (_slideStatus == 0) && (point.x < 20) ) {
                    
                    _slideStatus = MENUCLOSE ;
                    
                }
                
                if ( (self.frame.size.width - 20 < point.x) && (_slideStatus == MENUOPEN)) {
                    _slideStatus = MENUOPEN ;
                }
                
                _startPoint = point ;
                
            }
                break;
            case UIGestureRecognizerStateChanged:
            {
                CGFloat movePoint = _startPoint.x - point.x;
                
                
                if (_slideStatus == MENUCLOSE) {
                    _vAlpha.hidden = NO ;
                    CGPoint translatedPoint = CGPointMake((self.frame.size.width*-1)-movePoint, self.frame.origin.y);
                    self.frame = CGRectMake(translatedPoint.x, translatedPoint.y, _width, _height) ;
                    NSLog(@"translatedPoint.x : %f",1-((self.frame.origin.x*-1)/320/2));
                    [_vAlpha setBackgroundColor:_RGB(0, 0, 0, ((1-((self.frame.origin.x*-1)/320/2))/2))];
                }
                
                if (_slideStatus == MENUOPEN) {
                    if (movePoint < -1) {
                        return ;
                    }
                    
                    CGPoint translatedPoint = CGPointMake(movePoint*-1, self.frame.origin.y);
                    self.frame = CGRectMake(translatedPoint.x, translatedPoint.y, _width, _height) ;
                }
                
                //NSLog(@"frame : %lf, %lf, %lf %lf",translatedPoint.x,translatedPoint.y, _width, _height) ;
                
            }
                break;
            case UIGestureRecognizerStateEnded:
            case UIGestureRecognizerStateCancelled:
            {
                
                if (self.frame.origin.x > (_width/2)*-1) {
                    
                    NSLog(@"%f",self.frame.origin.x) ;
                    
                    NSLog(@"타켓 열림") ;
                    [UIView animateWithDuration:0.25 animations:^{
                        
                        self.frame = CGRectMake(0, 0, _width, _height) ;
                        
                    } completion: ^(BOOL finished) {
                        
                    }];
                    _slideStatus = MENUOPEN ;
                    
                    if (_delegate && [_delegate respondsToSelector:@selector(leftSideMenuIsOpen:)]) {
                        [_delegate leftSideMenuIsOpen:YES] ;
                    }
                    
                    break ;
                }
                
                //목록 다시 닫힘
                if ( self.frame.origin.x < (_width/2)*-1 ) {
                    _vAlpha.hidden = YES ;
                    NSLog(@"닫힘") ;
                    
                    [UIView animateWithDuration:0.25 animations:^{
                        
                        self.frame = CGRectMake(_width*-1, 0 , _width, _height) ;
                        
                    } completion: ^(BOOL finished) {
                        
                    }];
                    
                    _slideStatus = 0;
                    
                    if (_delegate && [_delegate respondsToSelector:@selector(leftSideMenuIsOpen:)]) {
                        [_delegate leftSideMenuIsOpen:NO] ;
                    }
                    
                    break ;
                }
                
            }
                break;
            case UIGestureRecognizerStateFailed:
            {
                
            }
                break;
        }
        
    }else if ([sender isKindOfClass:UITapGestureRecognizer.class]) {
        NSLog(@"UITapGestureRecognizer") ;
        CGPoint point = getPoint ;
        UITapGestureRecognizer *recognizer = sender ;
        
        switch (_slideStatus) {
            case MENUOPEN:
            {
                
                if (recognizer.state == UIGestureRecognizerStateEnded) {
                    
                    if (self.vMenu.frame.size.width - 50 < point.x) {
                        
                        [UIView animateWithDuration:0.25 animations:^{
                            
                            self.frame = CGRectMake(_width*-1, 0, _width, _height) ;
                            
                        } completion: ^(BOOL finished) {
                            _slideStatus = 0;
                            _vAlpha.hidden = YES ;
                            if (_delegate && [_delegate respondsToSelector:@selector(leftSideMenuIsOpen:)]) {
                                [_delegate leftSideMenuIsOpen:NO] ;
                            }
                        }];
                        
                    }
                    
                }
                
            }
                break;
            case MENUCLOSE:
            {
                
            }
                break;
                
            default:
                break;
        }
        
        
        
    }
    
    
}

- (void)sideOpen {
    _vAlpha.hidden = NO ;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    _width = screenRect.size.width;
    _height = screenRect.size.height ;
    [UIView animateWithDuration:0.25 animations:^{
        
        self.frame = CGRectMake(0, 0, _width, _height) ;
        
    } completion: ^(BOOL finished) {
        
    }];
    _slideStatus = MENUOPEN ;
    
}

- (void)sideClose {
    NSLog(@"sideClose");
    _vAlpha.hidden = YES ;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.frame = CGRectMake(_width*-1, 0, _width, _height) ;
        
    } completion: ^(BOOL finished) {
        
    }];
    
    _slideStatus = 0;
    
}

- (IBAction)onBtnClose:(id)sender {
    
    _vAlpha.hidden = YES ;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.frame = CGRectMake(_width*-1, 0, _width, _height) ;
        
    } completion: ^(BOOL finished) {
        if (_delegate && [_delegate respondsToSelector:@selector(leftSideMenuIsOpen:)]) {
            [_delegate leftSideMenuIsOpen:NO] ;
        }
    }];
    
    _slideStatus = 0;
    
}
@end
