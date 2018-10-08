//
//  SchduleDAO.h
//  TokyoOlympicsLiuLei
//
//  Created by edarong on 2018/9/30.
//  Copyright © 2018年 LeiLiu. All rights reserved.
//

#import "BaseDAO.h"
#import "Schedule.h"
#import "Events.h"
#import "ScheduleDAO.h"
#import "sqlite3.h"

//比赛日程表 数据访问对象类
@interface ScheduleDAO : BaseDAO

+ (ScheduleDAO *)sharedInstance;

//插入Note方法
- (int)create:(Schedule *)model;

//删除Note方法
- (int)remove:(Schedule *)model;

//修改Note方法
- (int)modify:(Schedule *)model;

//查询所有数据方法
- (NSMutableArray *)findAll;

//按照主键查询数据方法
- (Schedule *)findById:(Schedule *)model;

@end
