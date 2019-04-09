//
//  DBHelper.h
//  iTing_rebuild
//
//  Created by zhengqiang zhang on 2018/10/9.
//  Copyright © 2018年 上海宝云网络. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

@interface DBHelper : NSObject

+ (NSString *)dbFilePath;

+ (void)batchUpdate:(void(^)(FMDatabase *db)) block;

+ (BOOL)executeUpdate:(NSString *)sql , ...;

+ (NSArray *)getRows:(NSString *)sql, ...;

+ (NSArray *)getRows:(NSString *)sql params:(NSArray *)params;

+ (NSSet *)getColumnsInTable:(NSString *)table;

+ (NSSet *)getColumnsInTable:(NSString *)table inDB:(FMDatabase *)db;

@end
