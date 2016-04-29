//
//  VEmoStic.h
//  EmoticonAndSticker
//
//  Created by  Nomad on 2016. 4. 21..
//  Copyright © 2016년 dongmin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VEmoSticDelegate <NSObject>

- (void)didTouchedEmoSticItem:(NSDictionary *)dtInfo;

@end

@interface VEmoStic : UIView
//뷰 로드
- (id)initWithLoadXib;
//메뉴 세팅
- (void)setBottomBtn;
//이모티콘 스티커 뷰 세팅
- (void)setEmoSticWithIndex:(NSInteger)idx;

@property (weak, nonatomic) id delegate;
@property (nonatomic) NSInteger currentIndex;

@end
