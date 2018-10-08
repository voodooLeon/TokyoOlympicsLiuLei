//
//  DBHelper.h
//  TokyoOlympicsLiuLei
//
//  Created by edarong on 2018/9/30.
//  Copyright © 2018年 LeiLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

#define DB_FILE_NAME @"app.db"

static sqlite3 *db;

@interface DBHelper : NSObject

//获取沙箱Dcument目录下的全路径
+(const char*)applicationDocumentDirectoryFile:(NSString*)fileName;

//初始化并加载数据
+(void)initDB;

//从数据库获得当前数据库的版本号
+(int)dbVersionNumber;
@end

