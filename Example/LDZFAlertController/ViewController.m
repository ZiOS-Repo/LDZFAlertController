//
//  ViewController.m
//  JCAlertController
//
//  Created by HJaycee on 2017/4/6.
//  Copyright © 2017年 HJaycee. All rights reserved.
//

#import "ViewController.h"
#import <LDZFAlertController/JCAlertController.h>
#import "NSObject+BlockSEL.h" // just used in demo
#import "UIViewController+JCPresentQueue.h"
#import "NormalVCForPresentation.h"

#define RGB(r,g,b,a)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define identifier @"identifier"
#define longTitle @"I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title "
#define longMessage @"I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content "

@interface ViewController ()

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"JCAlertController";
    
    self.dataSource = @[
                        @{@"Normal Style":@[@"only title",@"only content",@"title and content both",@"title words overflow",@"content words overflow"]},
                        @{@"Custom Style":@[@"change JCAlertTypeCustom"]},
                        @{@"Present Queue":@[@"JCAlertController LIFO",
                                             @"JCAlertController FIFO",
                                             @"UIAlertController LIFO",
                                             @"UIAlertController FIFO",
                                             @"UIAlertController default"]},
                        @{@"Custom ContentView":@[@"contentView",@"contentView and keyboard handle",@"contentView and attributed string"]},
                        @{@"FIFO View Hierarchy test":@[@"pop/dismiss self when alert dismissed"]},
                        @{@"LIFO View Hierarchy test":@[@"pop/dismiss self when alert dismissed", @"present another controller when first alert dismissed"]}];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    [self.tableView reloadData];
    
    // default is UIWindowLevelNormal
    [JCPresentController setOverlayWindowLevel:UIWindowLevelAlert + 1];
}

#pragma mark - TableView delegate/datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dict = self.dataSource[section];
    NSArray *array = [dict.allValues firstObject];
    return array.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSDictionary *dict = self.dataSource[section];
    return dict.allKeys.firstObject;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    NSDictionary *dict = self.dataSource[indexPath.section];
    NSArray *array = [dict.allValues firstObject];
    cell.textLabel.text = array[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self onlyTitle];
        } else if (indexPath.row == 1) {
            [self onlyContent];
        } else if (indexPath.row == 2) {
            [self titleAndContentBoth];
        } else if (indexPath.row == 3) {
            [self titleWordsOverflow];
        } else if (indexPath.row == 4) {
            [self contentWordsOverflow];
        }
    }
    
    if (indexPath.section == 1) {
        [self customStyle];
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            [self JCAlertControllerLIFO];
        } else if (indexPath.row == 1) {
            [self JCAlertControllerFIFO];
        } else if (indexPath.row == 2){
            [self UIAlertControllerLIFO];
        } else if (indexPath.row == 3) {
            [self UIAlertControllerFIFO];
        } else {
            [self UIAlertControllerDefault];
        }
    }
    
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            [self customView];
        } else if (indexPath.row == 1) {
            [self customViewAndHandleKeyboard];
        } else {
            [self customViewAndAttributedString];
        }
    }
    
    if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            [self popOrDismissSelfWhenAlertDismissedFIFO];
        }
    }
    
    if (indexPath.section == 5) {
        if (indexPath.row == 0) {
            [self popOrDismissSelfWhenAlertDismissedLIFO];
        } else if (indexPath.row == 1) {
            [self presentOtherVCWhenLastAlertDismissed];
        }
    }
}


#pragma mark - Methods

- (void)onlyTitle {
    JCAlertController *alert = [JCAlertController alertWithTitle:@"I am title" message:nil];
    [alert addButtonWithTitle:@"Cancel" type:JCButtonTypeCancel clicked:^{
        NSLog(@"Cancel button clicked");
    }];
    [alert addButtonWithTitle:@"OK" type:JCButtonTypeNormal clicked:^{
        NSLog(@"OK button clicked");
    }];
    [JCPresentController presentViewControllerLIFO:alert presentCompletion:^{
        NSLog(@"present completion");
    } dismissCompletion:^{
        NSLog(@"dismiss completion");
    }];
}

- (void)onlyContent {
    JCAlertController *alert = [JCAlertController alertWithTitle:nil message:@"I am content"];
    [alert addButtonWithTitle:@"OK" type:JCButtonTypeNormal clicked:nil];
    [JCPresentController presentViewControllerLIFO:alert presentCompletion:nil dismissCompletion:nil];
}

