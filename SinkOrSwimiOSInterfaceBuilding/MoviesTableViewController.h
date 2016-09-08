#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface MoviesTableViewController : UITableViewController <UIAlertViewDelegate>

@property (nonatomic, assign) NSInteger categoryCounter;
@property (copy, nonatomic) NSString *imagesBaseUrlString;
@property (strong, nonatomic) NSArray *moviesArray;
@property (nonatomic, assign) NSInteger numMovies;
@property (weak, nonatomic) IBOutlet UINavigationItem *mainNavItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
