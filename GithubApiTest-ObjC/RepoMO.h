//
//  RepoMO.h
//  GithubApiTest-ObjC
//
//  Created by MariaSaveleva on 19/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Repo;

NS_ASSUME_NONNULL_BEGIN

@interface RepoMO : NSManagedObject

@property (nonatomic) int64_t identifier;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong, nullable) NSString *repoDescription;
@property (nonatomic, strong) NSString *owner;

- (void)configureWith:(Repo *)repo;

@end

NS_ASSUME_NONNULL_END
