//
//  SidebarViewController.m
//  SinkOrSwimiOSInterfaceBuilding
//
//  Created by Jenn Le on 9/5/16.
//  Copyright © 2016 Mobile Design Group. All rights reserved.
//

#import "SidebarViewController.h"
#import "MoviesTableViewController.h"
#import "MoviesCollectionViewController.h"
#import "MovieReviewViewController.h"
#import "MoviesModel.h"
#import <JLTMDbClient.h>


@interface SidebarViewController ()


@property (weak, nonatomic) IBOutlet UISwitch *collectionSwitcher;
@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, strong) NSArray *pickerData;
@property (strong,nonatomic) MoviesModel* myMoviesModel;
@property (weak, nonatomic) IBOutlet UIPickerView *numMoviesPicker;
@property (weak, nonatomic) IBOutlet UIStepper *movieTextFontSizeStepper;
@property (weak, nonatomic) IBOutlet UILabel *fontSizeLabel;

@end

@implementation SidebarViewController

-(MoviesModel*)myMoviesModel{
    
    if(!_myMoviesModel)
        _myMoviesModel =[MoviesModel sharedInstance];
    
    return _myMoviesModel;
}

-(NSArray*) menuItems {
    if(!_menuItems) {
        _menuItems = @[@"title", @"popularMovies", @"upcomingMovies", @"topRatedMovies", @"appSettings", @"viewType", @"movieTextFontSize", @"movieTextFontSizeStepper", @"numOfMovies"];
    }
    return _menuItems;
}

-(NSArray*) pickerData {
    if(!_pickerData) {
        _pickerData = @[@"10", @"15",@"20"];
    }
    return _pickerData;
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
- (IBAction)movieTextFontSizeStepperChanged:(id)sender {
    NSLog(@"SidebarViewController.movieTextFontSizeStepperChanged");
    self.myMoviesModel.fontSize = (int)self.movieTextFontSizeStepper.value;
    self.fontSizeLabel.text = [NSString stringWithFormat:@"%d", (int)self.movieTextFontSizeStepper.value];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updatedMovies" object:self];
}
- (IBAction)collectionSwitcherChanged:(id)sender {
    NSLog(@"SidebarViewController.collectionSwitcherChanged");
    UISwitch *backgroundColorSwitch = (UISwitch *)sender;
    if ([backgroundColorSwitch isOn]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addBackgroundTimer" object:self];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"removeBackgroundTimer" object:self];
    }
}


//Picker delegate functions
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.pickerData count];
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return self.pickerData[row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"clicked picker");
    
    self.myMoviesModel.maxNumberOfMovies = [[self.pickerData objectAtIndex:row] integerValue];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updatedMovies" object:self];
}

//Table view delegate functions
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    NSString *name = [self.menuItems objectAtIndex:indexPath.row];
    


//    UINavigationController *navController = (UINavigationController*)[segue destinationViewController];
//    MoviesCollectionViewController *eventsController = (MoviesCollectionViewController*)[navController topViewController];
    
    if( [name isEqual: @"popularMovies"] ) {
        [self.myMoviesModel setCategory:kJLTMDbMoviePopular];
    } else if( [name isEqual: @"upcomingMovies"] ) {
        [self.myMoviesModel setCategory:kJLTMDbMovieUpcoming];
    } else if( [name isEqual: @"topRatedMovies"] ) {
        [self.myMoviesModel setCategory:kJLTMDbMovieTopRated];
    } else if( [name isEqual: @"viewType"] ) {
//        [self.myMoviesModel setCategory:kJLTMDbMovieTopRated];
    }
}

@end