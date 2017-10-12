//
//  ViewController.m
//  AKJSWebViewPicture
//
//  Created by 李亚坤 on 2017/10/12.
//  Copyright © 2017年 TFS. All rights reserved.
//

#import "ViewController.h"
#import "AKJSWebView.h"

@interface ViewController ()<UISearchBarDelegate>

//输入框
@property (nonatomic,strong) UISearchBar *searchBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLORS_WHITE;
    self.title = @"Hi,Bo,This is Kuture";
    
    UIImageView *develoP = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"beauty"]];
    develoP.frame = self.view.bounds;
    [self.view addSubview:develoP];
    
    [self setupInputNetState];
}

#pragma mark ***网站搜索框***
- (void)setupInputNetState{
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(30, 80, SCREEN_WIDTH - 60, 50)];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"www.kuture.com.cn";
    _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _searchBar.backgroundColor = COLORS_HEX(0xeeeeee,1);
    _searchBar.layer.cornerRadius = 5;
    _searchBar.layer.masksToBounds = YES;
    _searchBar.alpha = 0.8;
    
    [self.view addSubview:_searchBar];
}

#pragma mark ***开始搜索***
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    MyLog(@"=====SearchText:%@",searchBar.text);
    
    [self pushJSWebView:searchBar.text];
}

#pragma mark ***网页控制器***
- (void)pushJSWebView:(NSString *)url{
    
    url = [url stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    
    AKJSWebView *jsWeb = [AKJSWebView new];
    jsWeb.webURL = [NSString stringWithFormat:@"http://%@",url];
    [self.navigationController pushViewController:jsWeb animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_searchBar resignFirstResponder];
}


























@end
