
#import <UIKit/UIKit.h>

// TAG used in our custom table view cell to retreive this view
#define PROGRESS_VIEW_TAG (101)

@class Transcript;

@interface ProgressView : UIView

@property (nonatomic, assign) Transcript *transcript;

// Class method for computing a view height based on a given message transcript
+ (CGFloat)viewHeightForTranscript:(Transcript *)transcript;

@end
