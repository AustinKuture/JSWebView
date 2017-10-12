//
//  AKJSWebView.m
//  AKJSWebViewPicture
//
//  Created by 李亚坤 on 2017/10/12.
//  Copyright © 2017年 TFS. All rights reserved.
//

#import "AKJSWebView.h"
#import "AKScanImg.h"


@interface AKJSWebView () <UIWebViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,copy) NSString *stringOne;

@property (nonatomic,copy) NSString *midleUrl;

//加载指示
@property (nonatomic,strong) UIActivityIndicatorView *activityWebView;

@end
@implementation AKJSWebView{
    
    UIWebView *_webV;
    NSMutableArray *akUrlArray;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];

    self.view.backgroundColor = COLORS_WHITE;

    [self newWebViewDisplay];
}

#pragma mark ***新增WebView展示方法***
- (void)newWebViewDisplay{

    if (![_webURL isEqualToString:@""] & (_webURL != nil)){
        
        [self setWebUrl:_webURL];
        [self setupRightBtn];
    }else{
        
        [self developINg];
    }
    
    MyLog(@"========WebPublic:%@",_webURL);
}

- (void)setWebUrl:(NSString *)url{
    
    _midleUrl = url;
    
    _webV = [[UIWebView alloc]initWithFrame:CGRectMake(0, -52, SCREEN_WIDTH, SCREEN_HEIGHT + 52)];
    _webV.delegate = self;
    _webV.scrollView.bounces = NO;
    _webV.backgroundColor = COLORS_WHITE;
        
    [_webV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
//    网页加载指示
    _activityWebView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityWebView.frame = CGRectMake(SCREEN_WIDTH / 2 - 43/2, 100, 43, 43);

    [_activityWebView startAnimating];
    _activityWebView.hidden = NO;
    
    [self.view addSubview:_webV];
    [self.view addSubview:_activityWebView];
}

#pragma mark ***加载结束,提取网页中的图片url***
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //这里是js，主要目的实现对url的获取
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var objs = document.getElementsByTagName(\"img\");\
    var imgScr = '';\
    for(var i=0;i<objs.length;i++){\
    imgScr = imgScr + objs[i].src + '+';\
    };\
    return imgScr;\
    };";
    
    //注入js方法
    [webView stringByEvaluatingJavaScriptFromString:jsGetImages];
    NSString *urlResurlt = [webView stringByEvaluatingJavaScriptFromString:@"getImages()"];
    akUrlArray = [NSMutableArray arrayWithArray:[urlResurlt componentsSeparatedByString:@"+"]];
    if (akUrlArray.count >= 2) {
        [akUrlArray removeLastObject];
    }
    //urlResurlt 就是获取到得所有图片的url的拼接；mUrlArray就是所有Url的数组
    
    //添加图片可点击js
    [_webV stringByEvaluatingJavaScriptFromString:@"function registerImageClickAction(){\
     var imgs=document.getElementsByTagName('img');\
     var length=imgs.length;\
     for(var i=0;i<length;i++){\
     img=imgs[i];\
     img.onclick=function(){\
     window.location.href='image-preview:'+this.src}\
     }\
     }"];
    [_webV stringByEvaluatingJavaScriptFromString:@"registerImageClickAction();"];
    
    //网页标题
    self.title = [_webV stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    //停止加载指示
    [_activityWebView stopAnimating];
    _activityWebView.hidden = YES;
    MyLog(@"===页面中出现的所有URL:%@",akUrlArray);
}

#pragma mark ***捕获到图片的点击事件和被点击图片的url***
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    //预览图片
    if ([request.URL.scheme isEqualToString:@"image-preview"]) {
        NSString* path = [request.URL.absoluteString substringFromIndex:[@"image-preview:" length]];
        
        //被点击图片的url
        path = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        NSLog(@"======URL:%@",path);
        
        //全屏显示图片
        UIImageView *scanImg = [UIImageView new];
        
        scanImg.image = [UIImage imageWithData:[NSData
                                                dataWithContentsOfURL:[NSURL URLWithString:path]]];
        
        [AKScanImg scanBigImageWithImageView:scanImg];
        
        return NO;
    }
    return YES;
}

#pragma mark ***错误页***
- (void)developINg{
    
    UIImageView *develoP = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ErrorStatus"]];
    develoP.frame = self.view.bounds;
    [self.view addSubview:develoP];
    self.title = @"网络异常";
}

#pragma mark ***网页分享***
- (void)setupRightBtn{
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"webviewShare"] style:UIBarButtonItemStyleDone target:self action:@selector(setupSystemShare)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark ***本地系统分享***
- (void)setupSystemShare{

    NSURL *urlU = [NSURL URLWithString:_webURL];
    
    UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:@[urlU] applicationActivities:nil];
    activity.excludedActivityTypes = @[UIActivityTypeAirDrop,UIActivityTypeCopyToPasteboard,UIActivityTypeAddToReadingList];
    
    activity.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
        
        
        if (completed){
            
            NSLog(@"进程: %@ 已经完成", activityType);
        }else{
            
            NSLog(@"进程: %@ 没有完成", activityType);
        }
        
    };
    
    
    if ([[UIDevice currentDevice].model isEqualToString:@"iPhone"]) {
        
        [self presentViewController:activity animated:YES completion:nil];
    }
    else if([[UIDevice currentDevice].model isEqualToString:@"iPad"]){
        
        UIPopoverPresentationController *popover = activity.popoverPresentationController;
        if (popover) {
            popover.sourceView = self.view;
            popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
        }
        [self presentViewController:activity animated:YES completion:nil];
    }
    else{
        //do nothing
    }
}



@end
