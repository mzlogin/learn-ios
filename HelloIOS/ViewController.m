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
#import "ViewControllers/ToolbarTestViewController.h"
#import "ViewControllers/NavigationBarTestViewController.h"
#import "ViewControllers/DatePickerTestViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *labelAndTextFieldTestButton;
@property (weak, nonatomic) IBOutlet UIButton *switchSlideSegmentedControlTestButton;
@property (weak, nonatomic) IBOutlet UIButton *webViewTestButton;
@property (weak, nonatomic) IBOutlet UIButton *alertActionSheetTestButton;
@property (weak, nonatomic) IBOutlet UIButton *activeIndicatorProgressTestButton;
@property (weak, nonatomic) IBOutlet UIButton *toolbarTestButton;
@property (weak, nonatomic) IBOutlet UIButton *navigationBarTestButton;
@property (weak, nonatomic) IBOutlet UIButton *datePickerTestButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"HelloIOS";
    
    [self addDefaultAction:self.labelAndTextFieldTestButton];
    [self addDefaultAction:self.switchSlideSegmentedControlTestButton];
    [self addDefaultAction:self.webViewTestButton];
    [self addDefaultAction:self.alertActionSheetTestButton];
    [self addDefaultAction:self.activeIndicatorProgressTestButton];
    [self addDefaultAction:self.toolbarTestButton];
    [self addDefaultAction:self.navigationBarTestButton];
    [self addDefaultAction:self.datePickerTestButton];
}

- (void)addDefaultAction:(UIButton*) button {
    [button addTarget:self action:@selector(openViewController:) forControlEvents:UIControlEventTouchUpInside];
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
    } else if ([sender isEqual:self.toolbarTestButton]) {
        controller = [[ToolbarTestViewController alloc] init];
    } else if ([sender isEqual:self.navigationBarTestButton]) {
        controller = [[NavigationBarTestViewController alloc] init];
    } else if ([sender isEqual:self.datePickerTestButton]) {
        controller = [[DatePickerTestViewController alloc] init];
    }

    if (controller != nil) {
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end
