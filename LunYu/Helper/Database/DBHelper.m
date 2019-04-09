//
//  DBHelper.m
//  iTing_rebuild
//
//  Created by zhengqiang zhang on 2018/10/9.
//  Copyright © 2018年 上海宝云网络. All rights reserved.
//

#import "DBHelper.h"
#import <FCFileManager.h>

@interface DBHelper ()

@property(nonatomic, strong) FMDatabaseQueue *queue;

@end


@implementation DBHelper

+ (void)load {
    [self shareHelper];
}

+ (NSString *)dbFilePath {
    return [FCFileManager pathForDocumentsDirectoryWithPath:@"app.db"];
}

+ (void)initialize {
    AppLog(@"%@", [self dbFilePath]);
}

+ (instancetype)shareHelper {
    static DBHelper *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DBHelper alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        self.queue = [FMDatabaseQueue databaseQueueWithPath:[DBHelper dbFilePath]];
    }
    return self;
}

+ (void)batchUpdate:(void(^)(FMDatabase *db))block {
    [[DBHelper shareHelper].queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if (block) {
            block(db);
        }
        *rollback = NO;
    }];
}

+ (BOOL)executeUpdate:(NSString *)sql, ... {
    
    __block va_list args;
    va_start(args, sql);
    va_list *bargs = &args;
    __block BOOL result = NO;
    [[DBHelper shareHelper].queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        result = [db executeUpdate:sql withVAList:*bargs];
    }];
    va_end(args);
    return result;
}

+ (NSArray *)getRows:(NSString *)sql, ...{
    __block va_list args;
    __block NSArray *ra = nil;
    va_list *bargs = &args;
    va_start(args, sql);
    [[DBHelper shareHelper].queue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:sql withVAList:*bargs];
        ra = [self allRecordsFromResult:result];
        [db closeOpenResultSets];
    }];
    va_end(args);
    return ra;
}

+ (NSArray *)getRows:(NSString *)sql params:(NSArray *)params {
    __block NSArray *ra = nil;
    [[DBHelper shareHelper].queue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:sql withArgumentsInArray:params];
        ra = [self allRecordsFromResult:result];
        [db closeOpenResultSets];
    }];
    return ra;
}

+ (NSArray *)allRecordsFromResult:(FMResultSet *)rs {
    NSMutableArray * allRecords = [[NSMutableArray alloc] init];
    if (rs) {
        while ([rs next]) {
            [allRecords addObject:rs.resultDictionary];
        }
    }
    return [allRecords copy];
}

+ (NSSet *)getColumnsInTable:(NSString *)table inDB:(FMDatabase *)db {
    FMResultSet *result = [db getTableSchema:table];
    NSMutableSet *set = [NSMutableSet set];
    if (result ) {
        while ([result next]) {
            NSDictionary *dict = result.resultDictionary;
            NSString *name = dict[@"name"];
            if (name) {
                [set addObject:name];
            }
        }
        [db closeOpenResultSets];
    }
    return set;
}

+ (NSSet *)getColumnsInTable:(NSString *)table {
    __block NSSet *set;
    [[DBHelper shareHelper].queue inDatabase:^(FMDatabase *db) {
        set = [self getColumnsInTable:table inDB:db];
    }];
    return set;
}
@end
