//
//  ViewController.m
//  testPicker
//
//  Created by sunzl on 15/11/19.
//  Copyright © 2015年 sunzl. All rights reserved.
//

#import "ViewController.h"
#import "SunDataPicker.h"
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
@interface ViewController ()
{
    NSArray *dict1;
    NSDictionary *dict2;
    NSDictionary *dict3;
}
@property (strong, nonatomic)  SunDataPicker *sunDataPicker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //格式
    self.view.backgroundColor=[UIColor whiteColor];
    dict1=@[@"123",@"2313",@"4423",@"9323"];
    
    dict2=@{@"121":@[@"123",@"2313"],
            @"443":@[@"4423",@"9323"]};
    
    dict3=@{@"111":@{@"121":@[@"123",@"2313"]},
            @"444":@{@"443":@[@"4423",@"9323"]}
            };
    
    _sunDataPicker =[[SunDataPicker alloc]initWithFrame:CGRectMake(0, 0,Width-20 , (Width-20)*2/3)];
    
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0,64,Width/3, 40)];
    [btn setBackgroundColor:[UIColor orangeColor]];
    [btn addTarget:self action:@selector(showOneDataPick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"显示一行" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(Width/3,64,Width/3, 40)];
    [btn1 setBackgroundColor:[UIColor orangeColor]];
    [btn1 addTarget:self action:@selector(showTwoDataPick) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"显示两行" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    
    UIButton *btn2=[[UIButton alloc]initWithFrame:CGRectMake(Width/3*2,64,Width/3, 40)];
    [btn2 setBackgroundColor:[UIColor orangeColor]];
    [btn2 addTarget:self action:@selector(showThreeDataPick) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"显示三行" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:btn2];
    
    
    
}
-(void)showOneDataPick
{
    [_sunDataPicker setNumberOfComponents:1 SET:dict1 addTarget:self.view  Complete:^(NSString *one, NSString *two, NSString *three) {
        NSLog(@"%@-%@-%@",one,two,three);
    }];
    
}
-(void)showTwoDataPick
{
    [_sunDataPicker setNumberOfComponents:2 SET:dict2 addTarget:self.view  Complete:^(NSString *one, NSString *two, NSString *three) {
        NSLog(@"%@-%@-%@",one,two,three);
    }];
    
}
-(void)showThreeDataPick
{
    [_sunDataPicker setNumberOfComponents:3 SET:dict3 addTarget:self.view  Complete:^(NSString *one, NSString *two, NSString *three) {
        NSLog(@"%@-%@-%@",one,two,three);
    }];
    
    
}

@end
