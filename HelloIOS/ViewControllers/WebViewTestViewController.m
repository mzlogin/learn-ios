//
//  ViewController.m
//  WebViewSample
//
//  Created by 马壮 on 2024/6/19.
//

#import "WebViewTestViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewTestViewController ()<WKNavigationDelegate, WKScriptMessageHandler>
@property (strong, nonatomic) WKWebView *webView;
@property (assign, nonatomic) BOOL isFullscreen;

@end

@implementation WebViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];

    // 代码创建 WKWebView，以便在初始化时设置 allowsInlineMediaPlayback
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.allowsInlineMediaPlayback = YES;  // 允许内联播放，禁止系统播放器劫持
    config.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeNone; // 可按需调整
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    [self.view addSubview:self.webView];

    // 注册底层消息通道
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"WkBridge"];

    // 注入 JS，将 window.WkBridge.enterFullscreen() / exitFullscreen() 桥接到原生
    NSString *bridgeScript = @
        "window.WkBridge = {"
        "  enterFullscreen: function() {"
        "    window.webkit.messageHandlers.WkBridge.postMessage({ method: 'enterFullscreen' });"
        "  },"
        "  exitFullscreen: function() {"
        "    window.webkit.messageHandlers.WkBridge.postMessage({ method: 'exitFullscreen' });"
        "  }"
        "};";
    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:bridgeScript
                                                      injectionTime:WKUserScriptInjectionTimeAtDocumentStart
                                                   forMainFrameOnly:NO];
    [self.webView.configuration.userContentController addUserScript:userScript];
    
    [self loadUrl];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    // 非全屏时同步 WebView frame（全屏时 WebView 已在 window 层，自行管理 frame）
    if (!self.isFullscreen && self.webView != nil) {
        self.webView.frame = self.view.bounds;
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    // 界面退出时停止播放并销毁 WebView，防止视频在后台继续播放
    [self.webView stopLoading];
    self.webView.navigationDelegate = nil;
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"WkBridge"];
    [self.webView removeFromSuperview];
    self.webView = nil;
}

- (void)dealloc {
    // 防御性清理：若 viewDidDisappear 未执行时兜底
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"WkBridge"];
    [self.webView stopLoading];
    self.webView.navigationDelegate = nil;
}

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if (![message.name isEqualToString:@"WkBridge"]) {
        return;
    }
    NSDictionary *body = message.body;
    if (![body isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSString *method = body[@"method"];
    if ([method isEqualToString:@"enterFullscreen"]) {
        [self handleEnterFullscreen];
    } else if ([method isEqualToString:@"exitFullscreen"]) {
        [self handleExitFullscreen];
    }
}

#pragma mark - Status Bar

- (BOOL)prefersStatusBarHidden {
    return self.isFullscreen;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    // 状态栏立即消失，不使用系统默认的渐变动画
    return UIStatusBarAnimationNone;
}

/// 网页视频进入全屏：将 WebView 移至 window 层覆盖完整屏幕，隐藏状态栏与导航栏
- (void)handleEnterFullscreen {
    self.isFullscreen = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    self.navigationController.navigationBar.hidden = YES;
    // 将 WebView 提升至 window 层，覆盖含 safe area 在内的完整屏幕
    UIWindow *window = self.view.window;
    [window addSubview:self.webView];
    self.webView.frame = window.bounds;
    // 禁止 scrollView 自动根据 safe area 缩进内容，避免横屏时两侧控制条被截断
    self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
}

/// 网页视频退出全屏：将 WebView 移回 self.view，恢复状态栏与导航栏
- (void)handleExitFullscreen {
    self.isFullscreen = NO;
    [self setNeedsStatusBarAppearanceUpdate];
    self.navigationController.navigationBar.hidden = NO;
    // 恢复 scrollView 的 safe area 自动调整
    self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    // 将 WebView 移回 self.view 底层
    [self.view insertSubview:self.webView atIndex:0];
    self.webView.frame = self.view.bounds;
}


- (void)loadUrl {
    NSURL *url = [NSURL URLWithString:@"https://mazhuang.org"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    self.webView.navigationDelegate = self;
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载");
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"内容开始返回");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成");
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败 error : %@", error.description);
}

@end

// 将状态栏控制权转发给当前子 ViewController，使 prefersStatusBarHidden 生效
@implementation UINavigationController (StatusBarForwarding)

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

@end
