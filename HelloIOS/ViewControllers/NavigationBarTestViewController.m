//
//  NavigationBarTestViewController.m
//  HelloIOS
//
//  Created by 马壮 on 2024/6/28.
//

#import "NavigationBarTestViewController.h"

@interface NavigationBarTestViewController ()
@property (strong, nonatomic) UILabel * label;
@end

@implementation NavigationBarTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    CGFloat navigationBarHeight = 44;
    
    UINavigationBar * navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 100, screen.size.width, navigationBarHeight)];
    
    UIBarButtonItem * saveButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
    
    UIBarButtonItem * addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)];
    
    UINavigationItem * navigationItem = [[UINavigationItem alloc] initWithTitle:@""];
    navigationItem.leftBarButtonItem = saveButtonItem;
    navigationItem.rightBarButtonItem = addButtonItem;
    
    navigationBar.items = @[navigationItem];
    
    [self.view addSubview:navigationBar];
    
    CGFloat labelWidth = 84;
    CGFloat labelHeight = 21;
    CGFloat labelTopView = 300;
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake((screen.size.width - labelWidth) / 2, labelTopView, labelWidth, labelHeight)];
    
    self.label.text = @"Label";
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];
}

- (void)save:(id)sender {
    self.label.text = @"点击Save";
}

- (void)add:(id)sender {
    self.label.text = @"点击Add";
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