- (void)titleAndContentBoth {
    JCAlertController *alert = [JCAlertController alertWithTitle:@"JCAlertController" message:@"Support custom Style.\nSupport custom View.\nSupport presented with LIFO."];
    [alert addButtonWithTitle:@"OK" type:JCButtonTypeNormal clicked:nil];
    [alert addButtonWithTitle:@"OK" type:JCButtonTypeNormal clicked:nil];
    [JCPresentController presentViewControllerLIFO:alert presentCompletion:nil dismissCompletion:nil];
}

- (void)titleWordsOverflow {
    JCAlertController *alert = [JCAlertController alertWithTitle:longTitle message:nil];
    [alert addButtonWithTitle:@"OK" type:JCButtonTypeNormal clicked:nil];
    [alert addCustomButtonWithTitle:@"设置" itemConfig:^(JCAlertButtonItem *item) {
        item.font = [UIFont systemFontOfSize:13];
        item.textColor = [UIColor redColor];
        item.highlightTextColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    } clicked:nil];
    [alert addCustomButtonWithTitle:@"报错" itemConfig:^(JCAlertButtonItem *item) {
        item.font = [UIFont systemFontOfSize:13];
        item.textColor = [UIColor redColor];
        item.highlightTextColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    } clicked:nil];
    [JCPresentController presentViewControllerLIFO:alert presentCompletion:nil dismissCompletion:nil];
}

- (void)contentWordsOverflow {
    JCAlertController *alert = [JCAlertController alertWithTitle:@"I am title" message:longMessage];
    [alert addButtonWithTitle:@"OK" type:JCButtonTypeNormal clicked:nil];
    [alert addButtonWithTitle:@"Normal" type:JCButtonTypeNormal clicked:nil];
    [alert addButtonWithTitle:@"Cancel" type:JCButtonTypeCancel clicked:nil];
    [alert addButtonWithTitle:@"Warning" type:JCButtonTypeWarning clicked:nil];
    [JCPresentController presentViewControllerLIFO:alert presentCompletion:nil dismissCompletion:nil];
}

- (void)customStyle {
    // See all properties in JCAlertStyle
    JCAlertStyle *style = [[JCAlertStyle alloc] init];
    
    style.background.blur = YES;
    style.background.alpha = 0.65;
    style.background.canDismiss = YES;
    
    style.alertView.cornerRadius = 4;
    
    style.title.backgroundColor = [UIColor colorWithRed:251/255.0 green:2/255.0 blue:19/255.0 alpha:1.0];
    style.title.textColor = [UIColor whiteColor];
    
    style.content.backgroundColor = [UIColor colorWithRed:251/255.0 green:2/255.0 blue:19/255.0 alpha:1.0];
    style.content.textColor = [UIColor whiteColor];
    style.content.insets = UIEdgeInsetsMake(20, 20, 40, 20);
    
    style.buttonNormal.textColor = [UIColor colorWithRed:248/255.0 green:59/255.0 blue:50/255.0 alpha:1.0];
    style.buttonNormal.highlightTextColor = [style.buttonNormal.textColor hightlightedColor];
    style.buttonNormal.backgroundColor = [UIColor whiteColor];
    style.buttonNormal.highlightBackgroundColor = [UIColor whiteColor];
    
    JCAlertController *alert = [JCAlertController alertWithTitle:@"I am title" message:@"I am content"];
    [alert addButtonWithTitle:@"OK" type:JCButtonTypeNormal clicked:nil];
    [JCPresentController presentViewControllerLIFO:alert presentCompletion:nil dismissCompletion:nil];
}

- (void)JCAlertControllerLIFO {
    // LIFO: alert3 >> alert2 >> alert1
    for (int i = 1; i<4; i++) {
        JCAlertController *alert = [JCAlertController alertWithTitle:[NSString stringWithFormat:@"alert%i", i] message:nil];
        [alert addButtonWithTitle:@"OK" type:JCButtonTypeNormal clicked:nil];
        [JCPresentController presentViewControllerLIFO:alert presentCompletion:nil dismissCompletion:nil];
    }
}

- (void)JCAlertControllerFIFO {
    // FIFO alert1 >> alert2 >> alert3
    for (int i = 1; i<4; i++) {
        JCAlertController *alert = [JCAlertController alertWithTitle:[NSString stringWithFormat:@"alert%i", i] message:nil];
        [alert addButtonWithTitle:@"OK" type:JCButtonTypeNormal clicked:nil];
        [JCPresentController presentViewControllerFIFO:alert  presentCompletion:nil dismissCompletion:nil];
    }
}

