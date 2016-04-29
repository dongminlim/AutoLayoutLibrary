//
//  EmoAStic.h
//  EmoticonAndSticker
//
//  Created by  Nomad on 2016. 4. 28..
//  Copyright © 2016년 dongmin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EmoAStic : NSObject

//텍스트 - > 이모티콘
+ (void)convertStrToEmoticon:(UILabel *)lbTarget;

//이모티콘 - > 텍스트
+ (NSString*)convertEmotionToStr:(UILabel *)lbTarget;

@end
