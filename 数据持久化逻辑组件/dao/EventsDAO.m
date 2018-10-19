//
//  EventsDAO.m
//  TokyoOlympicsLiuLei
//
//  Created by edarong on 2018/9/29.
//  Copyright © 2018年 LeiLiu. All rights reserved.
//

#import "EventsDAO.h"

@implementation EventsDAO

static EventsDAO *sharedSingleton = nil;

+ (EventsDAO *)sharedInstance {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedSingleton = [[super alloc] init];
        
    });
    return sharedSingleton;
}

//插入Events方法
- (int)create:(Events *)model{
    if([self openDB]){
        
        NSString *sqlstr=@"insert into Events(EventName,EventIcon,Keyinfo,BasicsInfo,OlympicInfo) values(?,?,?,?,?)";
        sqlite3_stmt *statement;
        //预处理过程
        if(sqlite3_prepare_v2(db,[sqlstr UTF8String],-1,&statement,NULL)==SQLITE_OK)
        {
            
            const char* cEventName=[model.EventName UTF8String];
            const char* cEventIcon=[model.EventName UTF8String];
            const char* cKeyInfo=[model.KeyInfo UTF8String];
            const char* cBasicInfo=[model.BasicsInfo UTF8String];
            const char* cOlympicInfo=[model.OlympicInfo UTF8String];
            
            //绑定参数开始
            sqlite3_bind_text(statement, 1, cEventName, -1, NULL);
            sqlite3_bind_text(statement, 2, cEventIcon, -1, NULL);
            sqlite3_bind_text(statement, 3, cKeyInfo, -1, NULL);
            sqlite3_bind_text(statement, 4, cBasicInfo, -1, NULL);
            sqlite3_bind_text(statement, 5, cOlympicInfo, -1, NULL);
            
            //执行插入
            if (sqlite3_step(statement)!=SQLITE_DONE) {
                sqlite3_finalize(statement);
                sqlite3_close(db);
                NSAssert(NO, @"插入数据失败。");
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    
    return 0;
}

//删除方法
-(int)remove:(Events*)model {
    if ([self openDB]) {
        
        //先删除从表（比赛日程表）相关数据
        NSString *sqlScheduleStr=[[NSString alloc] initWithFormat:@"delete from Schedule where EventID=%i",model.EventID];
        
        //开启事物，立刻提交之前的事务。
        sqlite3_exec(db, "begin immediate transaction", NULL, NULL, NULL);
        
        char* err;
        
        if (sqlite3_exec(db, [sqlScheduleStr UTF8String], NULL, NULL, &err)!=SQLITE_OK) {
            //回滚事物
            sqlite3_exec(db, "rollback transaction", NULL, NULL, NULL);
            NSAssert(false, @"删除数据失败。");
        }
        
        //先删除主表（比赛项目）数据。
        NSString *sqlEventsStr=[[NSString alloc] initWithFormat:@"Delete from Events where EventsID= %i;", model.EventID];
        
        if (sqlite3_exec(db, [sqlEventsStr UTF8String], NULL, NULL, NULL) !=SQLITE_OK) {
            //回滚事务
            sqlite3_exec(db, "rollback transaction", NULL, NULL, NULL);
            NSAssert(false, @"删除数据失败。");
        }
        
        //提交事物
        sqlite3_exec(db, "commit transaction", NULL, NULL, NULL);
        
        sqlite3_close(db);
    }
    return 0;
    
}

//EventsDao.m文件
//查询所有数据的方法
-(NSMutableArray *)findAll {
    NSMutableArray *listData=[[NSMutableArray alloc] init];
    
    if ([self openDB]) {
        NSString *qsql = @"select EventName,EventIcon,KeyInfo,BasicsInfo,OlympicInfo,EventID from Events";
        
        sqlite3_stmt *statement;
        
        //预处理过程
        if(sqlite3_prepare_v2(db,[qsql UTF8String],-1,&statement,NULL)==SQLITE_OK)
        {
            
            //执行
            while (sqlite3_step(statement)==SQLITE_ROW) {
                Events *events=[[Events alloc] init];
                
                char *cEventName=(char*)sqlite3_column_text(statement, 0);
                events.EventName = [[NSString alloc] initWithUTF8String:cEventName];
                
                char *cEventIcon=(char*)sqlite3_column_text(statement, 1);
                events.EventIcon = [[NSString alloc] initWithUTF8String:cEventIcon];
                
                char *cKeyInfo=(char*)sqlite3_column_text(statement, 2);
                events.KeyInfo = [[NSString alloc] initWithUTF8String:cKeyInfo];
                
                char *cBasicInfo=(char*)sqlite3_column_text(statement, 3);
                events.BasicsInfo = [[NSString alloc] initWithUTF8String:cBasicInfo];
                
                char *cOlympicInfo=(char*)sqlite3_column_text(statement, 4);
                events.OlympicInfo = [[NSString alloc] initWithUTF8String:cOlympicInfo];
                
                events.EventID=sqlite3_column_int(statement, 5);
                
                [listData addObject:events];
                
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
        
    }
    return listData;
}

//按照主键查询数据方法
- (Events *)findById:(Events *)model {
    
    if ([self openDB]) {
        
        NSString *qsql = @"SELECT EventName, EventIcon,KeyInfo,BasicsInfo,OlympicInfo,EventID FROM Events  where EventID =?";
        
        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            
            //绑定参数开始
            sqlite3_bind_int(statement, 1, model.EventID);
            
            //执行
            if (sqlite3_step(statement) == SQLITE_ROW) {
                
                Events *events = [[Events alloc] init];
                
                char *cEventName = (char *) sqlite3_column_text(statement, 0);
                events.EventName = [[NSString alloc] initWithUTF8String:cEventName];
                
                char *cEventIcon = (char *) sqlite3_column_text(statement, 1);
                events.EventIcon = [[NSString alloc] initWithUTF8String:cEventIcon];
                
                char *cKeyInfo = (char *) sqlite3_column_text(statement, 2);
                events.KeyInfo = [[NSString alloc] initWithUTF8String:cKeyInfo];
                
                char *cBasicsInfo = (char *) sqlite3_column_text(statement, 3);
                events.BasicsInfo = [[NSString alloc] initWithUTF8String:cBasicsInfo];
                
                char *cOlympicInfo = (char *) sqlite3_column_text(statement, 4);
                events.OlympicInfo = [[NSString alloc] initWithUTF8String:cOlympicInfo];
                
                events.EventID = sqlite3_column_int(statement, 5);
                
                sqlite3_finalize(statement);
                sqlite3_close(db);
                return events;
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    return nil;
}

//修改Events方法
- (int)modify:(Events *)model {
    
    if ([self openDB]) {
        
        NSString *sqlStr = @"UPDATE Events set EventName=?, EventIcon=?,KeyInfo=?,BasicsInfo=?,OlympicInfo=? where EventID =?";
        
        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            
            const char* cEventName = [model.EventName UTF8String];
            const char* cEventIcon = [model.EventName UTF8String];
            const char* cKeyInfo = [model.KeyInfo UTF8String];
            const char* cBasicsInfo = [model.BasicsInfo UTF8String];
            const char* cOlympicInfo = [model.OlympicInfo UTF8String];
            
            //绑定参数开始
            sqlite3_bind_text(statement, 1, cEventName, -1, NULL);
            sqlite3_bind_text(statement, 2, cEventIcon, -1, NULL);
            sqlite3_bind_text(statement, 3, cKeyInfo, -1, NULL);
            sqlite3_bind_text(statement, 4, cBasicsInfo, -1, NULL);
            sqlite3_bind_text(statement, 5, cOlympicInfo, -1, NULL);
            sqlite3_bind_int(statement, 6, model.EventID);
            
            //执行
            if (sqlite3_step(statement) != SQLITE_DONE) {
                sqlite3_finalize(statement);
                sqlite3_close(db);
                NSAssert(NO, @"修改数据失败。");
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    return 0;
}


@end
