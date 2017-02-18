//
//  RepoParser.h
//  GithubApiTest-ObjC
//
//  Created by MariaSaveleva on 18/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Repo;

NS_ASSUME_NONNULL_BEGIN

@interface RepoParser : NSObject

- (nullable Repo *)createRepoWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
