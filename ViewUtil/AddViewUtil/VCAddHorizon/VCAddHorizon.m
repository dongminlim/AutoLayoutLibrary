//
//  VCAddHorizon.m
//  AddViewUtil
//
//  Created by  Nomad on 2016. 4. 19..
//  Copyright © 2016년 dongmin. All rights reserved.
//

#import "VCAddHorizon.h"
#import "ViewUtil.h"
#import "addViewItem.h"

@interface VCAddHorizon ()

@property (strong, nonatomic) IBOutlet UIView *addViewContainer;

@end

@implementation VCAddHorizon

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //원하는 Uiview를 스크롤 뷰로 감싸진 Container뷰에 addsubview를 한다.
    for (NSInteger i = 0; i < 5; i++) {
        addViewItem *item = [[addViewItem alloc]initWithLoadXib];
        [ViewUtil addViewTrailingInContainer:_addViewContainer Cell:item CellSpacing:0 index:i dataCount:5];
    }
    
    /*
     파라미터 설명
     1. Container : addview되어질 컨테이너 uiview
     2. Cell : addview 대상
     4. CellSpacing : 사이 간격
     5. index : 현재 index값
     6. dataCount : 총 addview 수
     */
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBtnBackTouch:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}




@end
