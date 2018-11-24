//
//  ZDINextViewController.h
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/18.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Webkit/Webkit.h>
#import "ZDINextView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDINextViewController : UIViewController<WKNavigationDelegate, WKUIDelegate>
@property (nonatomic, strong) NSString *idNumber;
@property (strong, nonatomic) WKWebView *webView;
@property (nonatomic, strong) NSMutableArray *dataMutableArray;
@property (nonatomic, strong) ZDINextView *nextView;

@end

NS_ASSUME_NONNULL_END
