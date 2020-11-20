//
//  DCPhotoKit.m
//  百思不得姐
//
//  Created by 大橙子 on 2019/11/27.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import "DCPhotoKit.h"
#import <PhotosUI/PhotosUI.h>
#import <SVProgressHUD.h>
@implementation DCPhotoKit
#pragma mark 1、获取相册对象
+(PHAssetCollection *)createPHAssetCollection{
    
    // 获取app的名字
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    
    /**
     PHAssetCollectionTypeAlbum      = 1, 自定义相册(普通的相册)
     PHAssetCollectionTypeSmartAlbum = 2, 智能相册(系统自带的相册)，如：Camera Roll
     PHAssetCollectionTypeMoment     = 3, 按照时刻分的相册
     */
    
    // 相机胶卷相册，打印：Camera Roll
    // PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    // 自定义相册，打印：自定义相册的名字
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    // 自己的相册
    PHAssetCollection *appCollection = nil;
    
    for (PHAssetCollection *collection in collections) {
        
        // NSLog(@"相册的名字=%@",collection.localizedTitle);
        
        if ([collection.localizedTitle isEqualToString:appName]) {
            
            // 有符合条件的直接返回
            return collection;
        }
    }
    
    if (appCollection == nil) {
        
        // 当前App的相册没有被创建过
        
        NSError *error = nil;

        __block NSString *createCollectionID = nil;
        
        // 创建一个自定义相册
        [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
            
            // 获取app的名字
            NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
            // 获取相册的唯一标识符
            createCollectionID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:appName].placeholderForCreatedAssetCollection.localIdentifier;
            
        } error:&error];
        
        if (error) {
            // 创建相册失败
            NSLog(@"创建相册失败");
            return nil;
        }else{
            
            // 根据唯一标识符获得刚才创建的相册
            appCollection = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createCollectionID] options:nil].firstObject;
            // 创建相册成功
        }
    }
    
    // 相册一定存在
    return appCollection;
}

#pragma mark 2、返回到保存到相机的图片
+(PHFetchResult <PHAsset *> *)createAssets:(UIImage *)saveImage{
    
    // 同步操作保存到 【相机胶卷】
    
    __block NSString *assetID = nil;
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        
        assetID = [PHAssetChangeRequest creationRequestForAssetFromImage:saveImage].placeholderForCreatedAsset.localIdentifier;
        
    } error:&error];
    
    if (error) {
        return nil;
    }
    
    // 获取相片
    PHFetchResult<PHAsset *> *createAssets = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil];
    
    return createAssets;
}

#pragma mark 3.1、保存图片到自定义的相册(上下两个方法都可以)
+(void)savePhotosToAppPhotoCollection:(UIImage *)saveImage{
    
    // 请求或者访问用户访问权限：
    // 如果还没有做出选择，会自动弹框，用户对弹框做出选择后才会调用block；
    // 如果用户之前已经做出过选择，会自动执行block
    /**
     PHAuthorizationStatusNotDetermined = 0,还没决定
     PHAuthorizationStatusRestricted = 1,没有授权，不能访问用户相册
     PHAuthorizationStatusDenied = 2,用户拒绝这个应用
     PHAuthorizationStatusAuthorized = 3 用户授权这个app访问这个相册
     */
    // 获取用户之前的状态
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // 用户决绝当前 App 访问相册
            if (status == PHAuthorizationStatusDenied) {
                
                if (oldStatus != PHAuthorizationStatusDenied) {
                    
                    // 不是第一次：提醒用户打开开关
                    
                }else{
                    // 第一次拒绝
                    
                }
                
            }else if (status == PHAuthorizationStatusAuthorized){
                // 用户允许当前 App 访问相册
                [self trueSaveImageToAppPhotoCollection:saveImage];
                
            }else if (status == PHAuthorizationStatusRestricted){
                // 因系统原因无法访问相册
                [SVProgressHUD showErrorWithStatus:@"因系统原因无法访问相册"];
            }
        });
    }];
}

