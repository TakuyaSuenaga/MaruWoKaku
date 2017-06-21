//
//  AdManager.m
//  Maru
//
//  Created by 末永 琢也 on 2014/02/04.
//  Copyright (c) 2014年 末永 琢也. All rights reserved.
//

#import "AdManager.h"

static AdManager *s_adManager;
static ADBannerView *s_adBannerView;

@implementation AdManager

+ (ADBannerView*)shardAdBannerView
{
    CGSize size = [UIScreen mainScreen].bounds.size;

    if (size.height <= 480) {
        return nil;
    }
    
    if (s_adBannerView == nil) {
        s_adManager = [[AdManager alloc] init];
        s_adBannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
        s_adBannerView.autoresizesSubviews = YES;
        s_adBannerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        s_adBannerView.frame = CGRectMake(0, size.height, size.width, 50);
        s_adBannerView.delegate = s_adManager;
        s_adBannerView.alpha = 1.f;
    }
    return s_adBannerView;
}

+ (void)removeAd
{
    [s_adBannerView removeFromSuperview];
    s_adBannerView.delegate = nil;
    s_adBannerView = nil;
    s_adManager = nil;
}

#pragma mark - AdBannerDelegate

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    [UIView animateWithDuration:0.3f animations:^{
        CGSize s = [UIScreen mainScreen].bounds.size;
        [banner setFrame:CGRectMake(0, s.height - 50, s.width, 50)];
    }];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"[ERROR] %@", NSStringFromiAdError(error));
    [UIView animateWithDuration:0.3f animations:^{
        CGSize s = [UIScreen mainScreen].bounds.size;
        [banner setFrame:CGRectMake(0, s.height, s.width, 50)];
    }];
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    return YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner;
{

}

NSString *NSStringFromiAdError(NSError *error)
{
    switch (error.code) {
        case 0:
            return @"ADErrorUnknown";
        case 1:
            return @"ADErrorServerFailure";
        case 2:
            return @"ADErrorLoadingThrottled";
        case 3:
            return @"ADErrorInventoryUnavailable";
        case 4:
            return @"ADErrorConfigurationError";
        case 5:
            return @"ADErrorBannerVisibleWithoutContent";
        case 6:
            return @"ADErrorApplicationInactive";
        default:
            return [NSString stringWithFormat:@"Unknown ADError.code[%ld]", (long)error.code];
    }
}

@end
