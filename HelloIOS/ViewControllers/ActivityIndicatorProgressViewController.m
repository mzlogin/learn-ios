//
//  ActivityIndicatorProgressViewController.m
//  HelloIOS
//
//  Created by 马壮 on 2024/6/26.
//

#import "ActivityIndicatorProgressViewController.h"

@interface ActivityIndicatorProgressViewController ()
@property (strong, nonatomic) UIActivityIndicatorView * activityIndicatorView;
@property (strong, nonatomic) UIProgressView * progressView;
@property (strong, nonatomic) NSTimer * timer;
@end

@implementation ActivityIndicatorProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    // 添加活动指示器
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    
    CGRect frame = self.activityIndicatorView.frame;
    frame.origin = CGPointMake((screen.size.width - frame.size.width) / 2, 84);
    self.activityIndicatorView.frame = frame;
    
    self.activityIndicatorView.hidesWhenStopped = false;
    [self.view addSubview:self.activityIndicatorView];
    
    // upload 按钮
    UIButton * buttonUpload = [UIButton buttonWithType:UIButtonTypeSystem];
    [buttonUpload setTitle:@"Upload" forState:UIControlStateNormal];
    
    CGFloat buttonUploadWidth = 50;
    CGFloat buttonUploadHeight = 30;
    CGFloat buttonUploadTopView = 190;
    
    buttonUpload.frame = CGRectMake((screen.size.width - buttonUploadWidth) / 2, buttonUploadTopView, buttonUploadWidth, buttonUploadHeight);
    [buttonUpload addTarget:self action:@selector(startToMove:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonUpload];
    
    // 进度条
    CGFloat progressViewWidth = 200;
    CGFloat progressViewHeight = 2;
    CGFloat progressViewTopView = 283;
    
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake((screen.size.width - progressViewWidth) / 2, progressViewTopView, progressViewWidth, progressViewHeight)];
    [self.view addSubview:self.progressView];
    
    // download 按钮
    UIButton * buttonDownload = [UIButton buttonWithType:UIButtonTypeSystem];
    [buttonDownload setTitle:@"Download" forState:UIControlStateNormal];
    
    CGFloat buttonDownloadWidth = 69;
    CGFloat buttonDownloadHeight = 30;
    CGFloat buttonDownloadTopView = 384;
    
    buttonDownload.frame = CGRectMake((screen.size.width - buttonDownloadWidth) / 2, buttonDownloadTopView, buttonDownloadWidth, buttonDownloadHeight);
    [buttonDownload addTarget:self action:@selector(downloadProgress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonDownload];
}

- (void)downloadProgress:(id)sender {
    self.progressView.progress = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(download) userInfo:nil repeats:YES];
}

- (void)download {
    self.progressView.progress += 0.1;
    if (self.progressView.progress == 1.0) {
        [self.timer invalidate];
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"download completed!" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)startToMove:(id)sender {
    if ([self.activityIndicatorView isAnimating]) {
        [self.activityIndicatorView stopAnimating];
    } else {
        [self.activityIndicatorView startAnimating];
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
