//
//  BaseDAO.m
//  TokyoOlympicsLiuLei
//
//  Created by edarong on 2018/9/28.
//  Copyright © 2018年 LeiLiu. All rights reserved.
//

#import "BaseDAO.h"
#import "DBHelper.h"

@implementation BaseDAO
-(id)init{
    self=[super init];
    if (self) {
        [DBHelper initDB];
    }
    return self;
}

-(BOOL)openDB{
    
    const char* dbFilePath = [DBHelper applicationDocumentsDirectoryFile:DB_FILE_NAME];
    
    NSLog(@"DbFilePath = %s",dbFilePath);
    
    if (sqlite3_open(dbFilePath, &db)!=SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败。");
        return false;
    }
    return true;
}

@end
