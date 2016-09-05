#import <UIImageView+AFNetworking.h>
#import <JLTMDbClient.h>
#import "MovieReviewViewController.h"
#import "MovieDetailsViewController.h"
#import "MovieReview.h"

@interface MovieReviewViewController ()
@property (weak, nonatomic) IBOutlet UITextField *reviewTitleTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *reviewScrollView;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UISlider *ratingSliderValue;
@property (weak, nonatomic) IBOutlet UITextView *reviewText;
@property (nonatomic) MovieDetailsViewController *movieDetailsViewController;

@end

@implementation MovieReviewViewController

float oldX;

#pragma mark - UI Element Set Up

- (void)viewDidLoad {
    [super viewDidLoad];
    self.reviewTitleTextField.delegate = self;
    
    self.ratingSliderValue.tintColor = [UIColor darkGrayColor];
    self.ratingSliderValue.value = 0;
    self.ratingSliderValue.maximumValue = 5.0;
    
    self.reviewText.layer.borderWidth = 1.0f;
    self.reviewText.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.reviewText.layer.cornerRadius = 8;
    
    self.reviewText.delegate = self;
    self.reviewText.text = @"Movie review...";
    self.reviewText.textColor = [UIColor lightGrayColor]; //optional
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLayoutSubviews {
}

-(BOOL) textFieldShouldReturn:(UITextField *)reviewTitleTextField{
    [reviewTitleTextField resignFirstResponder];
    return YES;
}

-(BOOL) reviewTextFieldShouldReturn:(UITextView *)reviewText{
    [reviewText resignFirstResponder];
    return YES;
}

- (IBAction)textFieldReturnOnTap:(UITapGestureRecognizer *)sender {
    [self textFieldShouldReturn:self.reviewTitleTextField];
    [self reviewTextFieldShouldReturn:self.reviewText];
}

- (IBAction)ratingSlider:(UISlider *)sender {
    NSInteger ratingValue = self.ratingSliderValue.value;
    self.rating.text = [NSString stringWithFormat:@"Rating: %ld", (long)ratingValue];
}


//
- (void)textViewDidBeginEditing:(UITextView *)reviewText
{
    if ([reviewText.text isEqualToString:@"Movie review..."]) {
        reviewText.text = @"";
        reviewText.textColor = [UIColor blackColor]; //optional
    }
    [reviewText becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)reviewText
{
    if ([reviewText.text isEqualToString:@""]) {
        reviewText.text = @"Movie review...";
        reviewText.textColor = [UIColor lightGrayColor]; //optional
    }
    [reviewText resignFirstResponder];
}

#pragma mark - Information Collection and Storage

- (IBAction)submitReview:(UIButton *)sender {
    NSString* title = self.reviewTitleTextField.text;
    NSInteger ratingValue = self.ratingSliderValue.value;
    NSString* description = self.reviewText.text;
    
    MovieReview* review = [[MovieReview alloc] initWithEverything:title :ratingValue :description];
    
    [self.movieDetailsViewController.movieReviews addObject:review];
    
    
    [self.navigationController popViewControllerAnimated:YES];
}



@end
