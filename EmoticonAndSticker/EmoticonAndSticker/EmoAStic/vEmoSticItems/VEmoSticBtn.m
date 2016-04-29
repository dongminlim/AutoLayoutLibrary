//
//  VEmoSticBtn.m
//  EmoticonAndSticker
//
//  Created by  Nomad on 2016. 4. 21..
//  Copyright © 2016년 dongmin. All rights reserved.
//

#import "VEmoSticBtn.h"
@interface VEmoSticBtn()


@end

@implementation VEmoSticBtn

- (id)initWithLoadXib:(NSDictionary *)dtInfo {
    
    self=[super init] ;
    if(self)
    {
        self=[[[NSBundle mainBundle]loadNibNamed:@"VEmoSticBtn" owner:self options:nil] objectAtIndex:0];
    }
    
    [_btItem setImage:[UIImage imageNamed:[dtInfo objectForKey:@"imageName"]] forState:UIControlStateNormal];
    
    return self ;
    
}

@end
