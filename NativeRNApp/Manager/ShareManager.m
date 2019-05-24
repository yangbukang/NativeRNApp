//
//  ShareManager.m
//  MiAiApp
//
//  Created by Mxy on 2017/6/1.
//  Copyright © 2017年 Mxy. All rights reserved.
//

#import "ShareManager.h"
#import <UShareUI/UShareUI.h>

@implementation ShareManager

SINGLETON_FOR_CLASS(ShareManager);
#define KShareCacheName @"KShareCacheName"
#define KShareDicCache @"KShareDicCache"
- init {
    if ((self = [super init])) {
        
        YYCache *yyCache = [YYCache cacheWithName:KShareCacheName];
        self.shareDic = (NSDictionary *)[yyCache objectForKey:KShareDicCache];
        if (!_shareDic) {
            self.shareDic = [NSDictionary dictionaryWithObjectsAndKeys:@"消费金融 信用生活",@"share_title", @"邀请好友得3000元免息券 多邀多得",@"share_panel_txt",[NSString stringWithFormat:@"%@购买即得现金大红包，邀请好友得免息劵",kAppName],@"share_content",@"邀请1人 送20元免息券",@"share_btn_txt",[NSString stringWithFormat:@"%@/wap/system/inviteregister?invitecode=aW52aXRlY29kZTIxMQ==",kWebHostName],@"share_url",nil];
        }

      
        
    }
    return self;
}

-(void)showShareView{
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [self shareWebPageToPlatformType:platformType];
    }];
}

- (void)showShareCustomView {
    NSString *title = self.shareDic[@"share_panel_txt"];
    [self showShareCustomView:YES title:title];
}

- (void)showShareCustomView:(BOOL)animated title:(NSString *) title{
    UIView *markView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    markView.tag = 501;
    
    markView.backgroundColor = RGBACOLOR(0, 0, 0, 0.6);
    [[UIApplication sharedApplication].keyWindow addSubview:markView];
    
    UIView *tipsView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight , KScreenWidth, 192)];
    tipsView.tag = 502;
    tipsView.backgroundColor = [UIColor whiteColor];// RGBCOLOR(246, 246, 246);
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, tipsView.width, 20)];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = CFontColor2;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.backgroundColor = [UIColor whiteColor];
    nameLabel.text = title;
    [tipsView addSubview:nameLabel];
    UILabel *nameLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, tipsView.width, 20)];
    nameLabel2.font = [UIFont systemFontOfSize:13];
    nameLabel2.textColor = CFontColor3;
    nameLabel2.textAlignment = NSTextAlignmentCenter;
    nameLabel2.backgroundColor = [UIColor whiteColor];
    nameLabel2.text = @"(好友首次分期成功即可获得)";
    [tipsView addSubview:nameLabel2];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(tipsView.width/2, 75, 1, 50)];
    lineLabel.backgroundColor = CLineColor;
    [tipsView addSubview:lineLabel];
   
    
    
    UIButton *wxSessionBut = [UIButton buttonWithType:UIButtonTypeCustom];
    wxSessionBut.frame = CGRectMake((tipsView.width/2 - 80)/2 + 20  ,37, 80,120);
    wxSessionBut.titleLabel.font = [UIFont systemFontOfSize:14];
    [wxSessionBut setTitle:@"微信好友" forState:UIControlStateNormal];
    [wxSessionBut setTitleColor:CFontColor2 forState:UIControlStateNormal];
    [wxSessionBut setImage:[UIImage imageNamed:@"icon_wx_friend"] forState:UIControlStateNormal];
    [wxSessionBut addTarget:self action:@selector(wxSessionClick:) forControlEvents:UIControlEventTouchUpInside];
    [self setButStyle:wxSessionBut left:-60.0 right:22];
    [tipsView addSubview:wxSessionBut];
    
    UIButton *wxTimeLineBut = [UIButton buttonWithType:UIButtonTypeCustom];
    wxTimeLineBut.frame = CGRectMake(tipsView.width/2 +(tipsView.width/2 - 65)/2 ,wxSessionBut.mj_y, 65,120);
    wxTimeLineBut.titleLabel.font = [UIFont systemFontOfSize:14];
    [wxTimeLineBut setTitle:@"朋友圈" forState:UIControlStateNormal];
    [wxTimeLineBut setTitleColor:CFontColor2 forState:UIControlStateNormal];
    [wxTimeLineBut setImage:[UIImage imageNamed:@"icon_wx_timeline"] forState:UIControlStateNormal];
    [wxTimeLineBut addTarget:self action:@selector(wxTimeLineClick:) forControlEvents:UIControlEventTouchUpInside];
    [self setButStyle:wxTimeLineBut left:-36.0 right:15.0];
    [tipsView addSubview:wxTimeLineBut];

    
    UIButton *cancelBut = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBut.frame = CGRectMake(0,tipsView.height - 45, tipsView.width,45);
    cancelBut.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelBut setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBut setTitleColor:CFontColor1 forState:UIControlStateNormal];
    [cancelBut setBackgroundImage:[UIImage imageWithColor:RGBCOLOR(246, 246, 246)]forState:UIControlStateNormal];
    [cancelBut setBackgroundImage:[UIImage imageWithColor:RGBACOLOR(239, 239, 239,0.7)] forState:UIControlStateHighlighted];
    [cancelBut addTarget:self action:@selector(closeShareCustomView) forControlEvents:UIControlEventTouchUpInside];
    [tipsView addSubview:cancelBut];
    
    [markView addSubview:tipsView];
    [UIView animateWithDuration:0.5 animations:^{
        tipsView.mj_y = KScreenHeight -  tipsView.height;
    }completion:^(BOOL finished){
        
    }];
}

