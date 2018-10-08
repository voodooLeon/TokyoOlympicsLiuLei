//
//  EventsDAO.h
//  TokyoOlympicsLiuLei
//
//  Created by edarong on 2018/9/29.
//  Copyright © 2018年 LeiLiu. All rights reserved.
//
#import "BaseDAO.h"
#import "Events.h"
#import "EventsDAO.h"

//比赛项目 数据访问对象类
@interface EventsDAO : BaseDAO

+ (EventsDAO *)sharedInstance;

//插入Note方法
- (int)create:(Events *)model;

//删除Note方法
- (int)remove:(Events *)model;

//修改Note方法
- (int)modify:(Events *)model;

//查询所有数据方法
- (NSMutableArray *)findAll;

//按照主键查询数据方法
- (Events *)findById:(Events *)model;


@end
