//
//  ViewController.m
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/5.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import "ViewController.h"
#import "ZDISideMenuViewController.h"
#import "ZDIHomePageViewController.h"

@interface ViewController ()<MenuControllerDelegate>
//菜单控制器
@property (nonatomic, strong) ZDISideMenuViewController *menuViewController;
//用来存放和记录当前呈现的主界面控制器界面
@property (nonatomic, strong) UIViewController *contentController;
//记录容器控制器中，要管理多少个这样的界面
@property (nonatomic, strong) NSArray *viewControllers;
//标记当前菜单栏是打开还是关闭状态
@property (nonatomic, assign)BOOL isMenuOpen;
//记录视图控制器在数组中的位置
@property(assign,nonatomic) NSUInteger controllerIndex;
//判断动画是否在执行
@property(assign,nonatomic,readonly)BOOL isAnimating;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addMenuViewController];
    [self addContentControllers];
}
//封装菜单界面
- (void)addMenuViewController
{
    //  创建菜单控制器
    [self setMenuViewController:[[ZDISideMenuViewController alloc]init]];
    [self addChildViewController:self.menuViewController];
    [self.view addSubview:self.menuViewController.view];
    self.menuViewController.delegate = self;
}

//添加子控制器对象
  - (void)addContentControllers {
    ZDIHomePageViewController *homePageViewController = [[ZDIHomePageViewController alloc] init];
    UINavigationController * homePageNavigation = [[UINavigationController alloc] initWithRootViewController:homePageViewController];
    
    ZDIHomePageViewController *homePageViewController1 = [[ZDIHomePageViewController alloc] init];
    UINavigationController * homePageNavigation1 = [[UINavigationController alloc] initWithRootViewController:homePageViewController1];
    //存放主界面子控制器
    [self setViewControllers:@[homePageNavigation, homePageNavigation1]];
    //默认控制器firstViewController
    [self setContentController:homePageNavigation];
}

//主界面视图添加和移除
- (void)setContentController:(UIViewController *)contentController {
    if (_contentController == contentController) {
        return;
    }
    //内容控制器起始坐标不一致
    if (_contentController) {
        contentController.view.transform = _contentController.view.transform;
    }
    
    [_contentController willMoveToParentViewController:nil];
    [_contentController.view removeFromSuperview];//移除旧的视图
    [_contentController removeFromParentViewController];//解除父子控制器关系
    
    //增加添加进来的视图
    _contentController = contentController;
    [self addChildViewController:contentController];
    [self.view addSubview:contentController.view];
}

- (void)openCloseMenu {
    if (_isAnimating) {
        return;
    }
    [UIView animateWithDuration:0.15 animations:^{
        self->_isAnimating = YES;
        if (!self->_isMenuOpen) {
            self.contentController.view.transform = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width/2, 0);
            self.menuViewController.view.transform = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width/2, 0);
        }else {
            self.contentController.view.transform = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width/2, 0);
            self.menuViewController.view.transform = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width/2, 0);
        }
    }completion:^(BOOL finished) {
        self->_isMenuOpen = !self->_isMenuOpen;
        [self setContentController:self.viewControllers[self.controllerIndex]];
        if (!self->_isMenuOpen) {
            [UIView animateWithDuration:0.2 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.contentController.view.transform = CGAffineTransformIdentity;
                self.menuViewController.view.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                self->_isAnimating = NO;
            }];
        }else {
            self->_isAnimating = NO;
        }
    }];
    
}
//代理方法的实现
- (void)menuController: (ZDISideMenuViewController *)controller didSelectItemAtIndex: (NSInteger)Index;
{
    [self setControllerIndex:Index];
    [self openCloseMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
