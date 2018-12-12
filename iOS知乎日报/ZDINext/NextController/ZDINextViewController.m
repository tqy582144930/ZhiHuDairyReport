//
//  ZDINextViewController.m
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/18.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import "ZDINextViewController.h"
#import "ZDINextManger.h"
#import "ZDINextView.h"
#import <Masonry.h>
#import "ZDICommentsViewController.h"
#import "ZDIShareView.h"
#import "ZDITopStoriseJSONModel.h"
#import "ZDIHomePageManager.h"

@interface ZDINextViewController ()
@property(nonatomic, assign) BOOL isLoading;
@end

@implementation ZDINextViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _webView = [[WKWebView alloc] init];
    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50));
    }];
    NSString *urlString = [NSString stringWithFormat:@"https://daily.zhihu.com/story/%@", _idNumber];
    NSURL *url = [NSURL URLWithString:urlString];
    _webView.scrollView.delegate = self;
    [self->_webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    _nextView = [[ZDINextView alloc] init];
    [self.view addSubview:_nextView];
    [_nextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width, 50.0));
    }];
    [_nextView nextViewInit];
    
    [_nextView.backButton addTarget:self action:@selector(clickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [_nextView.xiangxiaButton addTarget:self action:@selector(clickXiangxiaButton:) forControlEvents:UIControlEventTouchUpInside];
    [_nextView.dianzanButton addTarget:self action:@selector(clickDianzanButton:) forControlEvents:UIControlEventTouchUpInside];
    [_nextView.fenxiangButton addTarget:self action:@selector(clickFenxiangButton:) forControlEvents:UIControlEventTouchUpInside];
    [_nextView.pinglunButton addTarget:self action:@selector(clickPinglunButton:) forControlEvents:UIControlEventTouchUpInside];
  
    _shareView = [[ZDIShareView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height/2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/2)];
    [_shareView InitShareView];
}

- (void)clickBackButton:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickXiangxiaButton:(UIButton *)button {
    _row++;
    NSArray *array = [NSMutableArray arrayWithArray:_allIdnumberMutableArray[_section]];
    if (_row > [array count] - 1) {
        _row = 0;
        _section++;
    }
    NSString *urlString = [NSString stringWithFormat:@"https://daily.zhihu.com/story/%@", _allIdnumberMutableArray[_section][_row]];
    NSURL *url = [NSURL URLWithString:urlString];
    [self->_webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)clickDianzanButton:(UIButton *)button {
    
}

- (void)clickFenxiangButton:(UIButton *)button {
    [_shareView.collectButton addTarget:self action:@selector(collectButton:) forControlEvents:UIControlEventTouchUpInside];
    [_shareView.cancelButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [UIView animateWithDuration:1.0 animations:^{
        self->_shareView.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
    [self.view addSubview:_shareView];
}

- (void)collectButton:(UIButton *)button {
    button.selected = !button.selected;
    NSString *idString = [[_modelArray[_section] valueForKey:@"stories"][_row] valueForKey:@"id"];

    ZDITotallJSONModel *model = _modelArray[_section];
    NSString *titleString = [model.stories[_row] title];
    
    NSArray *array = [model.stories[_row] images];
    NSURL *urlSting = array[0];
    
    NSMutableArray *cellCollection = [NSMutableArray new];
    [cellCollection addObject:idString];
    [cellCollection addObject:titleString];
    [cellCollection addObject:urlSting];
   
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sendCollection" object:cellCollection];
    
}

- (void)backButton:(UIButton *) button {
    [UIView animateWithDuration:1.0 animations:^{
        self->_shareView.transform = CGAffineTransformMakeTranslation(0, [UIScreen mainScreen].bounds.size.height/2);
    }];
}

- (void)clickPinglunButton:(UIButton *)button {
    ZDICommentsViewController *nextView = [[ZDICommentsViewController alloc] init];
    NSString *idNumberString = [[NSString alloc] init];
    idNumberString = _allIdnumberMutableArray[_section][_row];
    nextView.idNumber = idNumberString;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:nextView];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView.contentOffset.y < 0) {
//        if (self.isLoading) {
//            return;
//        } else {
//            [self updateLastWkWebView];
//        }
//    }
    if (scrollView.contentOffset.y + [UIScreen mainScreen].bounds.size.height - 50 > scrollView.contentSize.height && scrollView.contentSize.height != 0 ) {
        if (self.isLoading) {
            return;
        } else {
            [self updateWkWebView];
        }
    }
}

- (void)updateWkWebView {
    self.isLoading = YES;
    _row++;
    NSArray *array = [NSMutableArray arrayWithArray:_allIdnumberMutableArray[_section]];
    if (_row > [array count] - 1) {
        _row = 0;
        _section++;
    }
    NSString *urlString = [NSString stringWithFormat:@"https://daily.zhihu.com/story/%@", _allIdnumberMutableArray[_section][_row]];
    NSURL *url = [NSURL URLWithString:urlString];
    [self->_webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self->_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)updateLastWkWebView {
    self.isLoading = YES;
    _row--;
    if (_row == 0 && _section == 0) {
        
    }
    if (_row < 0) {
        _section--;
        NSArray *array = [NSMutableArray arrayWithArray:_allIdnumberMutableArray[_section]];
        _row = array.count-1;
    }
    NSLog(@"section = %lu, row = %lu", _section, _row);
    NSString *urlString = [NSString stringWithFormat:@"https://daily.zhihu.com/story/%@", _allIdnumberMutableArray[_section][_row]];
    NSURL *url = [NSURL URLWithString:urlString];
    [self->_webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self->_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (self.webView.estimatedProgress == 1) {
        self.isLoading = NO;
    }
}

@end
