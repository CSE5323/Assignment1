#import <UIImageView+AFNetworking.h>
#import <JLTMDbClient.h>
#import "MovieDetailsViewController.h"
#import "MovieReviewViewController.h"
#import "MovieReview.h"
#import "MoviesModel.h"
#import "MovieCoverBigViewController.h"

@interface MovieDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *movieCoverImageView;
@property (weak, nonatomic) IBOutlet UITextView *movieDescriptionTextView;
@property (weak, nonatomic) IBOutlet UILabel *avgReviewsLabel;

@end

@implementation MovieDetailsViewController

- (IBAction)clickAddReview:(id)sender {
    MovieReviewViewController *movieReviewViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MovieReviewViewController"];
    [self.navigationController pushViewController:movieReviewViewController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.movieTitle;
    __block NSString *imageBackdrop;
    
    [[JLTMDbClient sharedAPIInstance] GET:kJLTMDbMovie withParameters:@{@"id":self.movieId} andResponseBlock:^(id response, NSError *error) {
        if (!error) {
            self.movieDict = response;
            
            //Movie description text
            self.movieDescriptionTextView.text = self.movieDict[@"overview"];
            self.movieDescriptionTextView.font = [UIFont systemFontOfSize:14];
            self.movieDescriptionTextView.textColor = [UIColor lightGrayColor];
            
            //Movie cover image view
            if (self.movieDict[@"backdrop_path"] != [NSNull null]){
                imageBackdrop = [[MoviesModel sharedInstance].imagesBaseUrlString stringByReplacingOccurrencesOfString:@"w92" withString:@"w780"];
                [self.movieCoverImageView setImageWithURL:[NSURL URLWithString:[imageBackdrop stringByAppendingString:self.movieDict[@"backdrop_path"]]]];
            } else {
                imageBackdrop = [[MoviesModel sharedInstance].imagesBaseUrlString stringByReplacingOccurrencesOfString:@"w92" withString:@"w500"];
                [self.movieCoverImageView setImageWithURL:[NSURL URLWithString:[imageBackdrop stringByAppendingString:self.movieDict[@"poster_path"]]]];
            }
        }else{
            NSLog([NSString stringWithFormat:@"%@%@", @"Cannot get movie with ID#",
                   self.movieId]);
        }
    }];
    
    //Movie cover image click
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    [self.movieCoverImageView setUserInteractionEnabled:YES];
    [self.movieCoverImageView addGestureRecognizer:singleTap];
    
    //Avg reviews label default
    self.avgReviewsLabel.text = @"Avg Reviews - 5";
}


-(void)tapDetected{
    NSLog(@"MovieDetailsViewController.tapDetected");
    [self performSegueWithIdentifier:@"MovieBigCoverSeque" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"MovieDetailsViewController.prepareForSegue");
    
    BOOL isBigCoverView = [[segue destinationViewController] isKindOfClass:[MovieCoverBigViewController class]];
    

    if(isBigCoverView){
        MovieCoverBigViewController *vc = [segue destinationViewController];
        
        vc.image = self.movieCoverImageView.image;
    }
}

@end
