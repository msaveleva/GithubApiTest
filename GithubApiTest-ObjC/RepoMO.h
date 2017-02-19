//
//  RepoMO.h
//  GithubApiTest-ObjC
//
//  Created by MariaSaveleva on 19/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Repo;

@interface RepoMO : NSManagedObject

@property (nonatomic) int64_t identifier;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *repoDescription;

- (void)configureWith:(Repo *)repo;

@end
