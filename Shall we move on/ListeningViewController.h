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
}

- (void)levelTimerCallback:(NSTimer *)timer;

@property (weak, nonatomic) IBOutlet UIProgressView *listeningLevel;
@end