#import <UIKit/UIKit.h>

@interface MovieDetailsViewController : UIViewController

@property (strong, nonatomic) NSString *movieId;
@property (strong, nonatomic) NSString *movieTitle;
@property (strong, nonatomic) NSDictionary *movieDict;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (strong,nonatomic) NSMutableArray* movieReviews;

@property (weak, nonatomic) IBOutlet UITextView *movieDescriptionTextView;

@property (weak, nonatomic) IBOutlet UIImageView *movieCoverImageView;
@property (weak, nonatomic) IBOutlet UILabel *avgReviewLabel;


@end

