/*
     File: AppDelegate.h
 Abstract: 
    This is the application delegate.
 
  Version: 1.0
 
 */
#import <UIKit/UIKit.h>
#import "MainViewController.h"
@class JVFloatingDrawerViewController;
@class JVFloatingDrawerSpringAnimator;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (nonatomic, strong) JVFloatingDrawerViewController *drawerViewController;
@property (nonatomic, strong) JVFloatingDrawerSpringAnimator *drawerAnimator;

@property (nonatomic, strong) UITableViewController *leftDrawerViewController;
@property (nonatomic, strong) UITableViewController *rightDrawerViewController;

@property (nonatomic,strong) MainViewController * mainVIewController;


+ (AppDelegate *)globalDelegate;

- (void)toggleLeftDrawer:(id)sender animated:(BOOL)animated;
- (void)toggleRightDrawer:(id)sender animated:(BOOL)animated;


@end
