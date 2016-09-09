#import <UIImageView+AFNetworking.h>
#import <JLTMDbClient.h>
#import "MovieCoverBigViewController.h"
#import "ImageModel.h"
#import "MovieDetailsViewController.h"


@interface MovieCoverBigViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation MovieCoverBigViewController


-(UIImageView*)imageView {
    
    
    if(!_imageView)
    {
        _imageView =[[UIImageView alloc] initWithImage:self.image];
    }
    
    return _imageView;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.scrollView addSubview:self.imageView];
    self.scrollView.contentSize = self.imageView.image.size;
    self.scrollView.minimumZoomScale = .1;
    self.scrollView.delegate = self;
    
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
