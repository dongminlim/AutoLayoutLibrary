//
//  ViewUtil.h
//  DukkubiSesang
//
//  Created by dev01 on 2015. 9. 21..
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ViewUtil : NSObject

//View를 밑으로 붙이기(넓이를 화면크기)
+ (void)addViewBottomByContainer:(UIView*)container Cell:(UIView*)cell CellSpacing:(CGFloat)cellSpacing ;

//View를 오른쪽으로 붙이기(넓이를 화면크기)
+ (void)addViewRightyContainer:(UIView*)container Cell:(UIView*)cell CellSpacing:(CGFloat)cellSpacing ;

//View아래로 화면 크기만큼의 넓이
+ (void)addViewBottomInContainer:(UIView*)container Cell:(UIView*)cell CellSpacing:(CGFloat)cellSpacing index:(NSInteger)index dataCount:(NSInteger)dataCount;

//Viewd옆으로 화면 크기만큼의 넓이
+ (void)addViewTrailingInContainer:(UIView*)container Cell:(UIView*)cell CellSpacing:(CGFloat)cellSpacing index:(NSInteger)index dataCount:(NSInteger)dataCount;

//특정 넓이로 view옆으로 붙이기
+ (void)addViewTrailingInContainerWithWidthSize:(UIView*)container Cell:(UIView*)cell WidthSize:(CGFloat)widthSize CellSpacing:(CGFloat)cellSpacing index:(NSInteger)index dataCount:(NSInteger)dataCount;

//특정 높이로 view아래로 붙이기
+ (void)addViewBottomInContainerWithHeight:(UIView*)container Cell:(UIView*)cell HeightSize:(CGFloat)HeightSize CellSpacing:(CGFloat)cellSpacing index:(NSInteger)index dataCount:(NSInteger)dataCount AllHeight:(CGFloat)AllHeight ;


@end
