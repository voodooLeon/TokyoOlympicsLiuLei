//
//  CountDownViewController.m
//  TokyoOlympicsLiuLei
//
//  Created by edarong on 2018/10/18.
//  Copyright © 2018年 LeiLiu. All rights reserved.
//

#import "CountDownViewController.h"

@interface CountDownViewController ()

@end

@implementation CountDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //创建NSDataComponetS对象
    NSDateComponents *comps=[[NSDateComponents alloc] init];
    //设置NSDateComponets对象的日期属性
    [comps setDay:24];
    //设置NSDateComponets对象的月属性
    [comps setMonth:7];
    //设置NSDateComponets对象的年属性
    [comps setYear:2020];
    //创建日历对象
    NSCalendar *calender=[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //获得2020-7-24的nsDataComponets对象
    NSDate *destionationData=[calender dateFromComponents:comps];
    NSDate *date=[NSDate date];
    //获取当前日期到2020-7-24的NSDataComponets对象
    NSDateComponents *components=[calender components:NSCalendarUnitDay fromDate:date
                                               toDate:destionationData
                                              options:NSCalendarWrapComponents];
    //获取当前日期到2020-7-24相差的天数
    NSInteger days=[components day];
    
    NSString *strDays=[NSString stringWithFormat:@"%li", (long)days];
    //设置iphpone 中的标签
    self.lblCountDownPhone.text=strDays;
    //设置iPad中的标签
    self.lblCountDownPad.text=strDays;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
