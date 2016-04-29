//
//  EmoAStic.m
//  EmoticonAndSticker
//
//  Created by  Nomad on 2016. 4. 28..
//  Copyright © 2016년 dongmin. All rights reserved.
//

#import "EmoAStic.h"

@implementation EmoAStic

+ (void)convertStrToEmoticon:(UILabel *)lbTarget {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"EmoSticInfoList" ofType:@"plist"];
    NSDictionary *dtEmoStic = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    NSArray *arEmoticon = [dtEmoStic objectForKey:@"emoticon"];
    //텍스트를 담고
    NSMutableAttributedString *MAStr = (NSMutableAttributedString*)lbTarget.attributedText;
    
    for (NSInteger i = 0; i < arEmoticon.count; i++) {
        NSDictionary *dtEmotion = [arEmoticon objectAtIndex:i];
        NSString *strEmoticon = [dtEmotion objectForKey:@"emoticonName"];
        NSRange r = [[MAStr string] rangeOfString:strEmoticon];
        
        while (r.location != NSNotFound) {
            NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
            textAttachment.image = [UIImage imageNamed:[dtEmotion objectForKey:@"imageName"]];
            [textAttachment.image setAccessibilityIdentifier:strEmoticon];
            textAttachment.bounds = CGRectMake(0,-3,lbTarget.font.lineHeight,lbTarget.font.lineHeight);
            NSAttributedString* AStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
            [MAStr replaceCharactersInRange:r withAttributedString:AStr];
            r = [[MAStr string] rangeOfString:[dtEmotion objectForKey:@"emoticonName"]];
            
        }
        
    }
    
    lbTarget.attributedText = MAStr;
    
}

+ (NSString*)convertEmotionToStr:(UILabel *)lbTarget {
    __block NSString *str = lbTarget.attributedText.string;
    __block NSMutableString *final= [NSMutableString new];
    
    [lbTarget.attributedText enumerateAttributesInRange:NSMakeRange(0, lbTarget.attributedText.length) options:0 usingBlock:
     ^(NSDictionary *attributes, NSRange range, BOOL *stop) {
         
         NSString *v;
         NSTextAttachment* x = [attributes valueForKey:@"NSAttachment"];
         
         if(x)
         {
             v = x.image.accessibilityIdentifier;
             if(v == nil) v = @"";
             NSLog(@"v : %@",v);
         }
         else {
             v = [str substringWithRange:range];
         }
         
         [final appendString:v];
     }];
    
    return final;
}


@end
