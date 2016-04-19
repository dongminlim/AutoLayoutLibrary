//
//  addViewItem.m
//  AddViewUtil
//
//  Created by  Nomad on 2016. 4. 19..
//  Copyright © 2016년 dongmin. All rights reserved.
//

#import "addViewItem.h"

@implementation addViewItem

- (id)initWithLoadXib
{
    self=[super init] ;
    if(self)
    {
        self=[[[NSBundle mainBundle]loadNibNamed:@"addViewItem" owner:self options:nil] objectAtIndex:0];
    }
    
    return self ;
}

@end
