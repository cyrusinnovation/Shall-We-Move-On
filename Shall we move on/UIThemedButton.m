//
//  UIThemedButton.m
//  Shall we move on
//
//  Created by Vitaliy Zakharov on 11/12/12.
//  Copyright (c) 2012 Cyrus Innovation. All rights reserved.
//

#import "UIThemedButton.h"

@implementation UIThemedButton

- (id)initWithFrame:(CGRect)frame
{
    self = [UIButton buttonWithType:UIButtonTypeCustom];
    //self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib {
    [self setBackgroundImage:[UIImage imageNamed:@"startButton.png"] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

@end
