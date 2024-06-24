//
//  ViewController.m
//  SwitchSliderSegmentedControlSample
//
//  Created by 马壮 on 2024/6/18.
//

#import "SwitchSlideSegmentedControlTestViewController.h"

@interface SwitchSlideSegmentedControlTestViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *leftSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *rightSwitch;
@property (weak, nonatomic) IBOutlet UILabel *sliderValue;

@end

@implementation SwitchSlideSegmentedControlTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)switchValueChanged:(id)sender {
    UISwitch * whichSwitch = (UISwitch *)sender;
    BOOL setting = whichSwitch.isOn;
    [self.leftSwitch setOn:setting animated:YES];
    [self.rightSwitch setOn:setting animated:YES];
}
- (IBAction)sliderValueChanged:(id)sender {
    NSLog(@"sliderValueChanged");
    UISlider *slider = (UISlider*)sender;
    int progressAsInt = (int)(slider.value);
    NSString *newText = [[NSString alloc]initWithFormat:@"%d", progressAsInt];
    self.sliderValue.text = newText;
}
- (IBAction)segmentValueChanged:(id)sender {
    NSLog(@"segmentTouchDown");
    if (self.leftSwitch.hidden == YES) {
        self.rightSwitch.hidden = NO;
        self.leftSwitch.hidden = NO;
    } else {
        self.rightSwitch.hidden = YES;
        self.leftSwitch.hidden = YES;
    }
}

@end
