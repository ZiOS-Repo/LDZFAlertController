//
//  JCAlertAttributedLabel.m
//  LDZFAlertController
//
//  Created by zhuyuhui on 2022/6/15.
//

#import "JCAlertAttributedLabel.h"
#import <Masonry/Masonry.h>

@interface JCAlertAttributedLabel()<TYAttributedLabelDelegate>
@end

@implementation JCAlertAttributedLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefaultSubViews];
        [self setupConstraints];
    }
    return self;
}

- (void)setupDefaultSubViews {
    [self addSubview:self.lable];
}

- (void)setupConstraints {
    [self.lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(self.contentInset);
    }];
}

#pragma mark - getter & setter
- (TYAttributedLabel *)lable {
    if (!_lable) {
        _lable = [[TYAttributedLabel alloc] init];
        _lable.delegate = self;
    }
    return _lable;
}

#pragma mark - TYAttributedLabelDelegate
- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageClicked:(id<TYTextStorageProtocol>)TextRun atPoint:(CGPoint)point
{
    NSLog(@"textStorageClickedAtPoint");
    if (self.dismissViewController) {
        self.dismissViewController();
    }
    if (self.textStorageClicked) {
        self.textStorageClicked(attributedLabel, TextRun, point);
    }
}

- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageLongPressed:(id<TYTextStorageProtocol>)textStorage onState:(UIGestureRecognizerState)state atPoint:(CGPoint)point
{
    NSLog(@"textStorageLongPressed");
    if (self.dismissViewController) {
        self.dismissViewController();
    }
    if (self.textStorageLongPressed) {
        self.textStorageLongPressed(attributedLabel, textStorage, state, point);
    }
}

- (void)attributedLabel:(TYAttributedLabel *)attributedLabel lableLongPressOnState:(UIGestureRecognizerState)state atPoint:(CGPoint)point
{
    NSLog(@"lableLongPressOnState");
    if (self.dismissViewController) {
        self.dismissViewController();
    }
    if (self.lableLongPressOnState) {
        self.lableLongPressOnState(attributedLabel, state, point);
    }
}



#pragma mark - JCAlertContentViewProtocol
- (CGFloat)calculateContentViewHWithAlertViewWidth:(CGFloat)alertViewWidth {
    CGFloat fixedWidth = alertViewWidth - self.contentInset.left - self.contentInset.right;
    self.lable.frame = CGRectMake(0, 0, fixedWidth, 0);
    [self.lable sizeToFit];
    CGFloat h = self.lable.frame.size.height;
    return h + self.contentInset.top + self.contentInset.bottom;
}
@end
