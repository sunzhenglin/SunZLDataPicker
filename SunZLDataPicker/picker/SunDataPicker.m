//
//  SunDataPicker.m
//  testPicker
//
//  Created by sunzl on 15/11/19.
//  Copyright © 2015年 sunzl. All rights reserved.
//

#import "SunDataPicker.h"
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
@implementation SunDataPicker

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configView];
       
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configView];
    }
    return self;
}
-(void)configView
{
    CGRect frame=self.frame;
    self.backgroundColor=[UIColor whiteColor];
    
    _title=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 40)];
    _title.backgroundColor=[UIColor groupTableViewBackgroundColor];
    _title.textAlignment=NSTextAlignmentCenter;
    _title.text=@"请选择";
    _picker=[[UIPickerView alloc]initWithFrame:CGRectMake(10,0, frame.size.width-20, frame.size.height)];
    _picker.delegate=self;
    _picker.dataSource=self;
    _btn=[[UIButton alloc]initWithFrame:CGRectMake(0, frame.size.height-40, frame.size.width, 40)];
    [_btn setBackgroundColor:[UIColor redColor]];
    [_btn addTarget:self action:@selector(getData) forControlEvents:UIControlEventTouchUpInside];
    [_btn setTitle:@"确定" forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self addSubview:_picker];
    [self addSubview:_title];
    [self addSubview:_btn];
    self.layer.cornerRadius=7.f;
    self.layer.masksToBounds=YES;

  
    

}
-(void)getData
{
    [self hideView];
    NSString *one,*two,*three;
    if (_oneTitles&&_oneTitles>0) {
        one=_oneTitles[_selectOne];
    }
    if (_secondTitles&&_secondTitles>0) {
        two=_secondTitles[_selectTwo];
    }
    if (_thirdTitles&&_thirdTitles>0) {
        three=_thirdTitles[_selectThree];
    }
    _complete(one,two,three);
   
}
//点击完成 并隐藏；
-(void)hideView
{
    
    [self removeFromSuperview];
    [_maskView removeFromSuperview];
   
}
-(UIView *)maskView
{
    if (!_maskView) {
        NSLog(@"----");
        _maskView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,Width,Height)];
        _maskView.backgroundColor=[UIColor blackColor];
        _maskView.alpha=.3f;
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideView)];
        [_maskView addGestureRecognizer:tapGesture];
    }
    return _maskView;

}
-(void)setNumberOfComponents:(int)numberOfComponents SET:(id)dict addTarget:(id)target Complete:(Complete)complete
{
    
   //清空记录
    _oneTitles=nil;
    _thirdTitles=nil;
    _secondTitles=nil;
    _selectOne=0;
    _selectTwo=0;
    _selectThree=0;
    
    //调整位置
    UIView * tar=(UIView *)target;
    [tar addSubview:self];
    [tar insertSubview:self.maskView belowSubview:self];
    
    self.center=CGPointMake(tar.center.x, tar.center.y*2/3);    _numberOfComponents=numberOfComponents;
    _dict=dict;
    //处理数据源
    switch (_numberOfComponents) {
        case 1:
            _oneTitles=(NSArray *)_dict;
            break;
        case 2:
            _oneTitles=[_dict allKeys];
       
            _secondTitles=(NSArray *)_dict[_oneTitles[0]];
           
            break;
        default:
            _oneTitles=[_dict allKeys];
            
            _secondDict= _dict[_oneTitles[0]];
            _secondTitles=[_secondDict allKeys];
    
            _thirdTitles=_secondDict[_secondTitles[0]];
        
            break;
    }
   [self.picker reloadAllComponents];
  
    _complete=[complete copy];
    
}

#pragma mark - UIPickerViewDataSource Implementation

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
   
    return _numberOfComponents;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    int numberOfColnums=0;
    
    if (component<_numberOfComponents&&component==0) {
        numberOfColnums=[_oneTitles count];
    }
    
    if (component<_numberOfComponents&&component==1) {
        numberOfColnums=[_secondTitles count];
    }
    
    if (component<_numberOfComponents&&component==2) {
        numberOfColnums=[_thirdTitles count];
    }

    return numberOfColnums;
}

#pragma mark UIPickerViewDelegate Implementation

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    
    if (component<_numberOfComponents&&component==0) {
        return _oneTitles[row];
    }
    
    if (component<_numberOfComponents&&component==1) {
        return _secondTitles[row];
    }
    
    if (component<_numberOfComponents&&component==2) {
        return _thirdTitles[row];
    }
    return nil;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"row is %d,Component is %d",row,component);
   
    switch (_numberOfComponents) {
        case 2:
        {
            if (component==0) {
                if ([_oneTitles count]>0) {
                 _secondTitles=(NSArray *)_dict[_oneTitles[row]];
                }else{
                  _secondTitles=nil;
                }
              
                _selectOne=row;
               // _selectTwo=0;
                [pickerView reloadComponent:1];
                //[pickerView selectRow:0 inComponent:1 animated:YES];
                
            }
            if (component==1) {
                _selectTwo=row;
            }
         }
            break;
            case 3:
        {
            if (component==0) {
                if ([_oneTitles count]>0) {
                    _secondDict= _dict[_oneTitles[row]];
                    _secondTitles=[_secondDict allKeys];
                }else{
                    _secondDict= nil;
                    _secondTitles=nil;
                }
                if ([_secondTitles count]>0) {
                    _thirdTitles=_secondDict[_secondTitles[0]];
                }else{
                    _thirdTitles=nil;
                }
                 _selectOne=row;
                _selectTwo=0;
               // _selectThree=0;
                [pickerView reloadComponent:1];
                [pickerView reloadComponent:2];
                [pickerView selectRow:0 inComponent:1 animated:YES];
                //[pickerView selectRow:0 inComponent:2 animated:YES];
              
                
                
            }
            
            if (component==1) {
                if ([_secondTitles count]>0) {
                    _thirdTitles=_secondDict[_secondTitles[0]];
                }else{
                    _thirdTitles=nil;
                }
                _selectTwo=row;
                _selectThree=0;
                [pickerView reloadComponent:2];
                [pickerView selectRow:0 inComponent:2 animated:YES];
                
            }
            if (component==2) {
                _selectThree=row;
              
            }
            
        }
            break;
        default:
             _selectOne=row;
            break;
    }

}
//修改字体大小
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
       // pickerLabel.minimumFontSize = 8.;
         pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:15.f]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
@end
