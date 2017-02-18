//
//  ConnectionService.m
//  GithubApiTest-ObjC
//
//  Created by MariaSaveleva on 18/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import "ConnectionService.h"

@implementation ConnectionService

- (void)loadDataWithRequest:(NSURLRequest *)request
                 completion:(nullable void(^)(NSArray * _Nullable dataArray, NSError * _Nullable error))completion {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *downloadTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data != nil) {
            NSError *parsingError;
            NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:0
                                                                    error:&parsingError];

            if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                jsonObject = @[jsonObject];
            }

            completion(jsonObject, error);
        } else {
            completion(nil, error);
            NSLog(@"Error loading data");
        }
    }];

    [downloadTask resume];
}

@end
