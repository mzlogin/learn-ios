//
//  ViewController.m
//  HelloIOS
//
//  Created by 马壮 on 2023/9/3.
//

#import "LabelAndTextFieldTestViewController.h"

@interface LabelAndTextFieldTestViewController ()
@property (weak, nonatomic) IBOutlet UILabel *helloLabel;
@property (weak, nonatomic) IBOutlet UITextField *bookNameTextField;

- (IBAction)onClick:(id)sender;

@end

@implementation LabelAndTextFieldTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)keyboardDidShow: (NSNotification *)notif {
    NSLog(@"键盘打开");
}

-(void)keyboardDidHide: (NSNotification *)notif {
    NSLog(@"键盘关闭");
}

- (void)viewWillAppear:(BOOL)animated {
    // 注册键盘出现的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    // 注册键盘隐藏通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    // 解除键盘出现通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    // 解除键盘隐藏通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [super viewWillDisappear:animated];
}

- (IBAction)onClick:(id)sender {
    self.bookName = self.bookNameTextField.text;
    NSString *nameString = self.bookName;
    if (nameString != nil && [nameString length] == 0) {
        nameString = @"World";
    }
    NSString *greeting = [[NSString alloc] initWithFormat:@"Hello, %@!", nameString];
    
    self.helloLabel.text = greeting;
}

// 通过委托来放弃“第一响应者”
#pragma mark - UITextField Delegate Method
- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITextView Delegate Method
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
