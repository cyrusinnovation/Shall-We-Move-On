//
//  ViewController.h
//  Shall we move on
//
//  Created by Vitaliy Zakharov on 10/26/12.
//  Copyright (c) 2012 Cyrus Innovation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalibrateViewController : UIViewController {
    int counterA;
    bool startA;
    IBOutlet UILabel *secondsA;
    NSTimer *timerA;
}
@property (weak, nonatomic) IBOutlet UIButton *calibrateButton;
- (IBAction)durationChanged:(id)sender;

- (IBAction)change:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *durationSlider;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
- (void) updateTimer;
@end
