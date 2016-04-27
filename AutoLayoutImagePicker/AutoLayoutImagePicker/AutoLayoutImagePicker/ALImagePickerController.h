//
//  ALImagePickerController.h
//  AutoLayoutImagePicker
//
//  Created by  Nomad on 2016. 4. 27..
//  Copyright © 2016년 dongmin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@class ALImagePickerController;

@protocol VCPictureSelectDelegate <NSObject>

- (void)selectedPicture:(NSMutableArray *)arData picker:(ALImagePickerController *)picker;

@end

@interface ALImagePickerController : UIViewController

@property (nonatomic, weak) id delegate;
@property (nonatomic, weak) id cancelDelegate;
@property (nonatomic, assign) NSInteger maximumImagesCount;
@property (nonatomic, strong) ALAssetsGroup *assetGroup;


@end