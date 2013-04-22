//
//  NICDetailViewController.h
//  BluetoothPresentation
//
//  Created by Jason Harwig on 4/18/13.
//  Copyright (c) 2013 Jason Harwig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NICSlideViewController : UIViewController

@property (nonatomic, assign) NSUInteger currentBuild;
@property (nonatomic, retain) IBOutletCollection(@"UIView") NSArray *builds;

@end
