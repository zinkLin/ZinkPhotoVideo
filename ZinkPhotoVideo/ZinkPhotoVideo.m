//
//  PhotoCameraManager.m
//  FJLottery
//
//  Created by ganld on 15/6/8星期一.
//  Copyright (c) 2015年 FuJu Technology Co.,Ltd. All rights reserved.
//

#import "ZinkPhotoVideo.h"
#import "ZinkAlertActionSheet.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ZinkPhotoVideo()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>
@property (weak, nonatomic) UIViewController *controller;
@property(nonatomic, copy) void(^completeBlock)(UIImage *image, NSURL *url);
@property(nonatomic, copy) void(^cancelBlock)();
@end

@implementation ZinkPhotoVideo
+ (id)shareInstance {
    static ZinkPhotoVideo *manager;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [ZinkPhotoVideo new];
    });
    
    return manager;
}

/**********************************************图片**********************************************/
/**
 *  调用相机获取图片
 */
+ (void)zinkShowPhotoFromCameraInController:(UIViewController *)viewController
                                 finish:(void(^)(UIImage * image))finish
                                 cancel:(void(^)())cancel {
    [[ZinkPhotoVideo shareInstance] showResultInController:viewController
                            type:UIImagePickerControllerSourceTypeCamera
                       mediaType:(NSString *)kUTTypeImage
                          finish:^(UIImage *image, NSURL *url) {
                              finish(image);
                          } cancel:cancel];
}

/**
 *  从相册获取图片
 */
+ (void)zinkShowPhotoFromLibraryInController:(UIViewController *)viewController
                                  finish:(void(^)(UIImage * image))finish
                                  cancel:(void(^)())cancel {
    [[ZinkPhotoVideo shareInstance] showResultInController:viewController
                            type:UIImagePickerControllerSourceTypeSavedPhotosAlbum
                       mediaType:(NSString *)kUTTypeImage
                          finish:^(UIImage *image, NSURL *url) {
                              finish(image);
                          } cancel:cancel];
}
/**
 *  用户自主选择获取图片
 */
+ (void)zinkShowPhotoWithActionSheetInController:(UIViewController *)vc
                                    complete:(void(^)(UIImage *image))completeBlock
                                      cancel:(void(^)())cancelBlock {
    __weak typeof(self) weakSelf = self;
    [ZinkAlertActionSheet zinkActionSheetShowInView:vc.view
                                          withTitle:@"请选择图片来源"
                                            message:nil
                                       cancelButton:@"取消"
                                       otherButtons:@[@"相册", @"拍摄"]
                                           callBack:^(NSInteger index) {
                                               if (index == 1) {
                                                   [weakSelf zinkShowPhotoFromLibraryInController:vc finish:completeBlock cancel:cancelBlock];
                                               } else if (index == 2) {
                                                   [weakSelf zinkShowPhotoFromCameraInController:vc finish:completeBlock cancel:cancelBlock];
                                               }
                                           }];
}

/**********************************************视频**********************************************/
/**
 *  调用相机获取视频
 */
+ (void)zinkShowVideoFromCameraInController:(UIViewController *)viewController
                                 finish:(void(^)(NSURL *url))finish
                                 cancel:(void(^)())cancel {
    [[ZinkPhotoVideo shareInstance] showResultInController:viewController
                            type:UIImagePickerControllerSourceTypeCamera
                       mediaType:(NSString *)kUTTypeMovie
                          finish:^(UIImage *image, NSURL *url) {
                              finish(url);
                          } cancel:cancel];
}
/**
 *  从相册获取视频
 */
+ (void)zinkShowVideoFromLibraryInController:(UIViewController *)viewController
                                  finish:(void(^)(NSURL *url))finish
                                  cancel:(void(^)())cancel {
    [[ZinkPhotoVideo shareInstance] showResultInController:viewController
                            type:UIImagePickerControllerSourceTypeSavedPhotosAlbum
                       mediaType:(NSString *)kUTTypeMovie
                          finish:^(UIImage *image, NSURL *url) {
                              finish(url);
                          } cancel:cancel];
}
/**
 *  用户自主选择获取视频
 */
+ (void)zinkShowVideoWithActionSheetInController:(UIViewController *)vc
                                    complete:(void(^)(NSURL *url))completeBlock
                                      cancel:(void(^)())cancelBlock {
    __weak typeof(self) weakSelf = self;
    [ZinkAlertActionSheet zinkActionSheetShowInView:vc.view
                                          withTitle:@"请选择视频来源"
                                            message:nil
                                       cancelButton:@"取消"
                                       otherButtons:@[@"相册", @"拍摄"]
                                           callBack:^(NSInteger index) {
                                               if (index == 1) {
                                                   [weakSelf zinkShowVideoFromLibraryInController:vc finish:completeBlock cancel:cancelBlock];
                                               } else if (index == 2) {
                                                   [weakSelf zinkShowVideoFromCameraInController:vc finish:completeBlock cancel:cancelBlock];
                                               }
                                           }];
}

/********************************************************************************************/
- (void)showResultInController:(UIViewController *)viewController
                          type:(UIImagePickerControllerSourceType)type
                     mediaType:(NSString *)mediaType
                        finish:(void(^)(UIImage * image, NSURL *url))finish
                        cancel:(void(^)())cancel {
    if (![UIImagePickerController isSourceTypeAvailable: type]) {
        return;
    }
    
    self.completeBlock = finish;
    self.cancelBlock = cancel;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = NO;//设置可编辑
    picker.sourceType = type;
    
    /**
     *  显示类型: kUTTypeImage 照片， kUTTypeMovie 视频，
     */
    picker.mediaTypes = @[mediaType];
    [viewController presentViewController:picker animated:YES completion:nil];
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
    
    [picker dismissViewControllerAnimated:NO completion:^{
        self.completeBlock(image, url);
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:NO completion:^{
        self.cancelBlock();
    }];
}


@end
