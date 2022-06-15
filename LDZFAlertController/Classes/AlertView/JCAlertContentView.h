//
//  JCAlertContentView.h
//  LDZFAlertController
//
//  Created by zhuyuhui on 2022/6/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JCAlertContentView : UIView

@property(nonatomic, assign) UIEdgeInsets contentInset;

@property(nonatomic, copy) void (^dismissViewController)(void);
/// 动态获取高度
/// @param alertViewWidth alertView的宽度
- (CGFloat)calculateContentViewHWithAlertViewWidth:(CGFloat)alertViewWidth;
@end

NS_ASSUME_NONNULL_END
