#import <UIKit/UIKit.h>

@interface MoviesTableViewController : UITableViewController <UIAlertViewDelegate>

@property (nonatomic, assign) NSInteger categoryCounter;
@property (copy, nonatomic) NSString *imagesBaseUrlString;
@property (strong, nonatomic) NSArray *moviesArray;
@property (weak, nonatomic) IBOutlet UINavigationItem *mainNavItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
