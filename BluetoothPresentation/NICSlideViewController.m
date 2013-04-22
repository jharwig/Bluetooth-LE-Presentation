//
//  NICDetailViewController.m
//  BluetoothPresentation
//
//  Created by Jason Harwig on 4/18/13.
//  Copyright (c) 2013 Jason Harwig. All rights reserved.
//

#import "NICSlideViewController.h"

typedef void (^CompletionBlock)(BOOL finished);

@implementation NICSlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentBuild = 0;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(moveBack:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipe];

    swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(moveNext:)];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipe];

    [self.view addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)]];
}

- (void)tap:(UITapGestureRecognizer *)tap {
    if (self.currentBuild < [self.builds count]) {
        
        CompletionBlock c = ^(BOOL f) {
            UIView *build = self.builds[self.currentBuild++];
            [self animateIn:build completion:^(BOOL f){}];
        };
        
        if (self.currentBuild > 0) {
            [self animateOut:self.builds[self.currentBuild - 1] completion:c];
        } else c(YES);
        
    } else {     
        @try {
            [self performSegueWithIdentifier:@"next" sender:nil];
        }
        @catch (NSException *exception) {
        }
    }
}


- (void)moveBack:(UISwipeGestureRecognizer *)swipe {
    
    if (swipe.state == UIGestureRecognizerStateEnded) {                
        if (self.currentBuild > 1) {
            UIView *previous = self.builds[self.currentBuild - 2];
            [self animateOut:self.builds[--self.currentBuild] completion:^(BOOL f){
                [self animateIn:previous completion:^(BOOL f){}];
            }];
        } else if (self.currentBuild > 0) {
            [self animateOut:self.builds[--self.currentBuild] completion:^(BOOL f){}];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
- (void)moveNext:(UISwipeGestureRecognizer *)swipe {
    
    if (swipe.state == UIGestureRecognizerStateEnded) {
        @try { [self performSegueWithIdentifier:@"next" sender:nil]; }
        @catch (NSException *exception) { }
    }
}
- (void)longPress:(UILongPressGestureRecognizer *)longPress {
    
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeRight;
}

#pragma mark - Private

- (void)animateIn:(UIView *)view completion:(void (^)(BOOL finished))completion {
    view.transform = CGAffineTransformMakeScale(0.1, 0.1);
    UIView *imageView = [self.view viewWithTag:1];
    if (imageView) {
        [self.view insertSubview:view belowSubview:imageView];
    } else {
        [self.view addSubview:view];
    }
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         view.transform = CGAffineTransformMakeScale(1.3, 1.3);
                     }
                     completion:^(BOOL c){
                         [UIView animateWithDuration:0.2
                                               delay:0.0
                                             options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              view.transform = CGAffineTransformIdentity;
                                          }
                                          completion:^(BOOL c){
                                              completion(c);
                                          }];
                     }];
}

- (void)animateOut:(UIView *)view completion:(void (^)(BOOL finished))completion {
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         view.transform = CGAffineTransformMakeScale(1.3, 1.3);
                     }
                     completion:^(BOOL c){
                         [UIView animateWithDuration:0.2
                                               delay:0.0
                                             options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              view.transform = CGAffineTransformMakeScale(0.1, 0.1);
                                          }
                                          completion:^(BOOL c){
                                              [view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.1];
                                              completion(c);
                                          }];
                     }];
}


@end
