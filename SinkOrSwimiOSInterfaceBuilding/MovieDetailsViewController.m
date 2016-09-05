#import <UIImageView+AFNetworking.h>
#import <JLTMDbClient.h>
#import "MovieDetailsViewController.h"
#import "MovieReviewViewController.h"
#import "MovieReview.h"

@interface MovieDetailsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *reviewsTable;

@end

@implementation MovieDetailsViewController

@synthesize movieReviews = _movieReviews;

-(NSMutableArray*)movieReviews{
    
    if(!_movieReviews)
        _movieReviews = [[NSMutableArray alloc] init];
    
    return _movieReviews;
}

- (IBAction)clickAddReview:(id)sender {
    MovieReviewViewController *movieReviewViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MovieReviewViewController"];
    [self.navigationController pushViewController:movieReviewViewController animated:YES];
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
    
    //setting up reviews table
    self.reviewsTable.rowHeight = 40.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.movieDescriptionTextView.text = self.movieDict[@"overview"];
    self.movieDescriptionTextView.font = [UIFont systemFontOfSize:14];
    self.movieDescriptionTextView.textColor = [UIColor lightGrayColor];
    
}

- (NSInteger)tableView:(UITableView *)reviesTable numberOfRowsInSection:(NSInteger)section {
    return self.movieReviews.count;
}

- (UITableViewCell *)tableView:(UITableView *)reviewsTable cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"MovieCell";
    
    UITableViewCell *cell = [reviewsTable dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    cell.textLabel.text = [self.movieReviews[indexPath.row] getTitle];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    return cell;
}

@end
