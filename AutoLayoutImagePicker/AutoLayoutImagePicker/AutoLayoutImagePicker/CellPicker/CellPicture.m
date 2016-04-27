//
//  CellPicture.m
//  projectHelper
//
//  Created by  Nomad on 2016. 4. 26..
//  Copyright © 2016년 dongmin. All rights reserved.
//

#import "CellPicture.h"
@interface CellPicture()
@property (strong, nonatomic) IBOutlet UIImageView *ivImage;


@end

@implementation CellPicture

- (void)awakeFromNib {
    // Initialization code
}

- (void)setAssets:(AutoAsset *)assets {
    _item = assets;
    _ivImage.image = [UIImage imageWithCGImage:assets.asset.thumbnail];
}

@end
