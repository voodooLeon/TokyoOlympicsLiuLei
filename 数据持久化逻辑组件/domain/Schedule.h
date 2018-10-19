//
//  Schedule.h
//  TokyoOlympicsLiuLei
//
//  Created by edarong on 2018/9/28.
//  Copyright © 2018年 LeiLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Events.h"


//比赛日程表实体表
@interface Schedule : NSObject
//编号
@property(nonatomic,assign)int ScheduleID;
//比赛日期
@property(nonatomic,strong) NSString* GameDate;
//比赛时间
@property(nonatomic,strong) NSString* GameTime;
//比赛描述
@property(nonatomic,strong) NSString* GameInfo;
//比赛项目
@property(nonatomic,strong) Events* Event;
@end

