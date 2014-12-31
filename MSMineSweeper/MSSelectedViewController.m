//
//  MSSelectedViewController.m
//  MSMineSweeper
//
//  Created by Yuki Tomiyoshi on 2014/12/30.
//  Copyright (c) 2014年 Yuki Tomiyoshi. All rights reserved.
//

#import "MSSelectedViewController.h"

@interface MSSelectedViewController ()

@end

@implementation MSSelectedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    appdelegata = (MSAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    heightSlider.value = (heightSlider.maximumValue + heightSlider.minimumValue) / 2;
    widthSlider.value = (widthSlider.maximumValue + widthSlider.minimumValue) / 2;
    mineSlider.value = (mineSlider.maximumValue + mineSlider.minimumValue) / 2;
    
    heightLabel.text = [NSString stringWithFormat:@"フィールドサイズ（縦）：%d", (int)heightSlider.value];
    widthLabel.text = [NSString stringWithFormat:@"フィールドサイズ（横）：%d", (int)widthSlider.value];
    mineLabel.text = [NSString stringWithFormat:@"地雷数：%d", (int)mineSlider.value];
    
    [heightSlider addTarget:self action:@selector(changeHeight) forControlEvents:UIControlEventValueChanged];
    [widthSlider addTarget:self action:@selector(changeWidth) forControlEvents:UIControlEventValueChanged];
    [mineSlider addTarget:self action:@selector(changeMine) forControlEvents:UIControlEventValueChanged];
    
    appdelegata.heightNum = (int)heightSlider.value;
    appdelegata.widthNum = (int)widthSlider.value;
    appdelegata.mineNum = (int)mineSlider.value;

}


- (void)changeHeight {
    appdelegata.heightNum = (int)heightSlider.value;
    heightLabel.text = [NSString stringWithFormat:@"フィールドサイズ（縦）：%d", (int)heightSlider.value];
}

- (void)changeWidth {
    appdelegata.widthNum = (int)widthSlider.value;
    widthLabel.text = [NSString stringWithFormat:@"フィールドサイズ（横）：%d", (int)widthSlider.value];
}

- (void)changeMine {
    appdelegata.mineNum = (int)mineSlider.value;
    mineLabel.text = [NSString stringWithFormat:@"地雷数：%d", (int)mineSlider.value];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
