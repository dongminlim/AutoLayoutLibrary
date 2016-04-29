//
//  VCEmoStic.m
//  EmoticonAndSticker
//
//  Created by  Nomad on 2016. 4. 21..
//  Copyright © 2016년 dongmin. All rights reserved.
//

#import "VCEmoStic.h"
#import "VEmoStic.h"
#import "EmoAStic.h"
@interface VCEmoStic ()
<VEmoSticDelegate>
@property (strong, nonatomic) IBOutlet UIView *vEmotionContainer;
@property (strong, nonatomic) IBOutlet UILabel *lbEmoticon;

@end

@implementation VCEmoStic

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [EmoAStic convertStrToEmoticon:_lbEmoticon];
    
    NSLog(@"_lbEmoticon : %@",_lbEmoticon.attributedText);
    NSLog(@"반대로 : %@",[EmoAStic convertEmotionToStr:_lbEmoticon]);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    
    VEmoStic *vEmo = [[VEmoStic alloc] initWithLoadXib];
    [vEmo setDelegate:self];
    [_vEmotionContainer addSubview:vEmo];
    [vEmo setFrame:CGRectMake(0, 0, _vEmotionContainer.frame.size.width, _vEmotionContainer.frame.size.height)];
    [vEmo setBottomBtn];
    [vEmo setEmoSticWithIndex:0];

}


- (void)didTouchedEmoSticItem:(NSDictionary *)dtInfo {
    
    NSLog(@"didTouchedEmoSticItem : %@",dtInfo);
    
}



@end
