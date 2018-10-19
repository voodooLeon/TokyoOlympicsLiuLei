//
//  BaseDAO.h
//  TokyoOlympicsLiuLei
//
//  Created by edarong on 2018/9/28.
//  Copyright © 2018年 LeiLiu. All rights reserved.
//

#import "sqlite3.h"
#import <Foundation/Foundation.h>
#import "DBHelper.h"



@interface BaseDAO : NSObject
{
        sqlite3 *db;
}
-(BOOL)openDB;

@end

