//
//  ToolbarTestViewController.m
//  HelloIOS
//
//  Created by 马壮 on 2024/6/28.
//

#import "ToolbarTestViewController.h"

@interface ToolbarTestViewController ()
@property (strong, nonatomic) UILabel * label;
@end

@implementation ToolbarTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    CGFloat toolbarHeight = 44;
    
    UIToolbar * toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, screen.size.height - toolbarHeight, screen.size.width, toolbarHeight)];
    
    UIBarButtonItem * saveButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
    UIBarButtonItem * openButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Open" style:UIBarButtonItemStylePlain target:self action:@selector(open:)];
    UIBarButtonItem * flexibleButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    toolbar.items = @[saveButtonItem, flexibleButtonItem, openButtonItem];
    [self.view addSubview:toolbar];
    
    CGFloat labelWidth = 84;
    CGFloat labelHeight = 21;
    CGFloat labelTopView = 250;
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake((screen.size.width - labelWidth) / 2, labelTopView, labelWidth, labelHeight)];
    self.label.text = @"Label";
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];
}

- (void)save:(id)sender {
    self.label.text = @"点击Save";
}

- (void)open:(id)sender {
    self.label.text = @"点击Open";
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
