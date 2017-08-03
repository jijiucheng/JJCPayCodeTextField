//
//  JJCPayCodeTextField.m
//  JJCPayCodeTextField
//
//  Created by 苜蓿鬼仙 on 2017/8/2.
//  Copyright © 2017年 苜蓿鬼仙. All rights reserved.
//

#import "JJCPayCodeTextField.h"

#import "JJCTextField.h"
#import "JJCPayCodeTextFieldCell.h"


@interface JJCPayCodeTextField ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate>

@property (nonatomic, assign) JJCPayCodeTextFieldType textFieldType;    // 样式

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) NSMutableArray *dataArrayM;           // 要显示的数组（中间变量）
@property (nonatomic, strong) NSMutableArray *ciphertextArrayM;     // 密文 数组
@property (nonatomic, strong) NSMutableArray *plaintextArrayM;      // 明文 数组

@property (nonatomic, strong) JJCTextField *textField;      // 禁止复制粘贴功能

@end

@implementation JJCPayCodeTextField


static NSString *const reuseId = @"JJCPayCodeTextFieldCell";


- (instancetype)initWithFrame:(CGRect)frame TextFieldType:(JJCPayCodeTextFieldType)textFieldType {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        self.textFieldType = textFieldType;
        
        
        [self createUI];
    }
    return self;
}


- (void)createUI {
    
    [self collectionView];
    [self.textField becomeFirstResponder];
}


#pragma mark -----
#pragma mark ---------------  Lazy Loading  ---------------

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate   = self;
        _collectionView.scrollEnabled = NO;
        [self addSubview:_collectionView];
        
        
        [_collectionView registerClass:[JJCPayCodeTextFieldCell class] forCellWithReuseIdentifier:reuseId];
    }
    return _collectionView;
}


- (NSMutableArray *)dataArrayM {
    if (!_dataArrayM) {
        
        if (self.textFieldNum == 0) {
            self.textFieldNum = 8;
        }
        
        _dataArrayM       = [NSMutableArray array];
        _ciphertextArrayM = [NSMutableArray array];
        _plaintextArrayM  = [NSMutableArray array];
        
        NSString *string = @"";
        
        for (int i=0; i < self.textFieldNum; i++) {
            [_dataArrayM addObject:string];
            [_ciphertextArrayM addObject:string];
            [_plaintextArrayM addObject:string];
        }
    }
    return _dataArrayM;
}


- (UITextField *)textField {
    if (!_textField) {
        
        _textField = [[JJCTextField alloc] initWithFrame:self.bounds];
        _textField.backgroundColor = [UIColor clearColor];
        _textField.delegate = self;
        _textField.textColor = [UIColor clearColor];
        _textField.tintColor = [UIColor clearColor];
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:_textField];
    }
    return _textField;
}


- (void)setIsChangeTextFieldNum:(BOOL)isChangeTextFieldNum {
    
    _isChangeTextFieldNum = isChangeTextFieldNum;
}


- (void)setTextFieldNum:(NSInteger)textFieldNum {
    
    _textFieldNum = textFieldNum;
    
    
    if (self.isChangeTextFieldNum) {
        if (textFieldNum > self.dataArrayM.count) {     // 增加长度
            for (int i=0; i < (textFieldNum-self.dataArrayM.count); i++) {
                [self.plaintextArrayM addObject:@""];
                [self.ciphertextArrayM addObject:@""];
            }
        } else {    // 减小长度
            textFieldNum = textFieldNum < 0 ? 0:textFieldNum;   // 此判断用来防止无输入长度小于0的情况
            [self.plaintextArrayM replaceObjectsInRange:NSMakeRange(textFieldNum, self.dataArrayM.count-textFieldNum) withObjectsFromArray:@[]];
            [self.ciphertextArrayM replaceObjectsInRange:NSMakeRange(textFieldNum, self.dataArrayM.count-textFieldNum) withObjectsFromArray:@[]];
        }
    }
    
    
    [self updateData];
}


- (void)setIsShowTrueCode:(BOOL)isShowTrueCode {
    
    _isShowTrueCode = isShowTrueCode;
    
    [self updateData];
}


- (void)setBorderSpace:(CGFloat)borderSpace {
    
    _borderSpace = borderSpace < 0 ? 0:borderSpace;     // 防止输入间距小于0 的情况
    
    [self updateData];
}


- (void)setBorderColor:(UIColor *)borderColor {
    
    _borderColor = borderColor;
    
    [self updateData];
}


#pragma mark -----
#pragma mark ---------------  UICollectionViewDataSource、UICollectionViewDelegateFlowLayout  ---------------

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArrayM.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JJCPayCodeTextFieldCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId forIndexPath:indexPath];
    
    cell.indePath = indexPath;
    cell.cellNum  = self.dataArrayM.count;
    cell.cellType = (NSInteger)self.textFieldType;
    cell.titleString = self.dataArrayM[indexPath.row];
    cell.cellBorderColor = self.borderColor;
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.textFieldType == JJCPayCodeTextFieldTypeSpaceBorder) {
        return CGSizeMake(self.frame.size.width/self.textFieldNum-self.borderSpace-0.005, self.frame.size.height);
    } else {
        return CGSizeMake(self.frame.size.width/self.textFieldNum-0.005, self.frame.size.height);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    if (self.textFieldType == JJCPayCodeTextFieldTypeSpaceBorder) {
        return self.borderSpace;
    } else {
        return 0;
    }
}


#pragma mark -----
#pragma mark ---------------  UITextFieldDelegate  ---------------

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    NSLog(@"text -- %@, string -- %@, location -- %zd, length -- %zd", textField.text, string, range.location, range.length);
    
    
    if (range.length != 0) {    // 删除
        
        [_plaintextArrayM replaceObjectAtIndex:range.location withObject:string];
        string = @"";
        [_ciphertextArrayM replaceObjectAtIndex:range.location withObject:string];

        [self updateData];
        return YES;
        
    } else {
        if (textField.text.length >= self.textFieldNum) {

            [self updateData];
            return NO;
            
        } else {
            
            [_plaintextArrayM replaceObjectAtIndex:range.location withObject:string];
            string = @"●";
            [_ciphertextArrayM replaceObjectAtIndex:range.location withObject:string];
            
            [self updateData];
            return YES;
        }
    }
}


- (void)updateData {
    
    [self dataArrayM];      // 防止未创建时就调用
    
    self.payCodeString = [self.plaintextArrayM componentsJoinedByString:@""];
    
    
    if (self.isShowTrueCode) {
        self.dataArrayM = [NSMutableArray arrayWithArray:[self.plaintextArrayM copy]];
    } else {
        self.dataArrayM = [NSMutableArray arrayWithArray:[self.ciphertextArrayM copy]];
    }
    
    [_collectionView reloadData];
}




@end







