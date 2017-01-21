//
//  AddAccountVC.m
//  GuaGuaAccount
//
//  Created by xxb on 17/1/11.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import "AddAccountVC.h"
#import "AddAccountView.h"
#import "CategoryModel.h"
#import "CategoryCell.h"
#import "AccountModel.h"
#import "AccountViewmodel.h"

#define NumOfEachSection 4  //每行4个

@interface AddAccountVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>{
    NSInteger _accountType;
}

@property(nonatomic, strong) AddAccountView *addAccountView;
@property(nonatomic, strong) NSMutableArray *categorySource;
@property(nonatomic, strong) AccountModel *accountModel;

@end

@implementation AddAccountVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupContentView];
    [self dataInit];
    [self reloadViewData];
}

-(void)dataInit{
    _accountType = TypePayOut;
    self.accountModel = [[AccountModel alloc] init];
    self.accountModel.accountType = enumToString(TypePayOut);
    self.addAccountView.moneyTextField.text = @"";
    self.addAccountView.typeBtn.tag = TypePayOut;
    [self.addAccountView.typeBtn setTitle:@"支出" forState:UIControlStateNormal];
}

- (void)setupContentView{
    [self.view addSubview:self.addAccountView];
}

- (void)reloadViewData{
    [self reloadLeftMoney];
    [self reloadCategory];
}

-(void)reloadLeftMoney{
    GGWeakSelfDefine
    [AccountViewmodel getLastLeftMoneyWithBlock:^(NSString *leftCount, NSString *consumeCount) {
        GGWeakSelf.addAccountView.tipLabel.text = [NSString stringWithFormat:@"本月剩余%@，已花费%@", leftCount,  consumeCount];
    }];
}

-(void)reloadCategory{
    if(_accountType == TypePayOut){
        self.categorySource = [AccountViewmodel getPayOutCategorys];
    }else{
        self.categorySource = [AccountViewmodel getInComeCategorys];
    }
    [self.addAccountView.categoryCollectionView reloadData];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITableView delegate

#pragma mark -UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.categorySource.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = self.addAccountView.categoryCollectionView.frameWidth / NumOfEachSection;
    return CGSizeMake(width, width);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,0,0,0);
}


//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryModel *model = self.categorySource[indexPath.row];
    CategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Category" forIndexPath:indexPath];
    cell.label.text = model.categoryName;
    cell.label.textColor = [UIColor blackColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryCell *cell = (CategoryCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.label.textColor = [UIColor redColor];
    CategoryModel *model = self.categorySource[indexPath.row];
    self.accountModel.categoryId = model.categoryId;
    self.accountModel.categoryName = model.categoryName;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryCell *cell = (CategoryCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.label.textColor = [UIColor blackColor];
}


#pragma mark - View delegate

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.accountModel.price = textField.text;
}

#pragma mark - Other delegate


#pragma mark - Action

-(void)typeChg:(id)sender{
    UIButton *btn = (UIButton*)sender;
    btn.tag = !btn.tag;
    if(btn.tag == TypePayOut){
        //支出
        _accountType = TypePayOut;
        self.accountModel.accountType = enumToString(TypePayOut);
        [btn setTitle:@"支出" forState:UIControlStateNormal];
        [self showTipNoBtn:@"当前是支出状态"];
        [self reloadCategory];
    }else{
        //收入
        _accountType = TypeIncome;
        self.accountModel.accountType = enumToString(TypeIncome);
        [btn setTitle:@"收入" forState:UIControlStateNormal];
        [self showTipNoBtn:@"当前是收入状态"];
        [self reloadCategory];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)save{
    if([NSString isBlankString:self.accountModel.categoryId]){
        [self showTip:@"请选择类别"];
        return;
    }
    if([NSString isBlankString:self.accountModel.price]){
        [self showTip:@"请输入金额"];
        return;
    }
    //保存前的验证
    [self.accountModel saveToDB];
    [self showTipNoBtn:@"保存成功"];
    //保存之后要返回原先状态
    [self dataInit];
    [self.addAccountView.categoryCollectionView reloadData];
    [self reloadCategory];
    [self reloadLeftMoney];
}

#pragma mark - Properrtys

-(AddAccountView*)addAccountView{
    if(!_addAccountView){
        _addAccountView = [[AddAccountView alloc] init];
        _addAccountView.categoryCollectionView.delegate = self;
        _addAccountView.categoryCollectionView.dataSource = self;
//        _addAccountView.categoryCollectionView.collectionViewLayout.
        [_addAccountView.categoryCollectionView registerNib:[UINib nibWithNibName:@"CategoryCell" bundle:nil] forCellWithReuseIdentifier:@"Category"];
        _addAccountView.moneyTextField.delegate = self;
        [_addAccountView.typeBtn addTarget:self action:@selector(typeChg:) forControlEvents:UIControlEventTouchUpInside];
        [_addAccountView.saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addAccountView;
}

@end
