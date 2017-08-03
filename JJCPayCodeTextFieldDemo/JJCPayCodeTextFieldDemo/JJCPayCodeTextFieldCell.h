//
//  JJCPayCodeTextFieldCell.h
//  JJCPayCodeTextField
//
//  Created by 苜蓿鬼仙 on 2017/8/2.
//  Copyright © 2017年 苜蓿鬼仙. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger, JJCPayCodeTextFieldCellType) {
    JJCPayCodeTextFieldCellTypeEveryBorder = 0,     // 每个完整方格样式
    JJCPayCodeTextFieldCellTypeWholeBorder,         // 外围整体方格样式
    JJCPayCodeTextFieldCellTypeSpaceBorder          // 带间距的方框样式
};


@interface JJCPayCodeTextFieldCell : UICollectionViewCell

@property (nonatomic, strong) NSIndexPath *indePath;    // 需添加在 cellType 之前
@property (nonatomic, assign) NSInteger cellNum;        // 需添加在 cellType 之前
@property (nonatomic, assign) JJCPayCodeTextFieldCellType cellType;

@property (nonatomic, strong) UIColor *cellBorderColor; // 设置边框颜色(默认黑色)

@property (nonatomic, copy)   NSString *titleString;



@end
