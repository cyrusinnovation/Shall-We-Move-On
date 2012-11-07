//
//  ViewController.h
//  Shall we move on
//
//  Created by Vitaliy Zakharov on 10/26/12.
//  Copyright (c) 2012 Cyrus Innovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>

@interface CalibrateViewController : UIViewController {    
    AVAudioRecorder *recorder;
    NSTimer *levelTimer;
    int counterA;
    bool startA;
    IBOutlet UILabel *secondsA;
    NSTimer *timerA;
    float averageLevel;
    int averageStep;
}
@property (weak, nonatomic) IBOutlet UIButton *calibrateButton;
- (IBAction)durationChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;

- (IBAction)change:(id)sender;
  @property (weak, nonatomic) IBOutlet UILabel *durationLabel;
- (void) updateTimer;
-(void)startRecorder;
@end
