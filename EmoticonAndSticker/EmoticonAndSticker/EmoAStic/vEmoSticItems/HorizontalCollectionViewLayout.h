//
//  HorizontalCollectionViewLayout.h
//  emotionKeyboard
//
//  Created by 김주영 on 2015. 11. 21..
//  Copyright © 2015년 Misslee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HorizontalCollectionViewLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) CGSize cItemSize;
@property (nonatomic, assign) NSInteger pageCount;

@end
