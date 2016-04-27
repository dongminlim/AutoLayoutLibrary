//
//  VCAlbumList.h
//  AutoLayoutImagePicker
//
//  Created by  Nomad on 2016. 4. 27..
//  Copyright © 2016년 dongmin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALImagePickerController.h"

@class ALImagePickerController;
@class VCAlbumList;

@protocol ALImagePickerControllerDelegate <NSObject>

- (void)alImagePickerController:(ALImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info;
- (void)alImagePickerControllerDidCancel:(VCAlbumList *)picker;

@end

@interface VCAlbumList : UIViewController

@property (nonatomic, weak) id delegate;
@property (nonatomic, assign) NSInteger maximumImagesCount;

@end
