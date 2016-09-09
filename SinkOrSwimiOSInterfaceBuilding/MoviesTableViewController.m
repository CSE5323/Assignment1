#import <UIImageView+AFNetworking.h>
#import <JLTMDbClient.h>
#import "MoviesTableViewController.h"
#import "MoviesModel.h"
#import "MovieDetailsViewController.h"


@interface MoviesTableViewController ()

@property (strong,nonatomic) MoviesModel* myMoviesModel;

@end

@implementation MoviesTableViewController

-(MoviesModel*)myMoviesModel{
    
    if(!_myMoviesModel)
        _myMoviesModel =[MoviesModel sharedInstance];
    
    return _myMoviesModel;
}

-(void)checkRes:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:@"updatedMovies"])
    {
        [self.tableView reloadData];
    }
}

- (void)randomlyChangeBackgroundColor{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    self.tableView.backgroundColor = color;
}
- (void)viewDidLoad {
    NSLog(@"MoviesTableViewController.viewDidLoad");
    
    [super viewDidLoad];

    self.tableView.rowHeight = 60.0f;
    
    //Randomly change background color
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval: 1 target:self selector:@selector(randomlyChangeBackgroundColor) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    //Refresh when pulling down from top
//    self.refreshControl = [[UIRefreshControl alloc] init];
//    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    
    //Sidebar menu
    SWRevealViewController *revealViewController = self.revealViewController;
    //revealViewController.delegate = self;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    //Default # of movies at 10
    self.myMoviesModel.maxNumberOfMovies = 10;
    
    //Set view title
    self.mainNavItem.title = [self.myMoviesModel getMovieCategoryTitle];
    
    //Receive notifications when it needs to update the table when the movies have been loaded
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updatedMovies" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkRes:) name:@"updatedMovies" object:nil];
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.myMoviesModel getTotalNumOfMovies];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"MovieCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //Get movie by indexPath.row
    NSDictionary *movieDict = [self.myMoviesModel getMovieByIndex:indexPath.row];
    
    //Setup table cell text
    cell.textLabel.text = movieDict[@"original_title"];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [cell.textLabel.font fontWithSize:self.myMoviesModel.fontSize];
    
    //Setup table cell imageView
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    if (movieDict[@"poster_path"] != [NSNull null]) {
        NSString *imageUrl = [self.myMoviesModel.imagesBaseUrlString stringByAppendingString:movieDict[@"poster_path"]];
        [cell.imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"TMDB"]];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MovieDetailsViewController *movieDetailViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MovieDetailsViewController"];
    
    NSDictionary *movieDict = [self.myMoviesModel getMovieByIndex:indexPath.row];
    
    movieDetailViewController.movieId = movieDict[@"id"];
    movieDetailViewController.movieTitle = movieDict[@"title"];
    [self.navigationController pushViewController:movieDetailViewController animated:YES];
}

@end
