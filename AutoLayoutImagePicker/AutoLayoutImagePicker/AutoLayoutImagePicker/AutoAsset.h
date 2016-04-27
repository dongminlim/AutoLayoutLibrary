//
//  AutoAsset.h
//  AutoLayoutImagePicker
//
//  Created by  Nomad on 2016. 4. 26..
//  Copyright © 2016년 dongmin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface AutoAsset : NSObject

@property (nonatomic, strong) ALAsset *asset;
@property (nonatomic, assign) BOOL selected;
- (id)initWithAsset:(ALAsset *)asset;

@end
