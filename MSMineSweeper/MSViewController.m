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


// TODO: マジックナンバーはなくして定数定義
const int margin = 10;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    appdelegata = (MSAppDelegate*)[[UIApplication sharedApplication] delegate];

    widthNum = appdelegata.widthNum;
    heightNum = appdelegata.heightNum;
    mineNum = appdelegata.mineNum;
    leftMineNum = mineNum;
    openedTileNum = 0;
    
    tileImg = [UIImage imageNamed:@"masu"];
    mineImg = [UIImage imageNamed:@"mine"];
    flagImg = [UIImage imageNamed:@"flag"];
    nothingImg = [UIImage imageNamed:@"nothing"];
    
    mineModeButton.layer.borderWidth = 2.0f;
    mineModeButton.layer.borderColor = [[UIColor redColor] CGColor];
    mineModeButton.layer.cornerRadius = 10.0f;
    flagModeButton.layer.borderWidth = 2.0f;
    flagModeButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    flagModeButton.layer.cornerRadius = 10.0f;
    
    forAutoOpenArray =  [NSMutableArray array];
    [forAutoOpenArray removeAllObjects];
    
    [self createTile];
    
}

#pragma mark - gesture

- (void)tappedTile:(MSTile*)tile {
    
    if (mineModeButton.layer.borderColor == [[UIColor redColor] CGColor] && [tile isFlag] == NO) {
    
        if ([tile isMine] == NO) {
            [tile setBackgroundImage:nothingImg forState:UIControlStateNormal];
            openedTileNum++;
            
            if ([self checkClear] == NO) {
                [self displayMineNum:(int)tile.tag];
            }
            
        } else {
            [tile setBackgroundImage:mineImg forState:UIControlStateNormal];
            [self gameOver];
        }
        tile.userInteractionEnabled = NO;
        [tile setOpen:YES];
        
    } else if (flagModeButton.layer.borderColor == [[UIColor redColor] CGColor]) {
        
        if ([tile isFlag] == NO) {
            if (leftMineNum > 0) {
                [tile setBackgroundImage:flagImg forState:UIControlStateNormal];
                [tile setFlag:YES];
                leftMineNum--;
                mineLabel.text = [NSString stringWithFormat:@"残り地雷数：%d", leftMineNum];
            }
            if (leftMineNum == 0) {
                [self checkClear];
            }
        } else {
            [tile setBackgroundImage:tileImg forState:UIControlStateNormal];
            [tile setFlag:NO];
            leftMineNum++;
            mineLabel.text = [NSString stringWithFormat:@"残り地雷数：%d", leftMineNum];
        }
    }
}

- (IBAction)tappedMineModeButton {
    mineModeButton.layer.borderColor = [[UIColor redColor] CGColor];
    flagModeButton.layer.borderColor = [[UIColor whiteColor] CGColor];
}

- (IBAction)tappedFlagModeButton {
    mineModeButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    flagModeButton.layer.borderColor = [[UIColor redColor] CGColor];
}

#pragma mark - open

- (void)displayMineNum:(int)tileTag {
    MSTile *tile = (MSTile*)[base viewWithTag:tileTag];
    if ([tile getSurroundingMineNum] != 0){
        [tile setTitle:[NSString stringWithFormat:@"%d", [tile getSurroundingMineNum]]
              forState:UIControlStateNormal];
    } else {
        [forAutoOpenArray addObject:[NSString stringWithFormat:@"%d", (int)tile.tag]];
        [self autoOpenTile];
    }
}

- (void)allMineTileOpen {
    
    for (int i = 1; i <= widthNum * heightNum; i++) {
        MSTile *tile = (MSTile*)[base viewWithTag:i];
        if (tile != nil) {
            if ([tile isMine] == YES) {
                [tile setBackgroundImage:mineImg forState:UIControlStateNormal];
            }
            tile.userInteractionEnabled = NO;
        }
    }

}


