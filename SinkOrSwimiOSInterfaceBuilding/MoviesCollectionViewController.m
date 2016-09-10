#import <UIImageView+AFNetworking.h>
#import <JLTMDbClient.h>
#import "MoviesCollectionViewController.h"
#import "MoviesTableViewController.h"
#import "MoviesModel.h"
#import "CollectionViewCell.h"

@interface MoviesCollectionViewController ()


@property (strong,nonatomic) MoviesModel* myMoviesModel;

@end

@implementation MoviesCollectionViewController

-(MoviesModel*)myMoviesModel{
    
    if(!_myMoviesModel)
        _myMoviesModel =[MoviesModel sharedInstance];
    
    return _myMoviesModel;
}

static NSString * const reuseIdentifier = @"MovieBannerCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"MoviesTableViewController.viewDidLoad");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.myMoviesModel getTotalNumOfMovies];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSDictionary *movieDict = [self.myMoviesModel getMovieByIndex:indexPath.row];
    
    cell.backgroundColor = [UIColor blueColor];
    
    NSString *imageUrl = [self.myMoviesModel.imagesBaseUrlString stringByAppendingString:movieDict[@"poster_path"]];
    [cell.imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"TMDB"]];
    
    return cell;
}

@end