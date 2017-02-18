//
//  Repo.m
//  GithubApiTest-ObjC
//
//  Created by MariaSaveleva on 18/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import "Repo.h"

@interface Repo ()

@property (nonatomic) int64_t identifier;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *repoDescription;

@end

@implementation Repo

- (instancetype)initWithIdentifier:(int64_t)identifier name:(NSString *)name repoDescription:(NSString *)repoDescription {
    self = [super init];

    if (self) {
        _identifier = identifier;
        _name = name;
        _repoDescription = repoDescription;
    }

    return self;
}

@end
