//
//  CellPicture.h
//  projectHelper
//
//  Created by  Nomad on 2016. 4. 26..
//  Copyright © 2016년 dongmin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoAsset.h"
@interface CellPicture : UICollectionViewCell
@property (strong, nonatomic) AutoAsset *item;
@property (strong, nonatomic) IBOutlet UILabel *lbCheck;
- (void)setAssets:(AutoAsset *)assets;
@property (weak, nonatomic) id delegate;

@end
