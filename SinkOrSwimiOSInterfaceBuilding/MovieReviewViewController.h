#import <UIKit/UIKit.h>
#import "MovieReview.h"

@interface MovieReviewViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) NSString *movieTitle;

+(NSMutableDictionary*) reviewsArray;
+(void) addReview:(MovieReview*) movieReview movieTitle:(NSString*) movieTitle;

+(NSMutableArray*) getReviewsByTitle:(NSString*) movieTitle;

@end
