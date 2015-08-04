//
//  JVLeftDrawerTableViewController.m
//  JVFloatingDrawer
//
//  Created by Julian Villella on 2015-01-15.
//  Copyright (c) 2015 JVillella. All rights reserved.
//
@import MultipeerConnectivity;

#import "JVLeftDrawerTableViewController.h"
#import "JVLeftDrawerTableViewCell.h"
#import "AppDelegate.h"
#import "JVFloatingDrawerViewController.h"

enum {
    kJVDrawerSettingsIndex    = 0,
    kJVGitHubProjectPageIndex = 1
};

static const CGFloat kJVTableViewTopInset = 80.0;
static NSString * const kJVDrawerCellReuseIdentifier = @"JVDrawerCellReuseIdentifier";

@interface JVLeftDrawerTableViewController ()
@property (nonatomic,strong) NSArray * peerIdArray;
@end

@implementation JVLeftDrawerTableViewController
@synthesize  peerIdArray = _peerIdArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(kJVTableViewTopInset, 0.0, 0.0, 0.0);
    self.clearsSelectionOnViewWillAppear = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SessionInfomationUpdated:) name:@"SessionInfomaiton" object:nil];
}


-(void)SessionInfomationUpdated:(NSNotification *)notification
{
    NSArray * connectedPeers = notification.object;
    self.peerIdArray = [NSArray arrayWithArray:connectedPeers];
    [self.tableView
     reloadData];
}
#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section ==0) {
        return 1;
    }else
    {
        return [self.peerIdArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JVLeftDrawerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kJVDrawerCellReuseIdentifier forIndexPath:indexPath];
    
    
    if ([indexPath section]==0) {
        NSString * serviceType = [[NSUserDefaults standardUserDefaults] objectForKey:@"serviceTypeKey"];
        cell.titleText = serviceType;
        cell.iconImage = [UIImage imageNamed:@"usergroup"];
    }else
    {
        NSString * peerId = [self.peerIdArray objectAtIndex:[indexPath row]];
        cell.titleText = peerId;
        cell.iconImage = [UIImage imageNamed:@"user"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray * peerIdArray;
    if ([indexPath section]==0) {
        peerIdArray = [[NSArray alloc] initWithObjects:@"Group", nil];
    }else
    {
        
        peerIdArray = [[NSArray alloc] initWithObjects:@"NotGroup",[self.peerIdArray objectAtIndex:[indexPath row]],nil];
    }
    
    
    
    [[AppDelegate globalDelegate] toggleLeftDrawer:self animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PeerIdSelect" object:peerIdArray];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return @"群名称：";
    }else
    {
        return @"群成员：";
    }
}
@end