- (void)setButStyle:(UIButton *)but left:(CGFloat)left right:(CGFloat)right{
    //CGFloat imageW = but.imageView.frame.size.width;
    CGFloat imageH = but.imageView.frame.size.height;

    //CGFloat titleW = but.titleLabel.frame.size.width;
    CGFloat titleH = but.titleLabel.frame.size.height;

    //图片上文字下
    [but setTitleEdgeInsets:UIEdgeInsetsMake(0, left, -imageH - 10,right)];//{top, left, bottom, right};
    [but setImageEdgeInsets:UIEdgeInsetsMake(-titleH, 0.f, 0.f,0)];
//    
//        //but.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
//        CGFloat w = but.imageView.frame.size.width;
//        CGFloat h = 40;//wxTimeLineBut.imageView.frame.size.height;
//        [but setTitleEdgeInsets:UIEdgeInsetsMake(h ,-w, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
//        [but setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0,0.0, -w)];//图片距离右边框距离减少图片的宽度，其它不边
}
- (void)closeShareCustomView{
    UIView *markView = [[UIApplication sharedApplication].keyWindow viewWithTag:501];
    UIView *tipsView = [markView viewWithTag:502];
    if (markView && tipsView) {
        [UIView animateWithDuration:0.5 animations:^{
            tipsView.mj_y = KScreenHeight ;
            markView.backgroundColor = [UIColor clearColor];
        }completion:^(BOOL finished){
            [markView removeFromSuperview];
        }];
    }
}

- (void)wxSessionClick:(id)sender{
    [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
    [self closeShareCustomView];
}
//朋友圈
- (void)wxTimeLineClick:(id)sender{
    [self shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
    [self closeShareCustomView];
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    //NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    NSString *title = self.shareDic[@"share_title"];
    NSString *content= self.shareDic[@"share_content"];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:content thumImage:[UIImage imageNamed:@"logo"]];
    //设置网页地址
    shareObject.webpageUrl = self.shareDic[@"share_url"];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        //[self alertWithError:error];
    }];
}

- (void)alertWithError:(NSError *)error
{
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"Share succeed"];
    }
    else{
        NSMutableString *str = [NSMutableString string];
        if (error.userInfo) {
            for (NSString *key in error.userInfo) {
                [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
            }
        }
        if (error) {
            result = [NSString stringWithFormat:@"Share fail with error code: %d\n%@",(int)error.code, str];
        }
        else{
            result = [NSString stringWithFormat:@"Share fail"];
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
                                          otherButtonTitles:nil];
    [alert show];
}


- (void)queryInviteinfoRequest {
    
    [PPNetworkHelper POST:@"index/getinviteinfo" parameters:[NSMutableDictionary new] success:^(NSDictionary *dicInfo, BOOL isSuccess, NSString *errorMessage) {
        if (isSuccess) {
            if (dicInfo) {
                self.shareDic = dicInfo;
                YYCache *yyCache = [YYCache cacheWithName:KShareCacheName];
                [yyCache setObject:dicInfo forKey:KShareDicCache];
            }
        }else{
        }
    } failure:^(NSError *error) {
    } ];
}

@end
