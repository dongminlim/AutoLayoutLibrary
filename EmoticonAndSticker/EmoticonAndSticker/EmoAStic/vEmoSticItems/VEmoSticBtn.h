//
//  VEmoSticBtn.h
//  EmoticonAndSticker
//
//  Created by  Nomad on 2016. 4. 21..
//  Copyright © 2016년 dongmin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VEmoSticBtn : UIView

- (id)initWithLoadXib:(NSDictionary *)dtInfo;
@property (strong, nonatomic) IBOutlet UIButton *btItem;

@end