- (void)UIAlertControllerLIFO {
    // LIFO: alert3 >> alert2 >> alert1
    for (int i = 1; i<4; i++) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"alert%i", i] message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:alertAction];
        [JCPresentController presentViewControllerLIFO:alert presentCompletion:nil dismissCompletion:nil];
    }
}

- (void)UIAlertControllerFIFO {
    // FIFO: alert1 >> alert2 >> alert3
    for (int i = 1; i<4; i++) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"alert%i", i] message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:alertAction];
        [JCPresentController presentViewControllerFIFO:alert  presentCompletion:nil dismissCompletion:nil];
    }
}

- (void)UIAlertControllerDefault {
    // Only show one alert and log error msg.
    for (int i = 1; i<4; i++) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"fdsfdf辅导费发送到发生大幅度的方式的alert%i", i] message:@"方法和撒厚道哈佛的回复都会发偶是否" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:alertAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


- (void)popOrDismissSelfWhenAlertDismissedFIFO {
    JCAlertController *alert = [JCAlertController alertWithTitle:@"pop/dismiss self in completion" message:nil];
    [alert addButtonWithTitle:@"OK" type:JCButtonTypeNormal clicked:nil];
    __weak typeof(self) weakSelf = self;
    [JCPresentController presentViewControllerFIFO:alert  presentCompletion:nil dismissCompletion:^(void){
        if (weakSelf.navigationController) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } else {
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    for (int i = 1; i<4; i++) {
        JCAlertController *alert = [JCAlertController alertWithTitle:[NSString stringWithFormat:@"alert%i", i] message:nil];
        [alert addButtonWithTitle:@"OK" type:JCButtonTypeNormal clicked:nil];
        [JCPresentController presentViewControllerFIFO:alert  presentCompletion:nil dismissCompletion:nil];
    }
}

- (void)popOrDismissSelfWhenAlertDismissedLIFO {
    for (int i = 1; i<4; i++) {
        JCAlertController *alert = [JCAlertController alertWithTitle:[NSString stringWithFormat:@"alert%i", i] message:nil];
        [alert addButtonWithTitle:@"OK" type:JCButtonTypeNormal clicked:nil];
        [JCPresentController presentViewControllerLIFO:alert presentCompletion:nil dismissCompletion:nil];
    }
    JCAlertController *alert = [JCAlertController alertWithTitle:@"pop/dismiss self in completion" message:nil];
    [alert addButtonWithTitle:@"OK" type:JCButtonTypeNormal clicked:nil];
    __weak typeof(self) weakSelf = self;
    [JCPresentController presentViewControllerLIFO:alert presentCompletion:nil dismissCompletion:^(void){
        if (weakSelf.presentingViewController) {
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        } else {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)presentOtherVCWhenLastAlertDismissed {
    for (int i = 1; i<4; i++) {
        JCAlertController *alert = [JCAlertController alertWithTitle:[NSString stringWithFormat:@"alert%i", i] message:nil];
        [alert addButtonWithTitle:@"OK" type:JCButtonTypeNormal clicked:nil];
        [JCPresentController presentViewControllerLIFO:alert presentCompletion:nil dismissCompletion:nil];
    }
    JCAlertController *alert = [JCAlertController alertWithTitle:@"present a nav in completion" message:nil];
    [alert addButtonWithTitle:@"OK" type:JCButtonTypeNormal clicked:nil];
    __weak typeof(self) weakSelf = self;
    [JCPresentController presentViewControllerLIFO:alert presentCompletion:nil dismissCompletion:^(void){
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[NormalVCForPresentation new]];
        [weakSelf presentViewController:nav animated:YES completion:nil];
    }];
}

#pragma mark -

- (void)customView {
    NSArray *specials = @[@"特空",@"用户授权协议"];
    NSString *full = [NSString stringWithFormat:@"app即将授权%@获取您的手机号。点击“同意授权”即表示您知晓并同意%@",specials.firstObject,specials.lastObject];
        
    //属性文本生成器
    TYTextContainer *textContainer = [[TYTextContainer alloc] init];
    textContainer.text = full;
    textContainer.textColor = [UIColor blackColor];
    textContainer.font = [UIFont systemFontOfSize:15];
//    textContainer.linesSpacing = 0.5;// 文本行间隙
//    textContainer.characterSpacing = 15;// 文字间隙
    
    //文字样式
    NSRange firstRange = [full rangeOfString:specials.lastObject];
    TYTextStorage *textStorage = [[TYTextStorage alloc]init];
    textStorage.range = firstRange;
    textStorage.font = [UIFont boldSystemFontOfSize:15];
    textStorage.textColor = [UIColor blueColor];
    [textContainer addTextStorage:textStorage];
    
    //下划线文字
    TYLinkTextStorage *linkTextStorage = [[TYLinkTextStorage alloc]init];
    linkTextStorage.range = firstRange;
    linkTextStorage.linkData = @"登录芬兰航空";
    linkTextStorage.underLineStyle = kCTUnderlineStyleNone; //取消下划线
    [textContainer addTextStorage:linkTextStorage];
    
    
    CGFloat width = [[JCAlertStyle alloc] init].alertView.width;
    JCAlertAttributedLabel *attributedLabel = [[JCAlertAttributedLabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    attributedLabel.userInteractionEnabled = YES;
    attributedLabel.lable.backgroundColor = [UIColor clearColor];
    attributedLabel.lable.textContainer = textContainer;
    attributedLabel.lable.textAlignment = kCTTextAlignmentCenter;//设置居中

    [attributedLabel setTextStorageClicked:^(TYAttributedLabel * _Nonnull attributedLabel, id<TYTextStorageProtocol>  _Nonnull textStorage, CGPoint point) {
        if ([textStorage isKindOfClass:[TYLinkTextStorage class]]){
            TYLinkTextStorage *storage = (TYLinkTextStorage *)textStorage;
            NSString *msg = [NSString stringWithFormat:@"%@",storage.linkData];
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"点击提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
    }];

    // pass the contentView
    JCAlertController *alert = [JCAlertController alertWithTitle:@"提示" contentView:attributedLabel];
    [alert addButtonWithTitle:@"下次再说" type:JCButtonTypeNormal clicked:nil];
    [alert addCustomButtonWithTitle:@"同意" itemConfig:^(JCAlertButtonItem *item) {
        item.textColor = [UIColor blueColor];
        item.highlightTextColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    } clicked:nil];

    [JCPresentController presentViewControllerLIFO:alert presentCompletion:nil dismissCompletion:nil];
}

- (void)customViewAndHandleKeyboard {
    // without title
    
    CGFloat width = [[JCAlertStyle alloc] init].alertView.width;

    // setup contentView with a textField inside
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, width - 20, 26)];
    textField.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    textField.layer.cornerRadius = 2;
    textField.clipsToBounds = YES;
    textField.center = CGPointMake(width / 2, 30);
    textField.secureTextEntry = YES;
    textField.textAlignment = NSTextAlignmentCenter;
    [textField becomeFirstResponder];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 60)];
    contentView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:textField];
    
    // pass the contentView
    JCAlertController *alert = [JCAlertController alertWithTitle:@"Enter password please" contentView:contentView];
    [alert addButtonWithTitle:@"Confirm" type:JCButtonTypeNormal clicked:^{
        NSLog(@"You inputed：%@", textField.text);
        [textField resignFirstResponder];
    }];
    [JCPresentController presentViewControllerLIFO:alert presentCompletion:^{
        [textField becomeFirstResponder];
    } dismissCompletion:nil];
    
    // avoid retain circle
    __weak typeof(JCAlertController *) weakalert = alert;
    
    // callback after keyboard shows
    [alert monitorKeyboardShowed:^(CGFloat alertHeight, CGFloat keyboardHeight) {
        [weakalert moveAlertViewToCenterY:alertHeight / 2 + 120 animated:YES];
    }];
    // callback after keyboard hides
    [alert monitorKeyboardHided:^{
        [weakalert moveAlertViewToScreenCenterAnimated:YES];
    }];
}

- (void)customViewAndAttributedString {
    // without title
    CGFloat width = [[JCAlertStyle alloc] init].alertView.width;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 100)];
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"Hello"];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0, 2)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2, 3)];
    label.attributedText = AttributedStr;
    
    JCAlertController *alert = [JCAlertController alertWithTitle:nil contentView:label];
    [alert addButtonWithTitle:@"OK" type:JCButtonTypeNormal clicked:nil];
    [JCPresentController presentViewControllerLIFO:alert presentCompletion:nil dismissCompletion:nil];
}

@end
