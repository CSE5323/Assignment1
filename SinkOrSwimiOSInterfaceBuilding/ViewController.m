//
//  ViewController.m
//  SinkOrSwimiOSInterfaceBuilding
//
//  Created by Ashley Isles on 9/8/16.
//  Copyright © 2016 Mobile Design Group. All rights reserved.
//
#import <UIImageView+AFNetworking.h>
#import <JLTMDbClient.h>
#import "ViewController.h"
#import "ImageModel.h"
#import "MovieDetailsViewController.h"


@interface ViewController ()

@property (strong, nonatomic) UIImageView* imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong,nonatomic) ImageModel* myImageModel;

@end

@implementation ViewController



-(ImageModel*)myImageModel{
    
    if(!_myImageModel)
        _myImageModel =[ImageModel sharedInstance];
    
    return _myImageModel;
}

-(NSString*)imageName{

    if(!_imageName)
        _imageName = @"Eric1";

        return _imageName;
}

-(UIImageView*)imageView{
    
    MovieDetailsViewController *detailsController = [[MovieDetailsViewController alloc] init];
    
    if(!_imageView)
        _imageView = [[UIImageView alloc] initWithImage:[[ImageModel sharedInstance] getImageWithName:self.imageName]];
    return _imageView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.scrollView addSubview:self.imageView];
    self.scrollView.contentSize = self.imageView.image.size;
    self.scrollView.minimumZoomScale = 0.1;
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
