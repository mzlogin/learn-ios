//
//  RootViewController.m
//  HelloIOS
//
//  Created by 马壮 on 2024/6/24.
//

#import "ViewController.h"
#import "ViewControllers/LabelAndTextFieldTestViewController.h"
#import "ViewControllers/SwitchSlideSegmentedControlTestViewController.h"
#import "ViewControllers/WebViewTestViewController.h"
#import "ViewControllers/AlertActionSheetTestViewController.h"
#import "ViewControllers/ActivityIndicatorProgressViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *labelAndTextFieldTestButton;
@property (weak, nonatomic) IBOutlet UIButton *switchSlideSegmentedControlTestButton;
@property (weak, nonatomic) IBOutlet UIButton *webViewTestButton;
@property (weak, nonatomic) IBOutlet UIButton *alertActionSheetTestButton;
@property (weak, nonatomic) IBOutlet UIButton *activeIndicatorProgressTestButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"HelloIOS";
    
    [self.labelAndTextFieldTestButton addTarget:self action:@selector(openViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.switchSlideSegmentedControlTestButton addTarget:self action:@selector(openViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.webViewTestButton addTarget:self action:@selector(openViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.alertActionSheetTestButton addTarget:self action:@selector(openViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.activeIndicatorProgressTestButton addTarget:self action:@selector(openViewController:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)openViewController:(id)sender {
    UIStoryboard * mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController * controller;
    
    if ([sender isEqual:self.labelAndTextFieldTestButton]) {
        controller = [mainStoryBoard instantiateViewControllerWithIdentifier:@"LabelAndTextFieldTest"];
    } else if ([sender isEqual:self.switchSlideSegmentedControlTestButton]) {
        controller = [mainStoryBoard instantiateViewControllerWithIdentifier:@"SwitchSlideSegmentedControlTest"];
    } else if ([sender isEqual:self.webViewTestButton]) {
        controller = [mainStoryBoard instantiateViewControllerWithIdentifier:@"WebViewTest"];
    } else if ([sender isEqual:self.alertActionSheetTestButton]) {
        controller = [[AlertActionSheetTestViewController alloc] init];
    } else if ([sender isEqual:self.activeIndicatorProgressTestButton]) {
        controller = [[ActivityIndicatorProgressViewController alloc] init];
    }
    
    if (controller != nil) {
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end
