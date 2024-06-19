//
//  ViewController.m
//  WebViewSample
//
//  Created by 马壮 on 2024/6/19.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)loadHtmlString:(id)sender {
    NSString *htmlPath = [[NSBundle mainBundle]pathForResource:@"index" ofType:@"html"];
    NSURL *bundleUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSError *error = nil;
    NSString *html = [[NSString alloc]initWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:&error];
    if (error == nil) {
        [self.webView loadHTMLString:html baseURL:bundleUrl];
    }
    
}
- (IBAction)loadData:(id)sender {
    NSString *htmlPath = [[NSBundle mainBundle]pathForResource:@"index" ofType:@"html"];
    NSURL *bundleUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSError *error = nil;
    NSData *htmlData = [[NSData alloc] initWithContentsOfFile:htmlPath];
    if (error == nil) {
        [self.webView loadData:htmlData MIMEType:@"text/html" characterEncodingName:@"UTF-8" baseURL:bundleUrl];
    }
}
- (IBAction)loadRequest:(id)sender {
}

@end
