//
//  JJCPayCodeTextFieldCell.m
//  JJCPayCodeTextField
//
//  Created by 苜蓿鬼仙 on 2017/8/2.
//  Copyright © 2017年 苜蓿鬼仙. All rights reserved.
//

#import "JJCPayCodeTextFieldCell.h"


@interface JJCPayCodeTextFieldCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *leftLine;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIView *rightLine;

@end

@implementation JJCPayCodeTextFieldCell


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


#pragma mark -----
#pragma mark ---------------  Lazy Loading  ---------------

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}


- (UIView *)topLine {
    if (!_topLine) {
        
        _topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
        _topLine.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:_topLine];
    }
    return _topLine;
}

- (UIView *)leftLine {
    if (!_leftLine) {
        
        _leftLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, self.frame.size.height)];
        _leftLine.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:_leftLine];
    }
    return _leftLine;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
        _bottomLine.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:_bottomLine];
    }
    return _bottomLine;
}

- (UIView *)rightLine {
    if (!_rightLine) {
        
        _rightLine = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width-0.5, 0, 0.5, self.frame.size.height)];
        _rightLine.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:_rightLine];
    }
    return _rightLine;
}


#pragma mark -----
#pragma mark ---------------  Setter、Getter  ---------------

- (void)setIndePath:(NSIndexPath *)indePath {
    
    _indePath = indePath;
}

- (void)setCellNum:(NSInteger)cellNum {
    
    _cellNum = cellNum;
}

- (void)setCellType:(JJCPayCodeTextFieldCellType)cellType {
    
    _cellType = cellType;
    
    
    if (cellType == JJCPayCodeTextFieldCellTypeEveryBorder) {
        
        [self topLine];
        [self leftLine];
        [self bottomLine];
        [self rightLine];
        
        if (self.indePath.row == 0) {
            self.leftLine.frame = CGRectMake(0, 0, 1, self.frame.size.height);
        } else {
            self.leftLine.frame = CGRectMake(0, 0, 0.5, self.frame.size.height);
        }
        
        if (self.indePath.row == self.cellNum-1) {
            self.rightLine.frame = CGRectMake(self.frame.size.width-1, 0, 1, self.frame.size.height);
        } else {
            self.rightLine.frame = CGRectMake(self.frame.size.width-0.5, 0, 0.5, self.frame.size.height);
        }
        
    } else if (cellType == JJCPayCodeTextFieldCellTypeWholeBorder) {
        
        [self topLine];
        [self leftLine];
        [self bottomLine];
        [self rightLine];
        
        if (self.indePath.row == 0) {
            self.leftLine.frame = CGRectMake(0, 0, 1, self.frame.size.height);
        } else {
            self.leftLine.frame = CGRectMake(0, self.frame.size.height/6, 0.5, self.frame.size.height*2/3);
        }
        
        if (self.indePath.row == self.cellNum-1) {
            self.rightLine.frame = CGRectMake(self.frame.size.width-1, 0, 1, self.frame.size.height);
        } else {
            self.rightLine.frame = CGRectMake(self.frame.size.width-0.5, self.frame.size.height/6, 0.5, self.frame.size.height*2/3);
        }
        
    } else if (cellType == JJCPayCodeTextFieldCellTypeSpaceBorder) {
        
        self.contentView.layer.borderWidth = 1.0f;
        self.contentView.layer.borderColor = [UIColor blackColor].CGColor;
        
        [self titleLabel];
    }
}


#pragma mark -----
#pragma mark ---------------  Method  ---------------

- (void)setCellBorderColor:(UIColor *)cellBorderColor {
    
    _cellBorderColor = cellBorderColor;
    
    
    if (cellBorderColor) {
        if (self.cellType == JJCPayCodeTextFieldCellTypeEveryBorder) {
            
            self.topLine.backgroundColor = cellBorderColor;
            self.leftLine.backgroundColor = cellBorderColor;
            self.bottomLine.backgroundColor = cellBorderColor;
            self.rightLine.backgroundColor = cellBorderColor;
            
        } else if (self.cellType == JJCPayCodeTextFieldCellTypeWholeBorder) {
            
            self.topLine.backgroundColor = cellBorderColor;
            self.leftLine.backgroundColor = cellBorderColor;
            self.bottomLine.backgroundColor = cellBorderColor;
            self.rightLine.backgroundColor = cellBorderColor;
            
        } else if (self.cellType == JJCPayCodeTextFieldCellTypeSpaceBorder) {
            
            self.contentView.layer.borderColor = cellBorderColor.CGColor;
        }
    }
}


- (void)setTitleString:(NSString *)titleString {
    
    _titleString = titleString;
    
    self.titleLabel.text = titleString;
}



@end
