//
//  VCAlbumList.m
//  AutoLayoutImagePicker
//
//  Created by  Nomad on 2016. 4. 27..
//  Copyright © 2016년 dongmin. All rights reserved.
//

#import "VCAlbumList.h"
#import "AutoAsset.h"
#import "CellAlbum.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface VCAlbumList ()
<UITableViewDataSource, UITableViewDelegate, VCPictureSelectDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tvAlbum;
@property (strong, nonatomic) NSMutableArray *arAlbumList;
@property (nonatomic, strong) ALAssetsLibrary *library;

@end

@implementation VCAlbumList

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _library = [[ALAssetsLibrary alloc] init];
    _arAlbumList = [NSMutableArray new];
    [_tvAlbum setDataSource:self];
    [_tvAlbum setDelegate:self];
    
    // Load Albums into assetGroups
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       @autoreleasepool {
                           
                           // Group enumerator Block
                           void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop)
                           {
                               if (group == nil) {
                                   return;
                               }
                               
                               // added fix for camera albums order
                               NSString *sGroupPropertyName = (NSString *)[group valueForProperty:ALAssetsGroupPropertyName];
                               NSUInteger nType = [[group valueForProperty:ALAssetsGroupPropertyType] intValue];
                               
                               if ([[sGroupPropertyName lowercaseString] isEqualToString:@"camera roll"] && nType == ALAssetsGroupSavedPhotos) {
                                   [_arAlbumList insertObject:group atIndex:0];
                               }
                               else {
                                   [_arAlbumList addObject:group];
                               }
                               
                               // Reload albums
                               [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:YES];
                           };
                           
                           // Group Enumerator Failure Block
                           void (^assetGroupEnumberatorFailure)(NSError *) = ^(NSError *error) {
                               
                               UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Album Error: %@ - %@", [error localizedDescription], [error localizedRecoverySuggestion]] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                               [alert show];
                               
                               NSLog(@"A problem occured %@", [error description]);
                           };
                           
                           // Enumerate Albums
                           [self.library enumerateGroupsWithTypes:ALAssetsGroupAll
                                                       usingBlock:assetGroupEnumerator
                                                     failureBlock:assetGroupEnumberatorFailure];
                           
                       }
                   });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBtnBackTouch:(id)sender {
    
    if( _delegate && [_delegate respondsToSelector:@selector(alImagePickerControllerDidCancel:)]) {
        [_delegate alImagePickerControllerDidCancel:self];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)reloadTableView {
    [_tvAlbum reloadData];
}


#pragma mark - TableView
//Remove Auto Inset
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

//섹션마다 셀의 수
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _arAlbumList.count;
    
}

//셀 리턴
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"CellAlbum";
    CellAlbum *cell = (CellAlbum*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        NSArray *array;
        array = [[NSBundle mainBundle] loadNibNamed:@"CellAlbum" owner:self options:nil];
        cell = (CellAlbum*)[array objectAtIndex:0];
    }
    
    // Get count
    ALAssetsGroup *g = (ALAssetsGroup*)[_arAlbumList objectAtIndex:indexPath.row];
    [g setAssetsFilter:[ALAssetsFilter allPhotos]];
    NSInteger gCount = [g numberOfAssets];
    
    cell.lbAlbumName.text = [NSString stringWithFormat:@"%@ (%ld)",[g valueForProperty:ALAssetsGroupPropertyName], (long)gCount];
    [cell.ivImage setImage:[UIImage imageWithCGImage:[(ALAssetsGroup*)[_arAlbumList objectAtIndex:indexPath.row] posterImage]]];
    
    return cell ;
    
}

//셀 높이
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ALImagePickerController *iALImagePickerController = [[ALImagePickerController alloc]initWithNibName:@"ALImagePickerController" bundle:nil];
    iALImagePickerController.assetGroup = [_arAlbumList objectAtIndex:[indexPath row]];
    iALImagePickerController.maximumImagesCount = _maximumImagesCount;
    [iALImagePickerController.assetGroup setAssetsFilter:[ALAssetsFilter allPhotos]];
    [iALImagePickerController setDelegate:self];
    iALImagePickerController.cancelDelegate = _delegate;
    [self.navigationController pushViewController:iALImagePickerController animated:YES];
    
}


- (void)selectedPicture:(NSMutableArray *)arData picker:(ALImagePickerController *)picker{
    
    if( _delegate && [_delegate respondsToSelector:@selector(alImagePickerController:didFinishPickingMediaWithInfo:)]) {
        [_delegate alImagePickerController:picker didFinishPickingMediaWithInfo:arData];
    }
    
}

@end
