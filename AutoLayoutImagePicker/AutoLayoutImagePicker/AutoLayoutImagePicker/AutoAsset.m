//
//  AutoAsset.m
//  AutoLayoutImagePicker
//
//  Created by  Nomad on 2016. 4. 26..
//  Copyright © 2016년 dongmin. All rights reserved.
//

#import "AutoAsset.h"

@implementation AutoAsset

- (id)initWithAsset:(ALAsset*)asset
{
    self = [super init];
    if (self) {
        self.asset = asset;
        _selected = NO;
    }
    return self;
}

- (void)toggleSelection
{
    self.selected = !self.selected;
}

@end
