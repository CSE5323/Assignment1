//
//  SidebarViewController.m
//  SinkOrSwimiOSInterfaceBuilding
//
//  Created by Jenn Le on 9/5/16.
//  Copyright © 2016 Mobile Design Group. All rights reserved.
//

#import "SidebarViewController.h"

@interface SidebarViewController ()

@property (nonatomic, strong) NSArray *menuItems;
@end

@implementation SidebarViewController

-(NSArray*) menuItems {
    if(!_menuItems) {
        _menuItems = @[@"title", @"popularMovies", @"upcomingMovies", @"topRatedMovies", @"appSettings", @"numOfMovies", @"numOfMoviesPicker", @"numOfReviews", @"numOfReviewsStepper", @"tableType", @"nightMode"];
    }
    return _menuItems;
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [self.menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}

@end