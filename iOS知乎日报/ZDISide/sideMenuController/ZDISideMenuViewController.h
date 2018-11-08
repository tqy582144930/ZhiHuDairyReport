//
//  ZDISideMenuViewController.h
//  iOS知乎日报
//
//  Created by 涂强尧 on 2018/11/5.
//  Copyright © 2018 涂强尧. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDISideMenuView.h"

@class ZDISideMenuViewController;
@protocol MenuControllerDelegate <NSObject>
- (void) menuController:(ZDISideMenuViewController*) controller didSelectItemAtIndex:(NSInteger)index;
@end

@interface ZDISideMenuViewController : UIViewController
@property (nonatomic, weak)id <MenuControllerDelegate> delegate;
@property (nonatomic, strong) ZDISideMenuView *sideMenuView;
@end
