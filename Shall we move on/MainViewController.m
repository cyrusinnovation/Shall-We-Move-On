//
//  MainViewController.m
//  Shall we move on
//
//  Created by Vitaliy Zakharov on 11/7/12.
//  Copyright (c) 2012 Cyrus Innovation. All rights reserved.
//

#import "MainViewController.h"
#import "UIGlossyButton.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"back.png"]];
    self.view.backgroundColor = background;
    
    [self.calibrateButton setActionSheetButtonWithColor: [UIColor grayColor]];
    [self.listenButton setActionSheetButtonWithColor: [UIColor doneButtonColor]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
