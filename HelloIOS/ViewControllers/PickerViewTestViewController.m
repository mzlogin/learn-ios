//
//  PickerViewTestViewController.m
//  HelloIOS
//
//  Created by 马壮 on 2024/7/8.
//

#import "PickerViewTestViewController.h"

@interface PickerViewTestViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) UILabel *label;

@property (strong, nonatomic) NSDictionary *pickerData;
@property (strong, nonatomic) NSArray *pickerProvincesData;
@property (strong, nonatomic) NSArray *pickerCitiesData;

@end

@implementation PickerViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"provinces_cities" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    self.pickerData = dict;
    self.pickerProvincesData = [self.pickerData allKeys];
    // 默认取出第一个省的所有市的数据
    NSString *selectedProvince = [self.pickerProvincesData objectAtIndex:0];
    self.pickerCitiesData = [self.pickerData objectForKey:selectedProvince];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    // PickerView
    CGFloat pickerViewWidth = 320;
    CGFloat pickerViewHeight = 162;
    CGFloat pickerViewTopView = 120;
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, pickerViewTopView, pickerViewWidth, pickerViewHeight)];
    
    [self.view addSubview:self.pickerView];
    
    self.pickerView.dataSource = self;
    [self.pickerView setDelegate:self];
    
    // Label
    CGFloat labelWidth = 200;
    CGFloat labelHeight = 21;
    CGFloat labelTopView = 400;
    self.label = [[UILabel alloc] initWithFrame:CGRectMake((screen.size.width - labelWidth) / 2, labelTopView, labelWidth, labelHeight)];
    self.label.text = @"Label";
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];
    
    // Button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Button" forState:UIControlStateNormal];
    
    CGFloat buttonWidth = 46;
    CGFloat buttonHeight = 30;
    CGFloat buttonTopView = 460;
    
    button.frame = CGRectMake((screen.size.width - buttonWidth) / 2, buttonTopView, buttonWidth, buttonHeight);
    [button addTarget:self action:@selector(onclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)onclick:(id)sender {
    NSInteger row1 = [self.pickerView selectedRowInComponent:0];
    NSInteger row2 = [self.pickerView selectedRowInComponent:1];
    NSString *selected1 = [self.pickerProvincesData objectAtIndex:row1];
    NSString *selected2 = [self.pickerCitiesData objectAtIndex:row2];
    
    NSString *title = [[NSString alloc] initWithFormat:@"%@, %@", selected1, selected2];
    
    self.label.text = title;
}

#pragma mark 实现 UIPickerViewDataSource 协议
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [self.pickerProvincesData count];
    } else {
        return [self.pickerCitiesData count];
    }
}

#pragma mark 实现 UIPickerViewDelegate 协议
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [self.pickerProvincesData objectAtIndex:row];
    } else {
        return [self.pickerCitiesData objectAtIndex:row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        NSString *selectedProvince = [self.pickerProvincesData objectAtIndex:row];
        NSArray *array = [self.pickerData objectForKey:selectedProvince];
        self.pickerCitiesData = array;
        [self.pickerView reloadComponent:1];
    }
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
