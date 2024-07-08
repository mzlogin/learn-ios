//
//  DatePickerTestViewController.m
//  HelloIOS
//
//  Created by 马壮 on 2024/7/8.
//

#import "DatePickerTestViewController.h"

@interface DatePickerTestViewController ()

@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) UILabel *label;

@end

@implementation DatePickerTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    CGFloat datePickerWidth = 320;
    CGFloat datePickerHeight = 167;
    CGFloat datePickerTopView = 120;
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, datePickerTopView, datePickerWidth, datePickerHeight)];
    self.datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh-Hans"];
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    
    [self.view addSubview:self.datePicker];
    
    CGFloat labelWidth = 200;
    CGFloat labelHeight = 21;
    CGFloat labelTopView = 350;
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake((screen.size.width - labelWidth) / 2, labelTopView, labelWidth, labelHeight)];
    self.label.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Button" forState:UIControlStateNormal];
    
    CGFloat buttonWidth = 46;
    CGFloat buttonHeight = 30;
    CGFloat buttonTopView = 400;
    
    button.frame = CGRectMake((screen.size.width - buttonWidth) / 2, buttonTopView, buttonWidth, buttonHeight);
    [button addTarget:self action:@selector(onclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)onclick:(id)sender {
    NSDate * theDate = self.datePicker.date;
    NSLog(@"the date picked is %@", [theDate descriptionWithLocale:[NSLocale currentLocale]]);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dateFormatted = [dateFormatter stringFromDate:theDate];
    NSLog(@"the date formatted is %@", dateFormatted);
    self.label.text = dateFormatted;
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
