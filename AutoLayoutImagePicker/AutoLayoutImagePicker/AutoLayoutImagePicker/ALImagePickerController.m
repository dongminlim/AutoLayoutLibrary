//
//  ALImagePickerController.m
//  AutoLayoutImagePicker
//
//  Created by  Nomad on 2016. 4. 27..
//  Copyright © 2016년 dongmin. All rights reserved.
//

#import "ALImagePickerController.h"
#import "AutoAsset.h"
#import <CoreLocation/CoreLocation.h>
#import "CellPicture.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ALImagePickerController ()
<UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *lbTItle;
@property (strong, nonatomic) IBOutlet UICollectionView *cvPicture;
@property (strong, nonatomic) NSMutableArray *arPicture;
@property (strong, nonatomic) NSMutableArray *tempArr;
@property (strong, nonatomic) NSMutableArray *returnArray;

@end

@implementation ALImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tempArr = [NSMutableArray new];
    _arPicture = [NSMutableArray new];
    [_cvPicture setDataSource:self];
    [_cvPicture setDelegate:self];
    
    UINib* nib = [UINib nibWithNibName:@"CellPicture" bundle:nil];
    [_cvPicture registerNib:nib forCellWithReuseIdentifier:@"CellPicture"];
    
    [self performSelectorInBackground:@selector(preparePhotos) withObject:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBtnBackTouch:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)onBtnSelectTouch:(id)sender {
    
    NSMutableArray *assets = [NSMutableArray new];
    for (AutoAsset *item in _arPicture) {
        if (item.selected) {
            [assets addObject:item.asset];
        }
        
    }
    
    _returnArray = [[NSMutableArray alloc] init];
    
    for(ALAsset *asset in assets) {
        id obj = [asset valueForProperty:ALAssetPropertyType];
        if (!obj) {
            continue;
        }
        NSMutableDictionary *workingDictionary = [[NSMutableDictionary alloc] init];
        
        CLLocation* wgs84Location = [asset valueForProperty:ALAssetPropertyLocation];
        if (wgs84Location) {
            [workingDictionary setObject:wgs84Location forKey:ALAssetPropertyLocation];
        }
        
        [workingDictionary setObject:obj forKey:UIImagePickerControllerMediaType];
        
        //This method returns nil for assets from a shared photo stream that are not yet available locally. If the asset becomes available in the future, an ALAssetsLibraryChangedNotification notification is posted.
        ALAssetRepresentation *assetRep = [asset defaultRepresentation];
        
        if(assetRep != nil) {
            CGImageRef imgRef = nil;
            //defaultRepresentation returns image as it appears in photo picker, rotated and sized,
            //so use UIImageOrientationUp when creating our image below.
            UIImageOrientation orientation = UIImageOrientationUp;
            
            imgRef = [assetRep fullScreenImage];
            
            UIImage *img = [UIImage imageWithCGImage:imgRef
                                               scale:1.0f
                                         orientation:orientation];
            [workingDictionary setObject:img forKey:UIImagePickerControllerOriginalImage];
            [workingDictionary setObject:[[asset valueForProperty:ALAssetPropertyURLs] valueForKey:[[[asset valueForProperty:ALAssetPropertyURLs] allKeys] objectAtIndex:0]] forKey:UIImagePickerControllerReferenceURL];
            
            [_returnArray addObject:workingDictionary];
        }
        
    }
    
    if( _delegate && [_delegate respondsToSelector:@selector(selectedPicture:picker:)]) {
        [_delegate selectedPicture:_returnArray picker:self];
    }
    
    [self.navigationController popToViewController:_cancelDelegate animated:NO];

}


- (void)preparePhotos
{
    @autoreleasepool {
        
        [self.assetGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            
            if (result == nil) {
                return;
            }
            
            AutoAsset *elcAsset = [[AutoAsset alloc] initWithAsset:result];
            [_arPicture addObject:elcAsset];
            
        }];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [_cvPicture reloadData];
            
        });
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _arPicture.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"CellPicture";
    CellPicture *cell = (CellPicture*)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (cell == nil)
    {
        NSArray *array;
        array = [[NSBundle mainBundle] loadNibNamed:@"CellPicture" owner:self options:nil];
        cell = (CellPicture*)[array objectAtIndex:0];
    }
    
    [cell setAssets:[_arPicture objectAtIndex:[indexPath row]]];
    if (cell.item.selected) {
        [cell.lbCheck setHidden:NO];
    }else {
        [cell.lbCheck setHidden:YES];
    }
    
    return cell;
    
}

// 컬렉션 크기
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    float width = (_cvPicture.frame.size.width) / 3;
    return CGSizeMake(width, width);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSLog(@"_maximumImagesCount : %ld",_maximumImagesCount);
    
    CellPicture *cell = (CellPicture*)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (cell.item.selected) {
        
        cell.item.selected = NO;
        [cell.lbCheck setHidden:YES];
        [_tempArr removeObject:cell.item];
        
    }else {
        
        if (_maximumImagesCount != 0 && _maximumImagesCount == _tempArr.count) {
            
            NSString *title = [NSString stringWithFormat:NSLocalizedString(@"", nil), self.maximumImagesCount];
            NSString *message = [NSString stringWithFormat:NSLocalizedString(@"사진은 %d개까지 선택 가능합니다.", nil), self.maximumImagesCount];
            [[[UIAlertView alloc] initWithTitle:title
                                        message:message
                                       delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:NSLocalizedString(@"확인", nil), nil] show];
            return;
        }
        
        cell.item.selected = YES;
        [cell.lbCheck setHidden:NO];
        [_tempArr addObject:cell.item];
    }
    
}

@end