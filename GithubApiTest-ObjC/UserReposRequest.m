//
//  UserReposRequest.m
//  GithubApiTest-ObjC
//
//  Created by MariaSaveleva on 18/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import "UserReposRequest.h"
#import "Constants.h"

@implementation UserReposRequest

+ (instancetype)createWithUserName:(NSString *)userName {
    NSString *urlString = [[kBaseURLString stringByAppendingString:userName] stringByAppendingString:@"/repos"];
    NSURL *url = [NSURL URLWithString:urlString];

    return [UserReposRequest requestWithURL:url];
}

@end
