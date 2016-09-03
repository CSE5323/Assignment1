#import <UIKit/UIKit.h>

@interface MovieDetailsViewController : UIViewController

@property (strong, nonatomic) NSString *movieId;
@property (strong, nonatomic) NSString *movieTitle;
@property (strong, nonatomic) NSDictionary *movieDict;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (copy, nonatomic) NSString *imagesBaseUrlString;

@property (weak, nonatomic) IBOutlet UIImageView *movieCoverImageView;
@property (weak, nonatomic) IBOutlet UITextView *movieDescriptionTextView;

@end

