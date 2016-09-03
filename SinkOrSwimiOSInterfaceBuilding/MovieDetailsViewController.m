#import <UIImageView+AFNetworking.h>
#import <JLTMDbClient.h>
#import "MovieDetailsViewController.h"

@interface MovieDetailsViewController ()

@end

@implementation MovieDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.movieTitle;
    __block NSString *imageBackdrop;
    __block UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"") message:NSLocalizedString(@"Please try again later", @"") delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Ok", @""), nil];
    [[JLTMDbClient sharedAPIInstance] GET:kJLTMDbMovie withParameters:@{@"id":self.movieId} andResponseBlock:^(id response, NSError *error) {
        if (!error) {
            self.movieDict = response;
            if (self.movieDict[@"backdrop_path"] != [NSNull null]){
                imageBackdrop = [self.imagesBaseUrlString stringByReplacingOccurrencesOfString:@"w92" withString:@"w780"];
                [self.movieCoverImageView setImageWithURL:[NSURL URLWithString:[imageBackdrop stringByAppendingString:self.movieDict[@"backdrop_path"]]]];
            } else {
                imageBackdrop = [self.imagesBaseUrlString stringByReplacingOccurrencesOfString:@"w92" withString:@"w500"];
                [self.movieCoverImageView setImageWithURL:[NSURL URLWithString:[imageBackdrop stringByAppendingString:self.movieDict[@"poster_path"]]]];
            }
        }else
            [errorAlertView show];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.movieDescriptionTextView.text = self.movieDict[@"overview"];
    self.movieDescriptionTextView.font = [UIFont systemFontOfSize:17];
    self.movieDescriptionTextView.textColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
}

@end
