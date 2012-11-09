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

@interface ListeningViewController : UIViewController {
    AVAudioRecorder *recorder;
    NSTimer *levelTimer;
    NSTimer *timeoutTimer;
    UIImageView *needleImageView;
    float timeout;
    float averageLevel;
}

- (void)levelTimerCallback:(NSTimer *)timer;
- (void)timeoutTimerCallback:(NSTimer *)timer;
-(void) rotateIt:(float)angl;



@property (weak, nonatomic) IBOutlet UIProgressView *timeoutLevel;
@property(nonatomic,retain) UIImageView *needleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *vuMeter;

@end
