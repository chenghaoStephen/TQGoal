//
//  AFServer.m
//  TalkShow
//
//  Created by dxd on 14/11/19.
//  Copyright (c) 2014年 dxd. All rights reserved.
//

#import "AFServer.h"
#import "AFHTTPRequestOperationManager.h"
#import "DeviceData.h"
#import "AFURLSessionManager.h"
static AFServer* server = nil;

@implementation AFServer

+ (AFServer*)sharedInstance {
    if (!server) {
        server = [[self alloc] init];
    }
    return server;
}

- (void)GET:(NSString*)url
 parameters:(NSDictionary *)parameters
finishBlock:(FinishLoadHandle)finishBlock
failedBlock:(FailedLoadHandle)failedBlock {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];//设置相应内容类型
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = HTTP_TIME_OUT;
    [manager.requestSerializer setValue:[[DeviceData shareManager]deviceName] forHTTPHeaderField:@"Device-Info"];
    [manager.requestSerializer setValue:[[DeviceData shareManager]deviceVersion] forHTTPHeaderField:@"Device-System"];
    [manager.requestSerializer setValue:[[[DeviceData shareManager]appName] URLEncodedString] forHTTPHeaderField:@"App-Name"];
    [manager.requestSerializer setValue:[[DeviceData shareManager]appVersion] forHTTPHeaderField:@"App-Version"];
    [manager.requestSerializer setValue:USER_TOKEN forHTTPHeaderField:@"User-Token"];

    
//    manager.requestSerializer.HTTPRequestHeaders;
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = responseObject;
//        NSString *result =  [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//        NSData *data2 = [result dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dictionary = (NSDictionary *)jsonObject;
            if (finishBlock) { finishBlock(dictionary); }
            
        } else if ([jsonObject isKindOfClass:[NSArray class]]) {
            NSArray *nsArray = (NSArray *)jsonObject;
            if (finishBlock) { finishBlock(nsArray); }
            
        } else if ([jsonObject isKindOfClass:[NSString class]]) {
            NSString *result =  [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            if (finishBlock) { finishBlock(result); }
            
        } else {
            if (finishBlock) { finishBlock(nil); }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failedBlock) { failedBlock(error); }
    }];
}
- (void)GETXML:(NSString*)url
 parameters:(NSDictionary *)parameters
