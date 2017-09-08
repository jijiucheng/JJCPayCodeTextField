//
//  JJCPayCodeTextField.h
//  JJCPayCodeTextField
//
//  Created by 苜蓿鬼仙 on 2017/8/2.
//  Copyright © 2017年 苜蓿鬼仙. All rights reserved.
//

#import <UIKit/UIKit.h>




/*
 
 JJCPayCodeTextField
 2017.09.08
 
 当前版本：v0.2.0
 
 */




/*
 
 如果遇到无法显示 JJCPayCodeTextField，请检查 - (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath; 是否执行；
 如果不执行：请在 ViewController 里设置 self.automaticallyAdjustsScrollViewInsets = NO;【原因暂时不明白】
 
 
 【官方解释】：
     A Boolean value that indicates whether the view controller should automatically adjust its scroll view insets.
     The default value of this property is YES, which lets container view controllers know that they should adjust the scroll view insets of this view controller’s view to account for screen areas consumed by a status bar, search bar, navigation bar, toolbar, or tab bar. Set this property to NO if your view controller implementation manages its own scroll view inset adjustments.
     
     大致意思是：如果设置YES的话，根据所在屏幕区域的status bar, search bar, navigation bar, toolbar, or tab bar.来调整scroll view的insets。
     设置为NO的话，自己修改布局，不要ViewController来控制。
 
 */



typedef NS_ENUM(NSInteger, JJCPayCodeTextFieldType) {
    JJCPayCodeTextFieldTypeEveryBorder = 0,     // 每个完整方格样式
    JJCPayCodeTextFieldTypeWholeBorder,         // 外围整体方格样式
    JJCPayCodeTextFieldTypeSpaceBorder          // 带间距的方框样式
};





/** 实时获取当前已输入的支付密码 **/
// 说明：currentInputString 只表示当前输入到密码框中的字符，如果不符合规则或删除字符的情况， currentInputString = @"";
typedef void(^JJCPayCodeTextFieldCurrentBlock)(NSString *currentPayCodeString, NSString *currentInputString);
/** 输入完成后回调 **/
typedef void(^JJCPayCodeTextFieldFinishedBlock)(NSString *payCodeString);






@interface JJCPayCodeTextField : UIView

@property (nonatomic, assign) BOOL isChangeTextFieldNum;    // 是否动态变更输入长度（需设置在 textFieldNum 前有效，默认NO）
@property (nonatomic, assign) NSInteger textFieldNum;       // 输入支付码长度
@property (nonatomic, strong) UIColor  *borderColor;        // 设置边框颜色

@property (nonatomic, assign) CGFloat   borderSpace;        // 边框间距（只在 JJCPayCodeTextFieldTypeSpaceBorder 下有效）

@property (nonatomic, copy)   NSString *payCodeString;      // 真实支付码(未输入完全时，则是当前已输入的支付密码)
@property (nonatomic, assign) BOOL      isShowTrueCode;     // 是否显示 明文（默认NO）
@property (nonatomic, copy)   NSString *ciphertext;         // 密文字符样式(仅限一个字符，且需要在 addSubViews 前设置)


@property (nonatomic, copy) JJCPayCodeTextFieldCurrentBlock currentBlock;
@property (nonatomic, copy) JJCPayCodeTextFieldFinishedBlock finishedBlock;





- (instancetype)initWithFrame:(CGRect)frame TextFieldType:(JJCPayCodeTextFieldType)textFieldType;
/** 清除已输入的支付密码 **/
- (void)clearKeyCode;



@end
