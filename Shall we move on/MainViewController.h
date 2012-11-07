//
//  MainViewController.h
//  Shall we move on
//
//  Created by Vitaliy Zakharov on 11/7/12.
//  Copyright (c) 2012 Cyrus Innovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIGlossyButton.h"

@interface MainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIGlossyButton *calibrateButton;

@property (weak, nonatomic) IBOutlet UIGlossyButton *listenButton;
@end
