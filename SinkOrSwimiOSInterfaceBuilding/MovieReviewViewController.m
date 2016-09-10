#import <UIImageView+AFNetworking.h>
#import <JLTMDbClient.h>
#import "MovieReviewViewController.h"
#import "MovieDetailsViewController.h"

#import "MoviesModel.h"

@interface MovieReviewViewController ()
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UISlider *ratingSliderValue;

@property (strong,nonatomic) MoviesModel* myMoviesModel;

@end

@implementation MovieReviewViewController

+(NSMutableDictionary*)reviewsArray{
    static NSMutableDictionary * _reviewsArray = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate,^{
        _reviewsArray = [[NSMutableDictionary alloc]init];
    });
    
    return _reviewsArray;
}

+(NSMutableArray*) getReviewsByTitle:(NSString*) movieTitle{
    BOOL hasReviews = [[MovieReviewViewController reviewsArray][movieTitle] isKindOfClass:[NSArray class]];
    if(!hasReviews){
        [MovieReviewViewController reviewsArray][movieTitle] = [[NSMutableArray alloc]init];
    }
    return [MovieReviewViewController reviewsArray][movieTitle];
}
+(void) addReview:(MovieReview*) movieReview movieTitle:(NSString*) movieTitle{
    [[self getReviewsByTitle:movieTitle] addObject:[NSNumber numberWithInteger:movieReview.rating]];
}

-(MoviesModel*)myMoviesModel{
    
    if(!_myMoviesModel)
        _myMoviesModel =[MoviesModel sharedInstance];
    
    return _myMoviesModel;
}

#pragma mark - UI Element Set Up

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ratingSliderValue.tintColor = [UIColor darkGrayColor];
    self.ratingSliderValue.value = 5;
    self.ratingSliderValue.maximumValue = 5.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)ratingSlider:(UISlider *)sender {
    NSInteger ratingValue = self.ratingSliderValue.value;
    self.rating.text = [NSString stringWithFormat:@"Rating: %ld", (long)ratingValue];
}

#pragma mark - Information Collection and Storage

- (IBAction)submitReview:(UIButton *)sender {
    
    MovieReview* review = [[MovieReview alloc] initWithEverything:self.ratingSliderValue.value];
    
    [MovieReviewViewController addReview:review movieTitle:self.movieTitle];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updatedReviews" object:self];
    [self.navigationController popViewControllerAnimated:YES];
}



@end