// TODO:リファクタリング
- (void)autoOpenTile {
    MSTile *tile;
    NSMutableArray *array =  [NSMutableArray array];
    array = forAutoOpenArray.mutableCopy;
    [forAutoOpenArray removeAllObjects];
    
    for (int i = 0; i < [array count]; i++) {
        
        int openedTileTag = (int)[array[i] integerValue];
        
        // 最上段以外
        if (openedTileTag > widthNum) {
            tile = (MSTile*)[base viewWithTag:openedTileTag - widthNum];
            if (tile != nil) {
                if ([tile isOpen] == NO && [tile isFlag] == NO
                    && [tile getSurroundingMineNum]  == 0 && [tile isMine] == NO) {
                    [tile setBackgroundImage:nothingImg forState:UIControlStateNormal];
                    [tile setOpen:YES];
                    [forAutoOpenArray addObject:[NSString stringWithFormat:@"%d", (int)tile.tag]];
                }
            }
            
            if (openedTileTag % widthNum != 0) {
                tile = (MSTile*)[base viewWithTag:openedTileTag - widthNum + 1];
                if (tile != nil) {
                    if ([tile isOpen] == NO && [tile isFlag] == NO
                        && [tile getSurroundingMineNum]  == 0 && [tile isMine] == NO) {
                        [tile setBackgroundImage:nothingImg forState:UIControlStateNormal];
                        [tile setOpen:YES];
                        [forAutoOpenArray addObject:[NSString stringWithFormat:@"%d", (int)tile.tag]];
                    }
                }
            }
            
            if (openedTileTag % widthNum != 1) {
                tile = (MSTile*)[base viewWithTag:openedTileTag - widthNum - 1];
                if (tile != nil) {
                    if ([tile isOpen] == NO && [tile isFlag] == NO
                        && [tile getSurroundingMineNum]  == 0 && [tile isMine] == NO) {
                        [tile setBackgroundImage:nothingImg forState:UIControlStateNormal];
                        [tile setOpen:YES];
                        [forAutoOpenArray addObject:[NSString stringWithFormat:@"%d", (int)tile.tag]];
                    }
                }
            }
        }
        
        // 最下段以外
        if (openedTileTag <= (widthNum * (heightNum - 1))) {
            tile = (MSTile*)[base viewWithTag:openedTileTag + widthNum];
            if (tile != nil) {
                if ([tile isOpen] == NO && [tile isFlag] == NO
                    && [tile getSurroundingMineNum]  == 0 && [tile isMine] == NO) {
                    [tile setBackgroundImage:nothingImg forState:UIControlStateNormal];
                    [tile setOpen:YES];
                    [forAutoOpenArray addObject:[NSString stringWithFormat:@"%d", (int)tile.tag]];
                }
            }
            
            if (openedTileTag % widthNum != 0) {
                tile = (MSTile*)[base viewWithTag:openedTileTag + widthNum + 1];
                if (tile != nil) {
                    if ([tile isOpen] == NO && [tile isFlag] == NO
                        && [tile getSurroundingMineNum]  == 0 && [tile isMine] == NO) {
                        [tile setBackgroundImage:nothingImg forState:UIControlStateNormal];
                        [tile setOpen:YES];
                        [forAutoOpenArray addObject:[NSString stringWithFormat:@"%d", (int)tile.tag]];
                    }
                }
            }
            
            if (openedTileTag % widthNum != 1) {
                tile = (MSTile*)[base viewWithTag:openedTileTag + widthNum - 1];
                if (tile != nil) {
                    if ([tile isOpen] == NO && [tile isFlag] == NO
                        && [tile getSurroundingMineNum]  == 0 && [tile isMine] == NO) {
                        [tile setBackgroundImage:nothingImg forState:UIControlStateNormal];
                        [tile setOpen:YES];
                        [forAutoOpenArray addObject:[NSString stringWithFormat:@"%d", (int)tile.tag]];
                    }
                }
            }
            
        }
        
        // 最右以外
        if (openedTileTag % widthNum != 0) {
            tile = (MSTile*)[base viewWithTag:openedTileTag + 1];
            if (tile != nil) {
                if ([tile isOpen] == NO && [tile isFlag] == NO
                    && [tile getSurroundingMineNum]  == 0 && [tile isMine] == NO) {
                    [tile setBackgroundImage:nothingImg forState:UIControlStateNormal];
                    [tile setOpen:YES];
                    [forAutoOpenArray addObject:[NSString stringWithFormat:@"%d", (int)tile.tag]];
                }
            }
        }
        
        // 最左以外
        if (openedTileTag % widthNum != 1) {
            tile = (MSTile*)[base viewWithTag:openedTileTag - 1];
            if (tile != nil) {
                if ([tile isOpen] == NO && [tile isFlag] == NO
                    && [tile getSurroundingMineNum]  == 0 && [tile isMine] == NO) {
                    [tile setBackgroundImage:nothingImg forState:UIControlStateNormal];
                    [tile setOpen:YES];
                    [forAutoOpenArray addObject:[NSString stringWithFormat:@"%d", (int)tile.tag]];
                }
            }
        }
    }
    
    if ([forAutoOpenArray count] != 0) {
        [self autoOpenTile];
    } else {
        [self countOpenedTileNum];
    }
    
}

