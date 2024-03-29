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

- (UIImageView *)initializeArrow:(UIImageView *) imageView fileName:(NSString *) fileName
{
    UIImageView *imgNeedle = [[UIImageView alloc]initWithFrame:CGRectMake(162,
                                                                          79,
                                                                          10,
                                                                          45)];
    
    imageView = imgNeedle;
    
    imageView.layer.anchorPoint = CGPointMake(imageView.layer.anchorPoint.x,
                                              imageView.layer.anchorPoint.y*2.68);
    imageView.backgroundColor = [UIColor clearColor];
    imageView.image = [UIImage imageNamed: fileName];
    
    [self.view addSubview:imageView];
    
    
    [self rotateIt:[self dbToGauge:averageLevel] image:imageView];
    
    return imageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"Default.png"]];
    self.view.backgroundColor = background;
    
    
    NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
    
  	NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithFloat: 44100.0],                 AVSampleRateKey,
                              [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
                              [NSNumber numberWithInt: 1],                         AVNumberOfChannelsKey,
                              [NSNumber numberWithInt: AVAudioQualityMax],         AVEncoderAudioQualityKey,
                              nil];
    
  	NSError *error;
    
  	recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    averageLevel = [defaults floatForKey:@"calibratedAverageLevel"];
    
    self.calibrationSlider.value = averageLevel;
    
    needleImageView = [self initializeArrow:needleImageView fileName:@"arrow2.png"];
    redNeedleImageView =[self initializeArrow:redNeedleImageView fileName:@"redarrow.png"];
    

    
  	if (recorder) {
  		[recorder prepareToRecord];
  		recorder.meteringEnabled = YES;
  		[recorder record];
        
        

  	} else
  		NSLog([error description]);
}

- (void)levelTimerCallback:(NSTimer *)timer {
	[recorder updateMeters];
    
    //((ListeningView*)self.view).intencity = [recorder averagePowerForChannel:0];
    
    float progressLevel;
    
    float averagePower = [recorder averagePowerForChannel:0];
    progressLevel = (160 - abs(averagePower)) * 0.006;
   //NSLog(@"power: %f, level: %f", averagePower, averageLevel);
    
    [self rotateIt:[self dbToGauge:averagePower] image: needleImageView];
        
    if (averagePower < averageLevel) {
        self.timeoutLevel.progress += 0.005;
    } else {
        self.timeoutLevel.progress = 0.0;
    }
    
    if (self.timeoutLevel.progress > 0.99) {
        [levelTimer invalidate];
        levelTimer = nil;

        SystemSoundID completeSound;
        NSURL *audioPath = [[NSBundle mainBundle] URLForResource:@"shwm" withExtension:@"aiff"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)audioPath, &completeSound);
        AudioServicesPlaySystemSound (completeSound);
    }
    
	//NSLog(@"Average input: %f Peak input: %f", [recorder averagePowerForChannel:0], [recorder peakPowerForChannel:0]);
}

- (void)timeoutTimerCallback:(NSTimer *)timer {
    //self.timeoutLevel.progress += 0.025;
}


-(void) rotateIt:(float)angl image:(UIImageView *)needle
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.01f];
  
    [needle setTransform: CGAffineTransformMakeRotation((M_PI / 180) *angl)];
   
    [UIView commitAnimations];
}

- (IBAction)calibrationSliderChanged:(id)sender {
    averageLevel = self.calibrationSlider.value;
    [self rotateIt: [self dbToGauge:averageLevel] image:redNeedleImageView];
}


- (float)dbToGauge:(float)value {
    return value+60;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startButton:(id)sender {
    levelTimer = [NSTimer scheduledTimerWithTimeInterval: 0.03 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
    
    timeoutTimer = [NSTimer scheduledTimerWithTimeInterval: 0.25 target: self selector: @selector(timeoutTimerCallback:) userInfo: nil repeats: YES];
}
@end
