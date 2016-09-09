//
//  SidebarViewController.m
//  SinkOrSwimiOSInterfaceBuilding
//
//  Created by Jenn Le on 9/5/16.
//  Copyright © 2016 Mobile Design Group. All rights reserved.
//

#import "SidebarViewController.h"
#import "MoviesTableViewController.h"
#import "MovieCollectionViewController.h"
#import "MoviesModel.h"
#import <JLTMDbClient.h>


@interface SidebarViewController ()

@property (strong, nonatomic) IBOutlet UISwitch *switcher;
@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, strong) NSArray *data;
@property (strong,nonatomic) MoviesModel* myMoviesModel;

@end

@implementation SidebarViewController

-(MoviesModel*)myMoviesModel{
    
    if(!_myMoviesModel)
        _myMoviesModel =[MoviesModel sharedInstance];
    
    return _myMoviesModel;
}

-(NSArray*) menuItems {
    if(!_menuItems) {   //using lazy instantiation to set an array with the cell identifiers
        _menuItems = @[@"title", @"popularMovies", @"upcomingMovies", @"topRatedMovies", @"appSettings", @"numOfMovies", @"numOfMoviesPicker", @"numOfReviews", @"numOfReviewsStepper", @"viewType"];
    }
    return _menuItems;
}

-(NSArray*) data {
    if(!_data) {   //using lazy instantiation to set an array with the cell identifiers
        _data = @[@"10", @"15",@"20"];
    }
    return _data;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Picker
    self.numMoviesPicker.delegate = self;
    self.numMoviesPicker.dataSource = self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}


//- (IBAction)switched:(UISwitch *)sender {
//
//    UISwitch *mySwitch = (UISwitch *)sender;
//    
//    MoviesTableViewController *movieTableViewController = [[MoviesTableViewController alloc] initWithNibName:nil bundle:nil];
//    
//    MovieCollectionViewController *movieCollectionViewController = [[MovieCollectionViewController alloc] initWithNibName:nil bundle:nil];
//    
//    if([mySwitch isOn]) {
//
//        [self.navigationController pushViewController:movieCollectionViewController animated:YES];
//    }
//    else {
//        
////        [self.navigationController pushViewController:movieTableViewController animated:YES];
//    }
//}


#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return 3;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* pickerLabel = (UILabel*)view;
    
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] init];
        
        pickerLabel.font = [UIFont fontWithName:@"SourceSansPro-Semibold"                size:14];
        
        pickerLabel.textAlignment=NSTextAlignmentCenter;
    }
    [pickerLabel setText:[self.data objectAtIndex:row]];
    
    return pickerLabel;
}

//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    NSString * title = nil;
//    
//    switch(row) {
//        case 0:
//            title = @"10";
//            break;
//        case 1:
//            title = @"20";
//            break;
//        case 2:
//            title = @"30";
//            break;
//    }
//    return title;
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    NSString *name = [self.menuItems objectAtIndex:indexPath.row];
    
    UINavigationController *navController = [segue destinationViewController];
    MovieCollectionViewController *movieCollectionViewController = (MovieCollectionViewController *)navController.topViewController;
    
    
    if( [name isEqual: @"popularMovies"] ) {
        [self.myMoviesModel setCategory:kJLTMDbMoviePopular];
    } else if( [name isEqual: @"upcomingMovies"] ) {
        [self.myMoviesModel setCategory:kJLTMDbMovieUpcoming];
    } else if( [name isEqual: @"topRatedMovies"] ) {
        [self.myMoviesModel setCategory:kJLTMDbMovieTopRated];
    } else if( [name isEqual: @"numOfMoviesPicker"] ) {
//        if([self.numMoviesPicker.description  isEqualToString: @"10"]) {
//            controller.numMovies = 10;
//        } else if([self.numMoviesPicker.description isEqualToString:@"15"]) {
//            controller.numMovies = 15;
//        } else if([self.numMoviesPicker.description isEqualToString:@"20"]) {
//            controller.numMovies = 20;
//        }
    }
    
    //Change from table to collection view
    UISwitch *mySwitch = (UISwitch *)sender;
    
    if([mySwitch isOn]) {
        
        NSLog(@"wtf");
//        MovieCollectionViewController *MovieCollectionViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MovieCollectionViewController"];
         [self.navigationController pushViewController:movieCollectionViewController animated:YES];
    }
    
    
    
}

@end