//
//  UserReposRequest.h
//  GithubApiTest-ObjC
//
//  Created by MariaSaveleva on 18/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserReposRequest : NSURLRequest

+ (instancetype)createWithUserName:(NSString *)userName;

@end
