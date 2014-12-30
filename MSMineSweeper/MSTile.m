//
//  MSTile.m
//  MSMineSweeper
//
//  Created by Yuki Tomiyoshi on 2014/12/30.
//  Copyright (c) 2014年 Yuki Tomiyoshi. All rights reserved.
//

#import "MSTile.h"

@implementation MSTile

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        mine = NO;
        open = NO;
        flag = NO;
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;

    }
    return self;
}

- (void)setMine:(BOOL)x {
    mine = x;
}

- (void)setOpen:(BOOL)x {
    open = x;
}

- (void)setFlag:(BOOL)x {
    flag = x;
}

- (BOOL)getMine {
    return mine;
}

- (BOOL)getOpen {
    return  open;
}

- (BOOL)getFlag {
    return flag;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end