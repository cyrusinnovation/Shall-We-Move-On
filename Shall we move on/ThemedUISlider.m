//
//  ThemedUISlider.m
//  Shall we move on
//
//  Created by Vitaliy Zakharov on 11/9/12.
//  Copyright (c) 2012 Cyrus Innovation. All rights reserved.
//

#import "ThemedUISlider.h"

@implementation ThemedUISlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)awakeFromNib {
    [self setThumbImage:[UIImage imageNamed:@"sliderThumb.png"] forState:UIControlStateNormal];
    UIImage *sliderLeftTrackImage = [[UIImage imageNamed: @"sliderBack.png"] stretchableImageWithLeftCapWidth: 9 topCapHeight: 0];
    UIImage *sliderRightTrackImage = [[UIImage imageNamed: @"sliderBack.png"] stretchableImageWithLeftCapWidth: 9 topCapHeight: 0];
    [self setMinimumTrackImage: sliderLeftTrackImage forState: UIControlStateNormal];
    [self setMaximumTrackImage: sliderRightTrackImage forState: UIControlStateNormal];
}

@end
