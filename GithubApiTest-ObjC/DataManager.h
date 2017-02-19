//
//  DataManager.h
//  GithubApiTest-ObjC
//
//  Created by MariaSaveleva on 18/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Repo;

NS_ASSUME_NONNULL_BEGIN

@interface DataManager : NSObject

+ (instancetype)sharedInstance;

/// Load data from server or cache (if exists).
- (void)loadReposForUser:(NSString *)userName
              completion:(nullable void(^)(NSArray <Repo *> * _Nullable repos, NSError * _Nullable error))completion;

/// Always load data from server.
- (void)forceLoadReposForUser:(NSString *)userName
                   completion:(nullable void(^)(NSArray <Repo *> * _Nullable repos, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