- (void)countOpenedTileNum {
    int count = 0;
    
    for (int i = 1; i <= widthNum * heightNum; i++) {
        MSTile *tile = (MSTile*)[base viewWithTag:i];
        if (tile != nil) {
            if ([tile isOpen] == YES) {
                count++;
            }
        }
    }
    
    openedTileNum = count;
    
    [self checkClear];
}

#pragma mark - game end

- (BOOL)checkClear {
    
    if ([self isOpenedAllTilesExceptForMine] == YES ||
            [self isCheckedAllFlagsAtRightTiles] == YES ||
            [self isAllMinesAtFlagTilesAndNotOpenedTiles] == YES) {
        [self gameClear];
        return YES;
    }
    return NO;

}

- (BOOL)isOpenedAllTilesExceptForMine {
    
    if (openedTileNum == widthNum * heightNum - mineNum) {
        return YES;
    }
    return NO;
}

- (BOOL)isCheckedAllFlagsAtRightTiles {
    
    int count = 0;
    
    for (int i = 1; i <= widthNum * heightNum; i++) {
        MSTile *tile = (MSTile*)[base viewWithTag:i];
        if (tile != nil) {
            if ([tile isMine] == YES && [tile isFlag] == YES) {
                count++;
            }
        }
    }
    
    if (count == mineNum) {
        return YES;
    }
    return NO;
}

- (BOOL)isAllMinesAtFlagTilesAndNotOpenedTiles {
    
    int count = 0;
    
    for (int i = 1; i <= widthNum * heightNum; i++) {
        MSTile *tile = (MSTile*)[base viewWithTag:i];
        if (tile != nil) {
            if ([tile isMine] == YES && [tile isFlag] == YES) {
                count++;
            }
        }
    }
    
    if ((widthNum * heightNum - openedTileNum) + count == mineNum) {
        return YES;
    }
    return NO;
}

- (void)gameClear {
    mineLabel.text = @"ゲームクリア！";
    
    for (int i = 1; i <= widthNum * heightNum; i++) {
        MSTile *tile = (MSTile*)[base viewWithTag:i];
        if (tile != nil) {
            tile.userInteractionEnabled = NO;
        }
    }
}

- (void)gameOver {
    mineLabel.text = @"ゲームオーバー";
    [NSTimer scheduledTimerWithTimeInterval:0.5f target:self
                                   selector:@selector(allMineTileOpen) userInfo:nil repeats:NO];
}

