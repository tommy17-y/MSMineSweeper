//
//  MSViewController.h
//  MSMineSweeper
//
//  Created by Yuki Tomiyoshi on 2014/12/30.
//  Copyright (c) 2014年 Yuki Tomiyoshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSTile.h"

@interface MSViewController : UIViewController {
    
    // 各マスの辺の長さ
    int width;
    int height;
    
    // 各辺のマス数
    int widthNum;
    int heightNum;
    
    // 地雷数
    int mineNum;
    
    // 開いたタイル数
    int openedTileNum;
    
    UIImage *tileImg;
    UIImage *mineImg;
    UIImage *flagImg;
    UIImage *nothingImg;
    
    IBOutlet UIView *base;
    
    IBOutlet UILabel *mineLabel;
    
}

@end
