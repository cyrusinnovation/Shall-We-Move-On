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
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"back"]];
    self.view.backgroundColor = background;
    [self.calibrateButton setActionSheetButtonWithColor: [UIColor doneButtonColor]];
    
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
    self.durationLabel.text = seconds;
    
    if (counterA < 1) // Once timer goes below 0, reset all variables.
    {
        
        [self.calibrateButton setTitle:@"Calibrate" forState:UIControlStateNormal];
        self.levelLabel.text = [NSString stringWithFormat:@"%f", averageLevel];

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setFloat:averageLevel forKey: @"calibratedAverageLevel"];
        [defaults synchronize];
        
        [timerA invalidate];
        [levelTimer invalidate];
        startA = TRUE;
        counterA = 10;
        
    }
    
}

-(void)startRecorder {
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
        levelTimer = [NSTimer scheduledTimerWithTimeInterval: 0.25 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
        
        
  	} else
  		NSLog([error description]);
}

- (void)levelTimerCallback:(NSTimer *)timer {
	[recorder updateMeters];
    
    //((ListeningView*)self.view).intencity = [recorder averagePowerForChannel:0];
    
    float progressLevel;
    progressLevel = (160 - abs([recorder averagePowerForChannel:0])) * 0.006;
    
    float averagePower;
    averagePower = [recorder averagePowerForChannel:0];
    
    self.levelLabel.text = [NSString stringWithFormat:@"%f", averagePower];
    
    averageLevel = (averageLevel*averageStep + averagePower) / (averageStep+1);
    averageStep++;
    //NSLog(@"average level: %f, average power: %f, step: %i", averageLevel, averagePower, averageStep);
    
       
	//NSLog(@"Average input: %f Peak input: %f", [recorder averagePowerForChannel:0], [recorder peakPowerForChannel:0]);
}


- (IBAction)change:(id)sender {
    counterA = 5;

    if(startA == TRUE) //Check that another instance is not already running.
    {
        self.startRecorder;

        [self.calibrateButton setTitle:@"Stop" forState:UIControlStateNormal];
        [self.calibrateButton setActionSheetButtonWithColor: [UIColor redColor]];

        
        averageLevel = 0;
        averageStep = 1;
        
        startA = FALSE;
        timerA = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }
    
}
@end
