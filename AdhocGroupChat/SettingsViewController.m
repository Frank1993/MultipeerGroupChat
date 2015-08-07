
@import MultipeerConnectivity;

#import "SettingsViewController.h"





@interface SettingsViewController () <UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITextField *displayNameTextField;
@property (retain, nonatomic) IBOutlet UITextField *serviceTypeTextField;

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"displayNameKey"]) {
        self.displayName = [NSString stringWithString:[[NSUserDefaults standardUserDefaults] objectForKey:@"displayNameKey"]];
        self.displayNameTextField.text = self.displayName;
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"serviceTypeKey"]) {
        self.serviceType = [NSString stringWithString:[[NSUserDefaults standardUserDefaults] objectForKey:@"serviceTypeKey"]];
        
        self.serviceTypeTextField.text = self.serviceType;
    }
    
    
    self.view.backgroundColor = [UIColor clearColor];
}

#pragma mark - private 

// RFC 6335 text:
//   5.1. Service Name Syntax
//
//     Valid service names are hereby normatively defined as follows:
//
//     o  MUST be at least 1 character and no more than 15 characters long
//     o  MUST contain only US-ASCII [ANSI.X3.4-1986] letters 'A' - 'Z' and
//        'a' - 'z', digits '0' - '9', and hyphens ('-', ASCII 0x2D or
//        decimal 45)
//     o  MUST contain at least one letter ('A' - 'Z' or 'a' - 'z')
//     o  MUST NOT begin or end with a hyphen
//     o  hyphens MUST NOT be adjacent to other hyphens
//
- (BOOL)isDisplayNameAndServiceTypeValid
{
    MCPeerID *peerID;
    @try {
        peerID = [[MCPeerID alloc] initWithDisplayName:self.displayNameTextField.text];
    }
    @catch (NSException *exception) {
        NSLog(@"Invalid display name [%@]", self.displayNameTextField.text);
        return NO;
    }

    // Check if using this service type string causes a framework exception
    MCNearbyServiceAdvertiser *advertiser;
    @try {
        advertiser = [[MCNearbyServiceAdvertiser alloc] initWithPeer:peerID discoveryInfo:nil serviceType:self.serviceTypeTextField.text];
    }
    @catch (NSException *exception) {
        NSLog(@"Invalid service type [%@]", self.serviceTypeTextField.text);
        return NO;
    }
    NSLog(@"Room Name [%@] (aka service type) and display name [%@] are valid", advertiser.serviceType, peerID.displayName);
    // all exception checks passed
    return YES;
}

#pragma mark - IBAction methods


#pragma mark - UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.view endEditing:YES];
    if ([self isDisplayNameAndServiceTypeValid]) {
        if (textField ==self.displayNameTextField)
        {
            [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:@"displayNameKey"];
        }
        if (textField==self.serviceTypeTextField) {
            [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:@"serviceTypeKey"];
        }
    }
    else {
        // These are mandatory fields.  Alert the user
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"群名称和昵称应该为长度在1-15之间的英文" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
}

@end
