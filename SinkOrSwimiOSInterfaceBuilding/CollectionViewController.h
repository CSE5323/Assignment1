#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"


@interface CollectionViewController : UICollectionViewController

@property (copy, nonatomic) NSString *imagesBaseUrlString;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) NSArray *moviesArray;



@end
