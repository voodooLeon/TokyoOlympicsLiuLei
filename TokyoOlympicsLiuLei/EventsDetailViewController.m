//
//  EventsDetailView.m
//  TokyoOlympicsLiuLei
//
//  Created by edarong on 2018/10/15.
//  Copyright © 2018年 LeiLiu. All rights reserved.
//

#import "EventsDetailViewController.h"

@interface EventsDetailViewController ()

@property (nonatomic) UILabel *lblEventName;
@property (nonatomic) UIImageView *imgEventIcon;
@property (nonatomic) UITextView *txtViewKeyInfo;
@property (nonatomic) UITextView *txtViewBasicsInfo;
@property (nonatomic) UITextView *txtViewOlympicInfo;

@end

@implementation EventsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screen=[[UIScreen mainScreen] bounds];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    //1.添加ImageView
    self.imgEventIcon=[[UIImageView alloc] initWithFrame:CGRectMake(10, 80, 102, 102)];
    
    self.imgEventIcon.image=[UIImage imageNamed:self.event.EventIcon];
    [self.view addSubview:self.imgEventIcon];
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
