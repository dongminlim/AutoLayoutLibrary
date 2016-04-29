//
//  VEmoStic.m
//  EmoticonAndSticker
//
//  Created by  Nomad on 2016. 4. 21..
//  Copyright © 2016년 dongmin. All rights reserved.
//

#import "VEmoStic.h"
#import "VEmoSticBtn.h"
#import "CellEmoStic.h"
#import "ViewUtil.h"
#import "HorizontalCollectionViewLayout.h"

@interface VEmoStic ()
<UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) NSMutableArray *arEmoAStic;
@property (strong, nonatomic) IBOutlet UIView *vBottomContainer;
@property (strong, nonatomic) IBOutlet UICollectionView *cvSticEmo;
@property (strong, nonatomic) IBOutlet UIPageControl *pcPager;
@property (strong, nonatomic) HorizontalCollectionViewLayout *collectionViewLayout;

@end

@implementation VEmoStic

- (id)initWithLoadXib {

    self=[super init] ;
    if(self)
    {
        self=[[[NSBundle mainBundle]loadNibNamed:@"VEmoStic" owner:self options:nil] objectAtIndex:0];
    }
    
    _collectionViewLayout = [HorizontalCollectionViewLayout new];
    
    UINib* nib = [UINib nibWithNibName:@"CellEmoStic" bundle:nil];
    [_cvSticEmo registerNib:nib forCellWithReuseIdentifier:@"CellEmoStic"];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"EmoSticInfoList" ofType:@"plist"];
    NSDictionary *dtEmoStic = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    NSArray *arEmoticon = [dtEmoStic objectForKey:@"emoticon"];
    NSArray *arSticker = [dtEmoStic objectForKey:@"sticker"];
    
    _currentIndex = 0;

    _arEmoAStic = [NSMutableArray new];
    [_arEmoAStic addObject:arEmoticon];
    [_arEmoAStic addObjectsFromArray:arSticker];
    
    [_cvSticEmo setDataSource:self];
    [_cvSticEmo setDelegate:self];
    
    return self ;
    
}

//밑 버튼 메뉴 셋팅
- (void)setBottomBtn {
    
    for (NSInteger i = 0; i < _arEmoAStic.count; i++) {
        
        NSArray *arInfo = [_arEmoAStic objectAtIndex:i];
        VEmoSticBtn *vBtn = [[VEmoSticBtn alloc] initWithLoadXib:[arInfo objectAtIndex:0]];
        [vBtn.btItem setTag:i];
        [vBtn.btItem addTarget:self action:@selector(onBtnBottomItemTouch:) forControlEvents:UIControlEventTouchUpInside];
        [ViewUtil addViewTrailingInContainerWithWidthSize:_vBottomContainer Cell:vBtn WidthSize:_vBottomContainer.frame.size.height CellSpacing:0 index:i dataCount:_arEmoAStic.count];
        
    }
    
}

//밑에 버튼 클릭 이벤트
- (IBAction)onBtnBottomItemTouch:(id)sender {
    
    if ([sender tag] == _currentIndex) {
        return;
    }
    
    [self setEmoSticWithIndex:[sender tag]];

}


- (void)setEmoSticWithIndex:(NSInteger)idx {
    
    float width, height;
    
    //0번째가 이모티콘이 항상 온다고 가정
    if (idx == 0) {
        width = _cvSticEmo.frame.size.width / 6;
        height = _cvSticEmo.frame.size.height / 3;
    }else {
        width = _cvSticEmo.frame.size.width / 4;
        height = _cvSticEmo.frame.size.height / 2;
    }
    
    NSInteger pageCount = 0;
    NSMutableArray  *arItems = [_arEmoAStic objectAtIndex:idx];
    if (idx != 0) {
        NSInteger   mod = arItems.count % 8;
        if (mod > 0) {
            pageCount = (arItems.count / 8) + 1;
        }
        else pageCount = arItems.count / 8;
    }
    else {
        NSInteger   mod = arItems.count % 18;
        if (mod > 0) {
            pageCount = (arItems.count / 18) + 1;
        }
        else pageCount = arItems.count / 18;
    }
    
    [_pcPager setNumberOfPages:pageCount];
    [_pcPager setCurrentPage:0];
    
    _collectionViewLayout.itemSize = CGSizeMake(width, height);
    _collectionViewLayout.pageCount = 0;
    _collectionViewLayout.cItemSize = CGSizeMake(width, height);
    _collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [_cvSticEmo.collectionViewLayout invalidateLayout];
    [_cvSticEmo setCollectionViewLayout:_collectionViewLayout];
    
    _currentIndex = idx;
    [_cvSticEmo reloadData];
    
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray  *arItems = [_arEmoAStic objectAtIndex:_currentIndex];
    return arItems.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"CellEmoStic";
    CellEmoStic *cell = (CellEmoStic*)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (cell == nil)
    {
        NSArray *array;
        array = [[NSBundle mainBundle] loadNibNamed:@"CellEmoStic" owner:self options:nil];
        cell = (CellEmoStic*)[array objectAtIndex:0];
    }
    
    NSArray  *arItems = [_arEmoAStic objectAtIndex:_currentIndex];
    NSDictionary  *item = [arItems objectAtIndex:[indexPath row]];
    cell.ivItem.image = [UIImage imageNamed:[item objectForKey:@"imageName"]];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"didSelectItemAtIndexPath");
    if( _delegate && [_delegate respondsToSelector:@selector(didTouchedEmoSticItem:)]) {
        NSArray  *arItems = [_arEmoAStic objectAtIndex:_currentIndex];
        NSDictionary  *item = [arItems objectAtIndex:[indexPath row]];
        [_delegate didTouchedEmoSticItem:item];
    }

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = _cvSticEmo.frame.size.width;
    float currentPage = _cvSticEmo.contentOffset.x / pageWidth;
    
    if (0.0f != fmodf(currentPage, 1.0f)) {
        _pcPager.currentPage = currentPage + 1;
    }
    else {
        _pcPager.currentPage = currentPage;
    }
    
}

@end
