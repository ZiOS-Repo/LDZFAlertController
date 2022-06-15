//
//  JCAlertAttributedLabel.h
//  LDZFAlertController
//
//  Created by zhuyuhui on 2022/6/15.
//

#import "JCAlertContentView.h"
#import <TYAttributedLabel/TYAttributedLabel.h>
NS_ASSUME_NONNULL_BEGIN

@interface JCAlertAttributedLabel : JCAlertContentView
@property(nonatomic, strong) TYAttributedLabel *lable;
// 点击代理
@property(nonatomic, copy) void (^textStorageClicked)(id<TYTextStorageProtocol>textStorage, CGPoint point);
// 长按代理 有多个状态 begin, changes, end 都会调用,所以需要判断状态
@property(nonatomic, copy) void (^textStorageLongPressed)(id<TYTextStorageProtocol>textStorage, UIGestureRecognizerState state, CGPoint point);
// 长按非Container区域代理 有多个状态 begin, changes, end 都会调用,所以需要判断状态
@property(nonatomic, copy) void (^lableLongPressOnState)(UIGestureRecognizerState state, CGPoint point);
@end
NS_ASSUME_NONNULL_END

