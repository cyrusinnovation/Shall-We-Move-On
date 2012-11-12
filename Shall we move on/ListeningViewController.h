//
//  ListeningViewController.h
//  Shall we move on
//
//  Created by Vitaliy Zakharov on 11/1/12.
//  Copyright (c) 2012 Cyrus Innovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import "ThemedUISlider.h"

@interface ListeningViewController : UIViewController {
    AVAudioRecorder *recorder;
    NSTimer *levelTimer;
    NSTimer *timeoutTimer;
    UIImageView *needleImageView;
    UIImageView *redNeedleImageView;
    float timeout;
    float averageLevel;
}

- (void)levelTimerCallback:(NSTimer *)timer;
- (void)timeoutTimerCallback:(NSTimer *)timer;
- (float)dbToGauge:(float)value;
- (void) rotateIt:(float)angl image:(UIImageView *)needle;
- (IBAction)calibrationSliderChanged:(id)sender;
@property (weak, nonatomic) IBOutlet ThemedUISlider *calibrationSlider;
- (IBAction)startButton:(id)sender;


@property (weak, nonatomic) IBOutlet UIProgressView *timeoutLevel;

@property (weak, nonatomic) IBOutlet UIImageView *vuMeter;

@end
