//
//  DBHelper.m
//  TokyoOlympicsLiuLei
//
//  Created by edarong on 2018/9/30.
//  Copyright © 2018年 LeiLiu. All rights reserved.
//

#import "DBHelper.h"

@implementation DBHelper

+(const char*)applicationDocumentDirectoryFile:(NSString *)fileName
{
    NSString *documentDiretory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true) lastObject];
    NSString *path=[documentDiretory stringByAppendingPathComponent:fileName];
    
    const char *cpath=[path UTF8String];
    
    return cpath;
}

//初始化并且加载数据
+(void)initDB {
    
    NSBundle *frameworkBundle=[NSBundle bundleForClass:[DBHelper class]];
    
    NSString *configTablePath=[frameworkBundle pathForResource:@"DBConfig" ofType:@"plist"];
    
    NSDictionary *configTable=[[NSDictionary alloc] initWithContentsOfFile:configTablePath];
    //从配置文件中获取数据库的版本号
    NSNumber *dbConfigVersion=configTable[@"DB_VERSION"];
    if (dbConfigVersion==nil) {
        dbConfigVersion=0;
    }
    
    //从数据库的DBVersionInfo表记录返回的数据库版本号。
    int verisionNumber=[DBHelper dbVersionNumber];
    
    //版本号不一致
    if ([dbConfigVersion intValue]!=verisionNumber) {
        const char *dbFilePath=[DBHelper applicationDocumentDirectoryFile:DB_FILE_NAME];
        if (sqlite3_open(dbFilePath, &db)==SQLITE_OK) {
            //加载数据到业务表中
            NSLog(@"数据库升级。。。");
            NSString *creattablePath=[frameworkBundle pathForResource:@"create_load" ofType:@"sql"];
            NSString *sql=[[NSString alloc] initWithContentsOfFile:creattablePath encoding:NSUTF8StringEncoding error:nil];
            
            sqlite3_exec(db, [sql UTF8String], NULL, NULL, NULL);
            
            //把当前版本号写回到文件中
            NSString *usql=[[NSString alloc] initWithFormat:@"update DBVersionInfo set version_number = %i",[dbConfigVersion intValue]];
            sqlite3_exec(db, [usql UTF8String], NULL, NULL, NULL);
            
        }
        else
        {
            NSLog(@"数据库打开失败。");
        }
        sqlite3_close(db);
    }
}

+(int)dbVersionNumber{
    
    int versionNumber=-1;
    
    const char *dbFilePath=[DBHelper applicationDocumentDirectoryFile:DB_FILE_NAME];
    
    if (sqlite3_open(dbFilePath, &db)==SQLITE_OK) {
        NSString *sql=@"creat table if not exsts DBVersionInfo (version_number int)";
        sqlite3_exec(db, [sql UTF8String], NULL, NULL, NULL);
        
        NSString *qsql=@"select verison_number from DBVersionInfo";
        const char *csql=[qsql UTF8String];
        
        sqlite3_stmt *statement;
        
        //预处理过程
        if (sqlite3_prepare(db, csql, -1, &statement, NULL)==SQLITE_OK) {
            //执行查询
            if (sqlite3_step(statement) == SQLITE_ROW) {//有数据情况
                
                NSLog(@"有数据情况");
                versionNumber=sqlite3_column_int(statement, 0);
            }
            else
            {
                //无数据情况，插入数据
                NSLog(@"无数据情况");
                NSString *insertSql=@"insert into DBVersionInfo (version_number) values(-1)";
                const char *cInsertSql=[insertSql UTF8String];
                sqlite3_exec(db, cInsertSql, NULL, NULL, NULL);
            }
        }

        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    else
        sqlite3_close(db);
    return versionNumber;
    
    
}
@end
