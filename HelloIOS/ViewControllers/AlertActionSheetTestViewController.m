//
//  AlertActionSheetTestViewController.m
//  HelloIOS
//
//  Created by 马壮 on 2024/6/26.
//

#import "AlertActionSheetTestViewController.h"

@interface AlertActionSheetTestViewController ()

@end

@implementation AlertActionSheetTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    // add button for AlertView
    UIButton * buttonAlertView = [UIButton buttonWithType:UIButtonTypeSystem];
    [buttonAlertView setTitle:@"Test警告框" forState:UIControlStateNormal];
    
    CGFloat buttonAlertViewWidth = 100;
    CGFloat buttonAlertViewHeight = 30;
    CGFloat buttonAlertViewTopView = 130;
    
    buttonAlertView.frame = CGRectMake((screen.size.width - buttonAlertViewWidth) / 2, buttonAlertViewTopView, buttonAlertViewWidth, buttonAlertViewHeight);
    [buttonAlertView addTarget:self action:@selector(testAlertView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:buttonAlertView];
    
    // add button for ActionSheet
    UIButton * buttonActionSheet = [UIButton buttonWithType:UIButtonTypeSystem];
    [buttonActionSheet setTitle:@"Test操作表" forState:UIControlStateNormal];
    
    CGFloat buttonActionSheetWidth = 100;
    CGFloat buttonActionSheetHeight = 30;
    CGFloat buttonActionSheetTopView = 260;
    
    buttonActionSheet.frame = CGRectMake((screen.size.width - buttonActionSheetWidth) / 2, buttonActionSheetTopView, buttonActionSheetWidth, buttonActionSheetHeight);
    [buttonActionSheet addTarget:self action:@selector(testActionSheet:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:buttonActionSheet];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)testAlertView:(id)sender {
    NSLog(@"testAlertView");
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Alert text goes here" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        NSLog(@"Tap No Button");
    }];
    
    UIAlertAction * yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSLog(@"Tap Yes Button");
    }];
    
    [alertController addAction:noAction];
    [alertController addAction:yesAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)testActionSheet:(id)sender {
    NSLog(@"testActionSheet");
    UIAlertController * actionSheetController = [[UIAlertController alloc] init];
    
    void (^ handler)(UIAlertAction *action) = ^(UIAlertAction * action) {
        NSLog(@"Tap %@ Button", action.title);
    };
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:handler];
//    UIAlertAction * cancelAction2 = [UIAlertAction actionWithTitle:@"取消2" style:UIAlertActionStyleCancel handler:handler];
    
    UIAlertAction * destructiveAction = [UIAlertAction actionWithTitle:@"破坏性按钮" style:UIAlertActionStyleDestructive handler:handler];
    UIAlertAction * destructiveAction2 = [UIAlertAction actionWithTitle:@"破坏性按钮2" style:UIAlertActionStyleDestructive handler:handler];
    
    UIAlertAction * otherAction = [UIAlertAction actionWithTitle:@"其它按钮" style:UIAlertActionStyleDefault handler:handler];
    UIAlertAction * otherAction2 = [UIAlertAction actionWithTitle:@"其它按钮2" style:UIAlertActionStyleDefault handler:handler];
    
    [actionSheetController addAction:cancelAction];
    // 只能有一个 UIAlertActionStyleCancel 的 Action，加两个会报错
//    [actionSheetController addAction:cancelAction2];
    [actionSheetController addAction:destructiveAction];
    [actionSheetController addAction:destructiveAction2];
    [actionSheetController addAction:otherAction];
    [actionSheetController addAction:otherAction2];
    
    actionSheetController.popoverPresentationController.sourceView = sender;
    
    [self presentViewController:actionSheetController animated:YES completion:nil];
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