#pragma mark - initialize

- (void)viewWillAppear:(BOOL)animated {
    width = (self.view.frame.size.width
             - margin * 2) / widthNum;
    height = (self.view.frame.size.height
              - 20 /* ステータスバーの分*/
              - subview.frame.size.height
              - toTitleButton.frame.size.height
              - margin * 4) / heightNum;
    
    if (width < height) {
        height = width;
    } else {
        width = height;
    }
    
    subview.center = CGPointMake(self.view.center.x, 20 + margin + subview.frame.size.height / 2);
    toTitleButton.center = CGPointMake(self.view.center.x,
                                       self.view.frame.size.height - margin - toTitleButton.frame.size.height / 2);

    base.frame = CGRectMake(0, 0, width * widthNum, height * heightNum);
    base.center = self.view.center;
    if (subview.frame.origin.y + subview.frame.size.height + margin > base.frame.origin.y) {
        base.frame = CGRectMake(base.frame.origin.x,
                                subview.frame.origin.y + subview.frame.size.height + margin,
                                base.frame.size.width,
                                base.frame.size.height);
    } else {
        subview.frame = CGRectMake(subview.frame.origin.x,
                                   base.frame.origin.y - subview.frame.size.height - margin,
                                   subview.frame.size.width,
                                   subview.frame.size.height);
    }
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
        
        if ([tile isMine] != YES) {
//            [tile setBackgroundImage:mineImg forState:UIControlStateNormal];
            [tile setMine:YES];
            count++;
        }
        
        if (count >= mineNum) {
            break;
        }
    }
    
    mineLabel.text = [NSString stringWithFormat:@"残り地雷数：%d", mineNum];
    
    [self mineCount];
}

- (void)mineCount {
    int count = 0;
    MSTile *tile;

    for (int i = 1; i <= widthNum * heightNum; i++) {
        count = 0;
        tile = (MSTile*)[base viewWithTag:i];
        
        if ([tile isMine] == NO) {
        
            // 最上段以外
            if (i > widthNum) {
                tile = (MSTile*)[base viewWithTag:i - widthNum];
                if ([tile isMine] == YES) {
                    count++;
                }
                
                if (i % widthNum != 0) {
                    tile = (MSTile*)[base viewWithTag:i - widthNum + 1];
                    if ([tile isMine] == YES) {
                        count++;
                    }
                }
                
                if (i % widthNum != 1) {
                    tile = (MSTile*)[base viewWithTag:i - widthNum - 1];
                    if ([tile isMine] == YES) {
                        count++;
                    }
                }
            }
            
            // 最下段以外
            if (i <= (widthNum * (heightNum - 1))) {
                tile = (MSTile*)[base viewWithTag:i + widthNum];
                if ([tile isMine] == YES) {
                    count++;
                }
                
                if (i % widthNum != 0) {
                    tile = (MSTile*)[base viewWithTag:i + widthNum + 1];
                    if ([tile isMine] == YES) {
                        count++;
                    }
                }
                
                if (i % widthNum != 1) {
                    tile = (MSTile*)[base viewWithTag:i + widthNum - 1];
                    if ([tile isMine] == YES) {
                        count++;
                    }
                }
                
            }
            
            // 最右以外
            if (i % widthNum != 0) {
                tile = (MSTile*)[base viewWithTag:i + 1];
                if ([tile isMine] == YES) {
                    count++;
                }
            }
            
            // 最左以外
            if (i % widthNum != 1) {
                tile = (MSTile*)[base viewWithTag:i - 1];
                if ([tile isMine] == YES) {
                    count++;
                }
            }
            
            if (count != 0) {
                tile = (MSTile*)[base viewWithTag:i];
                [tile setSurroundingMineNum:count];
//                [tile setTitle:[NSString stringWithFormat:@"%d", [tile getSurroundingMineNum]]
//                      forState:UIControlStateNormal];
            }
        }
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
