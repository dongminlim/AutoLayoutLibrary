//
//  VCMain.m
//  AutoLayoutImagePicker
//
//  Created by  Nomad on 2016. 4. 26..
//  Copyright © 2016년 dongmin. All rights reserved.
//

#import "VCMain.h"
#import "VCAlbumList.h"
@interface VCMain ()
<ALImagePickerControllerDelegate>

@end

@implementation VCMain

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBtnAlbumGoTouch:(id)sender {
    
    VCAlbumList *iVCAlbumList = [[VCAlbumList alloc]init];
    [iVCAlbumList setDelegate:self];
    iVCAlbumList.maximumImagesCount = 3;
    [self.navigationController pushViewController:iVCAlbumList animated:NO];
    
}


- (void)alImagePickerController:(ALImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info {
    
    NSLog(@"didFinishPickingMediaWithInfo : %@",info);
    
}

- (void)alImagePickerControllerDidCancel:(VCAlbumList *)picker {
    NSLog(@"alImagePickerControllerDidCancel");
}


@end
