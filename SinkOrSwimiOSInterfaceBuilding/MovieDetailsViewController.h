#import <UIKit/UIKit.h>

@interface MovieDetailsViewController : UIViewController

@property (strong, nonatomic) NSString *movieId;
@property (strong, nonatomic) NSString *movieTitle;

@property (strong, nonatomic) NSDictionary *movieDict;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (strong,nonatomic) NSMutableArray* movieReviews;


@end

