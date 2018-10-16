//
//  ScheduleViewController.m
//  TokyoOlympicsLiuLei
//
//  Created by edarong on 2018/10/16.
//  Copyright © 2018年 LeiLiu. All rights reserved.
//

#import "ScheduleViewController.h"
#import "EventsDetailViewController.h"

#import "Schedule.h"
#import "ScheduleDAO.h"
#import "EventsDAO.h"

@interface ScheduleViewController ()
//表视图使用的数据
@property(strong,nonatomic) NSDictionary *data;
//比赛日期列表
@property(strong,nonatomic) NSArray *arrayGameDataList;
@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.data==nil||[self.data count]==0) {
        self.data=[self readData];
        NSArray* keys=[self.data allKeys];
        //对key进行排序
        self.arrayGameDataList=[keys sortedArrayUsingSelector:@selector(compare:)];
        
    }
}

//查询数据的方法。
-(NSMutableDictionary*) readData {
    ScheduleDAO *scheduleDAO=[ScheduleDAO sharedInstance];
    NSMutableArray* schedules=[[NSMutableArray alloc] init];
    NSMutableDictionary *resDict=[[NSMutableDictionary alloc] init];
    
    EventsDAO *eventsDAO=[EventsDAO sharedInstance];
    
    //延迟加载Events数据
    for (Schedule *schedule in schedules) {
        Events *event=[eventsDAO findById:schedule.Event];
        schedule.Event=event;
        
        NSArray *allkey=[resDict allKeys];
        
        //把数据结构(nsmutableArray) 转化成字典结构 （nsmutableDictionary)
        if ([allkey containsObject:schedule.GameDate]) {
            NSMutableArray* value=resDict[schedule.GameDate];
            [value addObject:schedule];
        }
        else
        {
            NSMutableArray* value=[[NSMutableArray alloc] init];
            [value addObject:schedule];
            resDict[schedule.GameDate]=value;
        }
    }
    return resDict;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSArray* keys=[self.data allKeys];
    return [keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //比赛日期
    
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
