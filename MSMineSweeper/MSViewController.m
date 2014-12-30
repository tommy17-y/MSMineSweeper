//
//  MSViewController.m
//  MSMineSweeper
//
//  Created by Yuki Tomiyoshi on 2014/12/30.
//  Copyright (c) 2014年 Yuki Tomiyoshi. All rights reserved.
//

#import "MSViewController.h"

@interface MSViewController ()

@end

@implementation MSViewController

const int margin = 10;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    widthNum = 5;
    heightNum = 5;
    mineNum = 5;
    
    tileImg = [UIImage imageNamed:@"masu.png"];
    mineImg = [UIImage imageNamed:@"mine.png"];
    flagImg = [UIImage imageNamed:@"flag.png"];
    nothingImg = [UIImage imageNamed:@"nothing.png"];
    
    [self createTile];
    
}

#pragma mark - gesture

- (void)tappedTile:(MSTile*)tile {
    [tile setBackgroundImage:nothingImg forState:UIControlStateNormal];
    tile.userInteractionEnabled = NO;
}


#pragma mark - initialize

- (void)viewWillAppear:(BOOL)animated {
    width = (self.view.frame.size.width - margin * 2) / widthNum;
    height = width;

    base.frame = CGRectMake(0, 0, width * widthNum, height * heightNum);
    base.center = self.view.center;
    base.backgroundColor = [UIColor lightGrayColor];

    [self setTile];
}

- (void)createTile {
    
    for (int i = 0; i < widthNum * heightNum; i++) {
        MSTile *tile = [[MSTile alloc] init];
        tile.tag = i + 1;
        [tile addTarget:self action:@selector(tappedTile:) forControlEvents:UIControlEventTouchUpInside];
        
        [base addSubview:tile];
    }

}

- (void)setTile {
    
    for (int i = 0; i < widthNum * heightNum; i++) {
        MSTile *tile = (MSTile*)[base viewWithTag:i + 1];
        if (tile != nil) {
            tile.frame = CGRectMake(0 + (i % widthNum) * width,
                                    0 + (i / widthNum) * height,
                                    width,
                                    height);
            [tile setBackgroundImage:tileImg forState:UIControlStateNormal];
        }
    }
    
    [self setMine];
}

- (void)setMine {
    
    int count = 0;
    
    for (;;) {
        int rand = arc4random() % (widthNum * heightNum) + 1;
        MSTile *tile = (MSTile*)[base viewWithTag:rand];
        
        if ([tile getMine] != YES) {
            [tile setMine:YES];
            count++;
        }
        
        if (count >= mineNum) {
            break;
        }
    }
    
    mineLabel.text = [NSString stringWithFormat:@"残り地雷数：%d", mineNum];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
