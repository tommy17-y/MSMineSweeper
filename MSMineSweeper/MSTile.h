//
//  MSTile.h
//  MSMineSweeper
//
//  Created by Yuki Tomiyoshi on 2014/12/30.
//  Copyright (c) 2014年 Yuki Tomiyoshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSTile : UIButton {
    // 地雷かどうか
    BOOL mine;
    // 空いているかどうか
    BOOL open;
    // フラグが立っているかどうか
    BOOL flag;
}

- (void)setMine:(BOOL)x;
- (void)setOpen:(BOOL)x;
- (void)setFlag:(BOOL)x;

- (BOOL)getMine;
- (BOOL)getOpen;
- (BOOL)getFlag;

@end