finishBlock:(FinishLoadHandle)finishBlock
failedBlock:(FailedLoadHandle)failedBlock {
//    text/html,application/xhtml+xml,application/xml;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/xml", @"application/xhtml+xml",@"text/html", nil];

    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = HTTP_TIME_OUT;
    [manager.requestSerializer setValue:[[DeviceData shareManager]deviceName] forHTTPHeaderField:@"Device-Info"];
    [manager.requestSerializer setValue:[[DeviceData shareManager]deviceVersion] forHTTPHeaderField:@"Device-System"];
    [manager.requestSerializer setValue:[[[DeviceData shareManager]appName] URLEncodedString] forHTTPHeaderField:@"App-Name"];
    [manager.requestSerializer setValue:[[DeviceData shareManager]appVersion] forHTTPHeaderField:@"App-Version"];
    [manager.requestSerializer setValue:USER_TOKEN forHTTPHeaderField:@"User-Token"];
    [manager.requestSerializer setValue:@"text/html,application/xhtml+xml,application/xml" forHTTPHeaderField:@"Accept"];

    
    //    manager.requestSerializer.HTTPRequestHeaders;
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = responseObject;
        if (finishBlock) {
            finishBlock(data);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failedBlock) { failedBlock(error);
        }
    }];
}
- (void)POST:(NSString*)url
  parameters:(NSDictionary*)parameters
    filePath:(NSString*)filePath
 finishBlock:(FinishLoadHandle)finishBlock
 failedBlock:(FailedLoadHandle)failedBlock {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];//设置相应内容类型
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = HTTP_TIME_OUT;
    [manager.requestSerializer setValue:[[DeviceData shareManager]deviceName] forHTTPHeaderField:@"Device-Info"];
    [manager.requestSerializer setValue:[[DeviceData shareManager]deviceVersion] forHTTPHeaderField:@"Device-System"];
    [manager.requestSerializer setValue:[[[DeviceData shareManager]appName] URLEncodedString] forHTTPHeaderField:@"App-Name"];
    [manager.requestSerializer setValue:[[DeviceData shareManager]appVersion] forHTTPHeaderField:@"App-Version"];
    [manager.requestSerializer setValue:USER_TOKEN forHTTPHeaderField:@"User-Token"];

    if (filePath) {
        [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:@"img_up" error:nil];
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSData *data = responseObject;
            if (finishBlock) { finishBlock([self translateJson:data]); }
        
//            NSString *result =  [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//            if (finishBlock) { finishBlock(result); }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (failedBlock) { failedBlock(error); }
        }];
    } else {
        [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSData *data = responseObject;
//            NSString *result =  [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//            if (finishBlock) { finishBlock(result); }
            if (finishBlock) { finishBlock([self translateJson:data]); }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (failedBlock) { failedBlock(error); }
        }];
    }
}
//parameters格式  name:(NSString*)name data:(NSData*)data filePath:(NSString*)filePath
- (void)POST:(NSString*)url
  parameters:(NSArray*)parameters
 finishBlock:(FinishLoadHandle)finishBlock
 failedBlock:(FailedLoadHandle)failedBlock {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];//设置相应内容类型
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = HTTP_TIME_OUT;
    [manager.requestSerializer setValue:[[DeviceData shareManager]deviceName] forHTTPHeaderField:@"Device-Info"];
    [manager.requestSerializer setValue:[[DeviceData shareManager]deviceVersion] forHTTPHeaderField:@"Device-System"];
    [manager.requestSerializer setValue:[[[DeviceData shareManager]appName] URLEncodedString] forHTTPHeaderField:@"App-Name"];
    [manager.requestSerializer setValue:[[DeviceData shareManager]appVersion] forHTTPHeaderField:@"App-Version"];
    [manager.requestSerializer setValue:USER_TOKEN forHTTPHeaderField:@"User-Token"];


    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (UploadModel*paramerer in parameters) {
            [formData appendPartWithFileData:paramerer.data name:paramerer.key fileName:paramerer.fileName mimeType:@"file"];
        }
 
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSData *data = responseObject;
            if (finishBlock) { finishBlock([self translateJson:data]); }
            
            //            NSString *result =  [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            //            if (finishBlock) { finishBlock(result); }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (failedBlock) { failedBlock(error); }

        }];
   
}
- (void)downLoad:(NSString*)url
      parameters:(DownLoadModel*)parameters
     finishBlock:(FinishLoadHandle)finishBlock
     failedBlock:(FailedLoadHandle)failedBlock {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];

    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
      
        // 指定下载文件保存的路径
        NSString *filePath = parameters.filePath;
        filePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",parameters.messageId,parameters.fileType]];;
    
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];

        return fileURL;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (failedBlock && error) {
            NSLog(@"downloadfaile:%@ %@", filePath.absoluteString, error);
            failedBlock(error); }
        if (finishBlock && error == nil) {
            if (finishBlock) {
                NSLog(@"downloadsuccess:%@", filePath.absoluteString);

                finishBlock(filePath.absoluteString); }
        }
    }];
    [task resume];

}
- (id)translateJson:(NSData*)data{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
//    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if ([jsonObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = (NSDictionary *)jsonObject;
        return dictionary;

    } else if ([jsonObject isKindOfClass:[NSArray class]]) {
        NSArray *nsArray = (NSArray *)jsonObject;
        return nsArray;

    } else if ([jsonObject isKindOfClass:[NSString class]]) {
        NSString *result =  [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        return result;
        
    } else {
        return nil;

    }

}


@end
