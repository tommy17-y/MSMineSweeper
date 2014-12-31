//
//  MSSelectedViewController.h
//  MSMineSweeper
//
//  Created by Yuki Tomiyoshi on 2014/12/30.
//  Copyright (c) 2014年 Yuki Tomiyoshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSAppDelegate.h"

@interface MSSelectedViewController : UIViewController {
    IBOutlet UISlider *heightSlider;
    IBOutlet UISlider *widthSlider;
    IBOutlet UISlider *mineSlider;
    
    IBOutlet UILabel *heightLabel;
    IBOutlet UILabel *widthLabel;
    IBOutlet UILabel *mineLabel;
    
    IBOutlet UIButton *selectedButton;
    
    MSAppDelegate *appdelegata;
}

@end