+(void)trueSaveImageToAppPhotoCollection:(UIImage *)saveImage{
    
    // 获取相片
    PHFetchResult<PHAsset *> *createAssets = [self createAssets:saveImage];
    
    if (createAssets == nil) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败"];
    }
    
    // 获得自定义相册
    PHAssetCollection *createCollection = [self createPHAssetCollection];
    if (createCollection == nil) {
    
        [SVProgressHUD showErrorWithStatus:@"创建相册失败"];
    }
    
    NSError *error = nil;
    // 添加刚才保存的图片到 【自定义相册】
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 获取自定义对象的操作对象
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createCollection];
        // 把图片插入到自定义相册的第一个位置
        [request insertAssets:createAssets atIndexes:[NSIndexSet indexSetWithIndex:0]];
        
    } error:&error];
    
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存图片成功"];
    }
}

#pragma mark 3.2、保存图片到自定义的相册
+(NSString *)savePhotosToAppPhotoCollection2:(UIImage *)saveImage{
    
    // 同步操作保存到 【相机胶卷】
    
    __block PHObjectPlaceholder *placeholderForCreatedAsset;
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        
        placeholderForCreatedAsset = [PHAssetChangeRequest creationRequestForAssetFromImage:saveImage].placeholderForCreatedAsset;
        
    } error:&error];
    
    if (error) {
        return @"保存图片失败";
    }
    
    // 获得自定义相册
    PHAssetCollection *createCollection = [self createPHAssetCollection];
    if (createCollection == nil) {
        
        return @"创建相册失败";
    }
    
    // 添加刚才保存的图片到 【自定义相册】
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 获取自定义对象的操作对象
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createCollection];
        // 把图片插入到自定义相册的第一个位置
        [request insertAssets:@[placeholderForCreatedAsset] atIndexes:[NSIndexSet indexSetWithIndex:0]];
        
    } error:&error];
    
    if (error) {
        return @"保存图片失败";
    }else{
        return @"保存图片成功";
    }
}

#pragma mark 3、保存图片到 相机胶卷相册(单纯的保存图片到相册)
+(void)savePhotosToCameraRollPhotoCollection:(UIImage *)saveImage{
    
    // 请求或者访问用户访问权限：
    // 如果还没有做出选择，会自动弹框，用户对弹框做出选择后才会调用block；
    // 如果用户之前已经做出过选择，会自动执行block
    /**
     PHAuthorizationStatusNotDetermined = 0,还没决定
     PHAuthorizationStatusRestricted = 1,没有授权，不能访问用户相册
     PHAuthorizationStatusDenied = 2,用户拒绝这个应用
     PHAuthorizationStatusAuthorized = 3 用户授权这个app访问这个相册
     */
    // 获取用户之前的状态
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // 用户决绝当前 App 访问相册
            if (status == PHAuthorizationStatusDenied) {
                
                if (oldStatus != PHAuthorizationStatusDenied) {
                    
                    // 不是第一次：提醒用户打开开关
                    
                }else{
                    // 第一次拒绝
                    
                }
                
            }else if (status == PHAuthorizationStatusAuthorized){
                // 用户允许当前 App 访问相册
                // 同步操作保存到相册
                
                NSError *error = nil;
                
                [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
                    
                    [PHAssetChangeRequest creationRequestForAssetFromImage:saveImage];
                    
                } error:&error];
                
                if (error) {
                    [SVProgressHUD showErrorWithStatus:@"保存失败"];
                }else{
                    [SVProgressHUD showSuccessWithStatus:@"保存成功"];
                }
                
            }else if (status == PHAuthorizationStatusRestricted){
                // 因系统原因无法访问相册
                [SVProgressHUD showErrorWithStatus:@"因系统原因无法访问相册"];
            }
        });
    }];
}

@end
