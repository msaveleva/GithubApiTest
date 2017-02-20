//
//  ConnectionService.h
//  GithubApiTest-ObjC
//
//  Created by MariaSaveleva on 18/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConnectionService : NSObject

- (void)loadDataWithRequest:(NSURLRequest *)request
                 completion:(nullable void(^)(NSArray * _Nullable dataArray, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
