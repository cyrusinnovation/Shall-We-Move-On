//
//  ListeningViewController.m
//  Shall we move on
//
//  Created by Vitaliy Zakharov on 11/1/12.
//  Copyright (c) 2012 Cyrus Innovation. All rights reserved.
//

#import "ListeningViewController.h"
#import "ListeningView.h"

@interface ListeningViewController ()

@end

@implementation ListeningViewController

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
    NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
    
  	NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithFloat: 44100.0],                 AVSampleRateKey,
                              [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
                              [NSNumber numberWithInt: 1],                         AVNumberOfChannelsKey,
                              [NSNumber numberWithInt: AVAudioQualityMax],         AVEncoderAudioQualityKey,
                              nil];
    
  	NSError *error;
    
  	recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    
    
  	if (recorder) {
  		[recorder prepareToRecord];
  		recorder.meteringEnabled = YES;
  		[recorder record];
        levelTimer = [NSTimer scheduledTimerWithTimeInterval: 0.03 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];

  	} else
  		NSLog([error description]);
}

- (void)levelTimerCallback:(NSTimer *)timer {
	[recorder updateMeters];
    
    //((ListeningView*)self.view).intencity = [recorder averagePowerForChannel:0];
    
    float progressLevel;
    progressLevel = (160 - abs([recorder averagePowerForChannel:0])) * 0.006;
    NSLog(@"%f", progressLevel);
    
    self.listeningLevel.progress = progressLevel;
	//NSLog(@"Average input: %f Peak input: %f", [recorder averagePowerForChannel:0], [recorder peakPowerForChannel:0]);
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end