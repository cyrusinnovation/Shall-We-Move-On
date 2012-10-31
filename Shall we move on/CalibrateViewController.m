//
//  ViewController.m
//  Shall we move on
//
//  Created by Vitaliy Zakharov on 10/26/12.
//  Copyright (c) 2012 Cyrus Innovation. All rights reserved.
//

#import "CalibrateViewController.h"

@interface CalibrateViewController ()

@end

@implementation CalibrateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	UIImage *image = [UIImage imageNamed:@"blueButton.png"];
    UIImage *stretchedImage = [image stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [self.calibrateButton setBackgroundImage:stretchedImage forState:UIControlStateNormal];
}

- (void)awakeFromNib{
    startA = TRUE;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateTimer{ //Happens every time updateTimer is called. Should occur every second.
    
    counterA -= 1;
    NSString *seconds = [NSString stringWithFormat:@"%i", counterA];
    [self.calibrateButton setTitle:seconds forState:UIControlStateNormal];
    
    if (counterA < 1) // Once timer goes below 0, reset all variables.
    {
        
        [self.calibrateButton setTitle:@"Calibrate" forState:UIControlStateNormal];

        
        [timerA invalidate];
        startA = TRUE;
        counterA = 10;
        
    }
    
}

- (IBAction)durationChanged:(id)sender {
    self.durationLabel.text = [NSString stringWithFormat: @"%i", (int)self.durationSlider.value];
}

- (IBAction)change:(id)sender {
    counterA = (int)self.durationSlider.value;

    if(startA == TRUE) //Check that another instance is not already running.
    {
       // secondsA.text = @"10";
        startA = FALSE;
        timerA = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }
    
}
@end
