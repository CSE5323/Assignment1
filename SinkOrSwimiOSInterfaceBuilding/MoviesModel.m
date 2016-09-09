#import <UIImageView+AFNetworking.h>
#import <JLTMDbClient.h>
#import "MoviesModel.h"

@interface MoviesModel()
@property (strong,nonatomic) NSString* currentCategory; //kJLTMDbMoviePopular, kJLTMDbMovieUpcoming, kJLTMDbMovieTopRated
@property (strong,nonatomic) NSArray* moviesArray;
@property (strong,nonatomic) NSArray* movieCategoriesArray;

@end

@implementation MoviesModel

+(MoviesModel*)sharedInstance{
    static MoviesModel * _sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate,^{
        _sharedInstance = [[MoviesModel alloc] init];
    });
    
    return _sharedInstance;
}

- (id) init {
    self = [super init];
    if (self != nil) {
        self.movieCategoriesArray = @[kJLTMDbMoviePopular, kJLTMDbMovieUpcoming, kJLTMDbMovieTopRated];
        self.currentCategory = kJLTMDbMoviePopular;
        if([self.moviesArray count] == 0){
            [self getMoviesConfiguration];
            [self fetchMovies];
        }
    }
    return self;
}

- (void) getMoviesConfiguration {
    NSLog(@"MoviesModel.getMoviesConfiguration");
    [[JLTMDbClient sharedAPIInstance] GET:kJLTMDbConfiguration withParameters:nil andResponseBlock:^(id response, NSError *error) {
        if (!error)
            self.imagesBaseUrlString = [response[@"images"][@"base_url"] stringByAppendingString:@"w92"];
        else{
            NSLog(@"Could not get movies configuration");
        }
    }];
}

- (void) fetchMovies {
    NSLog(@"MoviesModel.getMovies");
    [[JLTMDbClient sharedAPIInstance] GET:self.currentCategory withParameters:nil andResponseBlock:^(id response, NSError *error) {
        if (!error) {
            self.moviesArray = response[@"results"];
        }else{
            NSLog(@"Count not fetch movies");
        }
    }];
}

-(NSString*)getMovieCategoryTitle{
    if(self.currentCategory == kJLTMDbMoviePopular){
        return @"Popular Movies";
    }else if(self.currentCategory == kJLTMDbMovieUpcoming){
        return @"Upcoming Movies";
    }else if(self.currentCategory == kJLTMDbMovieTopRated){
        return @"Top Rated Movies";
    }else{
        return @"Invalid Movie Title";
    }
}

-(NSInteger)getTotalNumOfMovies {
    return [self.moviesArray count];
}

-(NSDictionary*)getMovieByIndex:(NSInteger)index{
    return self.moviesArray[index];
}

-(void)setCategory:(NSString*) category{
    self.currentCategory = category;
};


@end
