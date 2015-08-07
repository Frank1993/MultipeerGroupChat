/*
     File: AppDelegate.m
 Abstract: 
    This is the application delegate.
 
  Version: 1.0

 */

#import "AppDelegate.h"
#import "JVFloatingDrawerViewController.h"
#import "JVFloatingDrawerSpringAnimator.h"
#import "ZWIntroductionViewController.h"


static NSString * const kJVDrawersStoryboardName = @"MainStoryboard_iPhone";

static NSString * const kJVLeftDrawerStoryboardID = @"JVLeftDrawerViewControllerStoryboardID";
static NSString * const kJVRightDrawerStoryboardID = @"JVRightDrawerViewControllerStoryboardID";


@interface AppDelegate ()

@property (nonatomic, strong, readonly) UIStoryboard *drawersStoryboard;

@property (nonatomic, strong) ZWIntroductionViewController *introductionView;


@end


@implementation AppDelegate
@synthesize drawersStoryboard = _drawersStoryboard;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.drawerViewController;
    [self configureDrawerViewController];
    
    [self.window makeKeyAndVisible];
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"hasLaunched"])
    {
        NSArray *coverImageNames = @[@"img_index_01txt", @"img_index_02txt", @"img_index_03txt"];
        NSArray *backgroundImageNames = @[@"img_index_01bg", @"img_index_02bg", @"img_index_03bg"];
        self.introductionView = [[ZWIntroductionViewController alloc] initWithCoverImageNames:coverImageNames backgroundImageNames:backgroundImageNames];
        
        [self.window addSubview:self.introductionView.view];
        
        __weak AppDelegate *weakSelf = self;
        self.introductionView.didSelectedEnter = ^() {
            [weakSelf.introductionView.view removeFromSuperview];
            weakSelf.introductionView = nil;
            
            
        };
    }
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasLaunched"];
    
    
    return YES;
}
	
    
- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    }

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}


#pragma mark - Drawer View Controllers

- (JVFloatingDrawerViewController *)drawerViewController {
    if (!_drawerViewController) {
        _drawerViewController = [[JVFloatingDrawerViewController alloc] init];
    }
    
    return _drawerViewController;
}


#pragma mark Sides

- (UITableViewController *)leftDrawerViewController {
    if (!_leftDrawerViewController) {
        _leftDrawerViewController = [self.drawersStoryboard instantiateViewControllerWithIdentifier:kJVLeftDrawerStoryboardID];
    }
    
    return _leftDrawerViewController;
}

- (UIViewController *)rightDrawerViewController {
    if (!_rightDrawerViewController) {
        _rightDrawerViewController = [self.drawersStoryboard instantiateViewControllerWithIdentifier:kJVRightDrawerStoryboardID];
    }
    
    return _rightDrawerViewController;
}


#pragma mark Center


-(MainViewController *)mainVIewController{
    if (!_mainVIewController) {
        _mainVIewController = [self.drawersStoryboard instantiateViewControllerWithIdentifier:@"mainViewStoryboardId"];
    }
    return _mainVIewController;
}

- (JVFloatingDrawerSpringAnimator *)drawerAnimator {
    if (!_drawerAnimator) {
        _drawerAnimator = [[JVFloatingDrawerSpringAnimator alloc] init];
    }
    
    return _drawerAnimator;
}

- (UIStoryboard *)drawersStoryboard {
    if(!_drawersStoryboard) {
        _drawersStoryboard = [UIStoryboard storyboardWithName:kJVDrawersStoryboardName bundle:nil];
    }
    
    return _drawersStoryboard;
}

- (void)configureDrawerViewController {
    self.drawerViewController.leftViewController = self.leftDrawerViewController;
    self.drawerViewController.rightViewController = self.rightDrawerViewController;
    self.drawerViewController.centerViewController = self.mainVIewController;
    
    self.drawerViewController.animator = self.drawerAnimator;
    
    self.drawerViewController.backgroundImage = [UIImage imageNamed:@"blue"];
}

#pragma mark - Global Access Helper

+ (AppDelegate *)globalDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)toggleLeftDrawer:(id)sender animated:(BOOL)animated {
    [self.drawerViewController toggleDrawerWithSide:JVFloatingDrawerSideLeft animated:animated completion:nil];
}

- (void)toggleRightDrawer:(id)sender animated:(BOOL)animated {
    [self.drawerViewController toggleDrawerWithSide:JVFloatingDrawerSideRight animated:animated completion:nil];
}

@end
