//
//  Const.h
//  QzoneUp
//
//  Created by melon on 2017/12/22.
//  Copyright © 2017年 melon. All rights reserved.
//

UIKIT_EXTERN CGFloat  const           kShowErrorMessageTime;
UIKIT_EXTERN NSInteger const           UAID;//应用唯一标识
UIKIT_EXTERN NSInteger const            Platform;//接口标识
UIKIT_EXTERN NSInteger const            APPStoreID;//商店ID
UIKIT_EXTERN NSString * const            marketPosition;//市场定位
UIKIT_EXTERN NSString * const            kAwardKey;//奖励Key
UIKIT_EXTERN NSString * const            kExclusiveSerNameKey;//专属客服名字key
UIKIT_EXTERN NSString * const            kExclusiveSerAccountKey;//专属客服账户key
UIKIT_EXTERN NSString * const            kExclusiveSerIsPopKey;//专属客服pop key
UIKIT_EXTERN NSString * const            kWeChatGZHKey;//微信公众 key
UIKIT_EXTERN NSString * const            kCoursesUrlKey;//获取教程的链接 key
UIKIT_EXTERN NSString * const           kHaveOrderKey;//是否有下过单
UIKIT_EXTERN NSString * const           kIsReviewKey;//审核开关
/*
支付码表
 */
typedef NS_ENUM(NSInteger, PAYMENT_LIST){
    PAYMENT_LIST_HFT = 1,   //71话付通
    PAYMENT_LIST_YouPay= 2,   //YouPay支付
    PAYMENT_LIST_TianYi = 3,   //TianYi天易支付
    PAYMENT_LIST_Apple = 4,   //苹果原生支付
    PAYMENT_LIST_WeChat = 5,   //微信原生支付
    PAYMENT_LIST_ShuKeBao = 6,   //数科宝支付
    PAYMENT_LIST_TianXia = 7,   //天下支付
    PAYMENT_LIST_Ali = 8,   //支付宝原生支付
    PAYMENT_LIST_MaYun = 9,   //码云支付
    PAYMENT_LIST_LingQian = 10,   //零钱支付
    PAYMENT_LIST_ChongFu = 11,   //聪付支付
    PAYMENT_LIST_TongLian = 12, //通联支付
    PAYMENT_LIST_KaiLianTong = 13, //开联通支付
    PAYMENT_LIST_ZhiQianBao = 14, //智钱宝支付
};
/*
 奖励码表
 */
typedef NS_ENUM(NSInteger, AWARD_LIST){
    AWARD_LIST_Group = 0,   //加群
    AWARD_LIST_Sign = 1,   //每日签到
    AWARD_LIST_LikeWeChat = 2,   //关注微信公众号
    AWARD_LIST_Share = 3,   //分享成功
    AWARD_LIST_Evaluation = 4,   //市场好评
    AWARD_LIST_TotalRecharge = 5,   //累计充值
    AWARD_LIST_FoundAward = 6,   //领取返回奖励(基金卡)
    AWARD_LIST_PushTop = 7,   //小程序添加到桌面或置顶聊天
    AWARD_LIST_ConvertCode = 8,   //兑换码奖励
    AWARD_LIST_LimitActivity = 9,   //限购活动
    AWARD_LIST_SeriesActivity = 10,   //系列活动
    AWARD_LIST_FirstActivity = 11,   //首冲活动
    AWARD_LIST_Register = 12,   //注册奖励
    AWARD_LIST_BindPhone = 13,   //绑定手机送积分
    AWARD_LIST_PhoneRegister = 14,   //手机注册送积分
};
/*
 Banner分类码表
 */
typedef NS_ENUM(NSInteger, BANNER_LIST){
    BANNER_LIST_Other = 0,   //其他
    BANNER_LIST_Apk = 1,   //apk
    BANNER_LIST_Web = 2,   //网页
    BANNER_LIST_Controller = 3,   //界面
    BANNER_LIST_AppStore = 4 , //appstore
};
/*
 服务标签码表
 */
typedef NS_ENUM(NSInteger, TAG_LIST){
    TAG_LIST_Other = 0,   //其他
    TAG_LIST_Free = 1,   //免费
    TAG_LIST_Hot = 2,   //热门
    TAG_LIST_Discounting = 3,   //打折
    TAG_LIST_New = 4,   //新品
};


/*
 服务行为码表
 */
typedef NS_ENUM(NSInteger, BEHAVIOR_LIST){
    BEHAVIOR_LIST_Maintaining = 0,   //维护中
    BEHAVIOR_LIST_NormalServices = 1,   //常规服务
    BEHAVIOR_LIST_VIPServices = 2,   //VIP服务
    BEHAVIOR_LIST_TimeLimitVIPServices = 3,   //限时VIP服务
};
/*
 VIP类别
 */
typedef NS_ENUM(NSInteger, VIP_TYPE){
    VIP_TYPE_Nothing = 0,   //无
    VIP_TYPE_OneMonth = 1,   //一个月
    VIP_TYPE_Quarter = 2,   //三个月
    VIP_TYPE_HalfAYear = 3,   //六个月
    VIP_TYPE_OneYear = 4,   //十二个月
};
/*
 跑马灯商品码表
 */
typedef NS_ENUM(NSInteger, GOOD_LIST){
    GOOD_LIST_Nothing = 0,   //无
    GOOD_LIST_BuyPoint = 1,   //购买积分
    GOOD_LIST_BuyVip = 2,   //充值VIP
    GOOD_LIST_FirstRecharge = 3,   //首次充值  弃用，改为首冲活动
    GOOD_LIST_Found = 4,   //活动商品(基金卡)
    GOOD_LIST_LimitGood = 5,   //限购商品
    GOOD_LIST_LimitActivity = 9,   //限购活动
    GOOD_LIST_SeriesActivity = 10,   //系列活动
    GOOD_LIST_FirstRechargeActivity = 11,   //首冲活动
};


/*
 服务码表
 */
typedef NS_ENUM(NSInteger, SERVICE_LIST){
    SERVICE_LIST_Nothing = 0,   //无
    SERVICE_LIST_QzoneMingPin = 1,   //空间名片赞
    SERVICE_LIST_QzoneShuoShuo = 2,   //说说点赞
    SERVICE_LIST_QzoneFangWen = 3,   //空间访问量
    SERVICE_LIST_QzoneShuoShuoLiuLan = 4,   //说说浏览量
    SERVICE_LIST_QzoneLiuYan = 5,   //空间留言
    SERVICE_LIST_Autograph = 6,   //签名
    SERVICE_LIST_NickName = 7,   //网名
    SERVICE_LIST_HeadPortrait = 8,   //头像
    SERVICE_LIST_QzoneZhuYe = 9,   //空间主页赞
    SERVICE_LIST_KwaiShuangJi = 20,   //快手双击
    SERVICE_LIST_KwaiFans = 21,   //快手粉丝
    SERVICE_LIST_KwaiBoFangLiang = 22,   //快手播放量
    SERVICE_LIST_KwaiPingLun = 23,   //快手评论
    SERVICE_LIST_KwaiZhiBoDianLiang = 24,   //快手直播点亮
    SERVICE_LIST_KmusicFans = 30,   //全民K歌粉丝
    SERVICE_LIST_KmusicPingLun = 31,   //全民K歌评论
    SERVICE_LIST_KmusicShiTingLiang = 32,   //全民K歌试听量
    SERVICE_LIST_KmusicXianHua = 33,   //全民K歌鲜花
    SERVICE_LIST_DouyinFans = 40,   //抖音粉丝
    SERVICE_LIST_DouyinBoFangLiang = 41,   //抖音播放量
    SERVICE_LIST_DouyinShuangJi = 42,   //抖音双击
    SERVICE_LIST_DouyinPingLun = 43,   //抖音评论
    SERVICE_LIST_DouyinShare = 44,   //抖音分享
};

/*
 活动码表
 */
typedef NS_ENUM(NSInteger, CAMPAIGN_CATEGORY_LIST){
    CAMPAIGN_CATEGORY_LIST_RechargeList = 1,   //冲榜类活动
    CAMPAIGN_CATEGORY_LIST_FirstRecharge = 2,   //礼包活动
    CAMPAIGN_CATEGORY_LIST_TimeLimit = 3,   //限购活动
    CAMPAIGN_CATEGORY_LIST_CumulationSign = 4,   //累计签到活动
    CAMPAIGN_CATEGORY_LIST_ContinuitySign = 5,   //连续签到活动
//    CAMPAIGN_CATEGORY_LIST_CumulationSign = 6,   //累计签到活动
    CAMPAIGN_CATEGORY_LIST_ExchangeClass = 7,   //兑换类活动
    CAMPAIGN_CATEGORY_LIST_Template = 8,   //系列活动
    CAMPAIGN_CATEGORY_LIST_Fund = 9,   //基金活动
};

/*
 卡盟订单状态
 */
typedef NS_ENUM(NSInteger, KAMENG_STATUS_LIST){
    KAMENG_STATUS_LIST_RepeatOrderCanReturnScore = -9,   //重复订单，排队中(可退积分)
    KAMENG_STATUS_LIST_PermissionError = -8,   //订单权限不正确
    KAMENG_STATUS_LIST_RepeatOrder = -7,   //重复订单
    KAMENG_STATUS_LIST_InputError = -6,   //填写错误
    KAMENG_STATUS_LIST_NotLogged = -5,   //未登录
    KAMENG_STATUS_LIST_ManuallyClosingSubmission = -4,   //手动关闭提交
    KAMENG_STATUS_LIST_NetworkError = -3,   //网络问题
    KAMENG_STATUS_LIST_SubmissionError = -2,   //提交失败
    KAMENG_STATUS_LIST_NotEnoughKami = -1,   //卡密不足
    KAMENG_STATUS_LIST_Ready = 0,   //准备中
    KAMENG_STATUS_LIST_Starting = 1,   //进行中
    KAMENG_STATUS_LIST_Complete = 2,   //已经完成
    KAMENG_STATUS_LIST_DeductScoreError = 3,   //卡商提交成功,扣除积分失败
    KAMENG_STATUS_LIST_ManualServiceReturnScore = 4,   //人工服务退积分
    KAMENG_STATUS_LIST_ReturnedScore = 5,   //已退积分
};


/**
 套餐码表
 */
typedef NS_ENUM(NSInteger,COMBO_CATEGORY_LIST){
    COMBO_CATEGORY_LIST_kwai = 1,   //快手套餐
    COMBO_CATEGORY_LIST_kMusic = 2,  //K歌套餐
};

/**
 订单码表
 */
typedef NS_ENUM(NSInteger,ORDER_STATUS_LIST){
    ORDER_STATUS_LIST_NotPay = 1, //未支付
    ORDER_STATUS_LIST_Payed = 2, //已支付
    ORDER_STATUS_LIST_PayedError = 3, //已支付,不统计支付
    ORDER_STATUS_LIST_PriceError = 4, //异步通知价格错误
    ORDER_STATUS_LIST_ApplyRefund = 5, //申请退款
    ORDER_STATUS_LIST_Refunded = 6, //已退款
    ORDER_STATUS_LIST_AcceptRefund = 7, //同意退款
};

/**
 支付流程码表
 */
typedef NS_ENUM(NSInteger,PAY_FLOW_LIST){
    PAY_FLOW_LIST_NoRequest = 1, //不用再次请求支付地址
    PAY_FLOW_LIST_ContinueRequest = 2, //继续请求支付地址
};

/**
 消息触发条件码表
 */
typedef NS_ENUM(NSInteger,CONDITION_LIST){
    CONDITION_LIST_Unconditional = 0, //无条件触发
    CONDITION_LIST_RechargeMoney = 1, //充值金额达到时触发
    CONDITION_LIST_SignDay = 2, //签到总天数达到时触发
    CONDITION_LIST_AppointUser = 3,//指定用户触发
};


//======================================统计点击事件===========================================
UIKIT_EXTERN NSString *  const MainSign;//首页-签到
UIKIT_EXTERN NSString *  const MainAvatar;//首页-头像
UIKIT_EXTERN NSString *  const MainBuyScore;//首页-购买积分
UIKIT_EXTERN NSString *  const MainRefund;//首页-退款
UIKIT_EXTERN NSString *  const MainSingleActivity;//首页-活动
UIKIT_EXTERN NSString *  const MainMessage;//首页-消息通知列表
UIKIT_EXTERN NSString *  const KSPackage;//快手套餐
UIKIT_EXTERN NSString *  const KGPackage;//K歌套餐

UIKIT_EXTERN NSString *  const MainCategory;//商品-XX（每个商品单独埋点)
UIKIT_EXTERN NSString *  const KaShangSubmit;//提交订单-XX（每个商品单独埋点）
UIKIT_EXTERN NSString *  const KaShangHelp;//帮助说明按钮-快手XX
/*                     空间系列                   */
UIKIT_EXTERN NSString *  const Qmingpianzan;//名片赞
UIKIT_EXTERN NSString *  const Qshuoshuozan;//说说赞
UIKIT_EXTERN NSString *  const Qzhuyezan;//空间主页赞
UIKIT_EXTERN NSString *  const Qliuyan;//空间留言
UIKIT_EXTERN NSString *  const Qshuoshuoliuyan;//说说浏览量
UIKIT_EXTERN NSString *  const QzoneLiulang;//空间访问量

/*                     快手系列                   */
UIKIT_EXTERN NSString *  const Kfensi;//快手粉丝
UIKIT_EXTERN NSString *  const Kbofangliang;//快手播放量
UIKIT_EXTERN NSString *  const Kshuangji;//快手双击
UIKIT_EXTERN NSString *  const Kpinglun;//快手评论
UIKIT_EXTERN NSString *  const Kdianliang;//快手直播点亮

/*                     快手系列                   */
UIKIT_EXTERN NSString *  const Kgfensi;//全民K歌粉丝
UIKIT_EXTERN NSString *  const Kgpinglun;//全民K歌评论
UIKIT_EXTERN NSString *  const Kgshitingliang;//全民K歌试听量
UIKIT_EXTERN NSString *  const Kgxianhua;//全民K歌鲜花

/*                     抖音系列                   */
UIKIT_EXTERN NSString *  const Dfensi;//抖音粉丝
UIKIT_EXTERN NSString *  const Dbofangliang;//抖音播放量
UIKIT_EXTERN NSString *  const Dshuangji;//抖音双击
UIKIT_EXTERN NSString *  const Dpinglun;//抖音评论

/*                     福利活动相关                   */
UIKIT_EXTERN NSString *  const ActivityFirst;//首冲
UIKIT_EXTERN NSString *  const ActivityPai;//排行榜
UIKIT_EXTERN NSString *  const ActivityLimit;//限购礼包
UIKIT_EXTERN NSString *  const ActivityXiLie;//系列活动
UIKIT_EXTERN NSString *  const ActivityJiJin;//基金活动

/*                      订单相关                    */
UIKIT_EXTERN NSString *  const OrderJinXing;//进行中
UIKIT_EXTERN NSString *  const OrderFinish;//已完成
UIKIT_EXTERN NSString *  const OrderRecord;//积分记录

/*                      个人中心相关                    */
UIKIT_EXTERN NSString *  const PersonSign;//个人中心-签到
UIKIT_EXTERN NSString *  const PersonAvatar;//个人中心-头像
UIKIT_EXTERN NSString *  const PersonBuyScore;//个人中心-购买积分
UIKIT_EXTERN NSString *  const PersonFundCard;//个人中心-我的基金卡
UIKIT_EXTERN NSString *  const PersonVIP;//个人中心-购买VIP
UIKIT_EXTERN NSString *  const PersonPaiHangBang;//个人中心-排行榜
UIKIT_EXTERN NSString *  const PersonTouSu;//个人中心-我要投诉
UIKIT_EXTERN NSString *  const PersonTouSuQQqun;//个人中心-我要投诉-QQ群
UIKIT_EXTERN NSString *  const PersonTouSuCall;//个人中心-我要投诉-电话
UIKIT_EXTERN NSString *  const PersonAboutUS;//个人中心-关于我们
UIKIT_EXTERN NSString *  const PersonRefund;//个人中心-我要退款
UIKIT_EXTERN NSString *  const PersonGetScore;//个人中心-赚取积分
UIKIT_EXTERN NSString *  const PersonGetScoreSign;//个人中心-赚取积分-今日签到
UIKIT_EXTERN NSString *  const PersonGetScoreGzh;//个人中心-赚取积分-关注公众号
UIKIT_EXTERN NSString *  const PersonGetScoreHaoping;//个人中心-赚取积分-五星好评
UIKIT_EXTERN NSString *  const PersonGetScoreShare;//个人中心-赚取积分-分享好友
UIKIT_EXTERN NSString *  const PersonGetScoreQQqun;//个人中心-赚取积分-获取福利/加入QQ群
UIKIT_EXTERN NSString *  const PersonXieYi;//个人中心-协议
UIKIT_EXTERN NSString *  const PersonOrder;//个人中心-订单记录
UIKIT_EXTERN NSString *  const PersonBindPhone;//个人中心绑定手机

/*                     支付相关                    */
UIKIT_EXTERN NSString *  const PayWX;//微信
UIKIT_EXTERN NSString *  const PayALI;//支付宝
UIKIT_EXTERN NSString *  const PayQQ;//QQ支付

/*                     底部TAB相关                    */
UIKIT_EXTERN NSString *  const MainBottomFensi;//底部TAB-刷粉丝/推荐
UIKIT_EXTERN NSString *  const MainBottomActivity;//底部TAB-活动福利
UIKIT_EXTERN NSString *  const MainBottomOrder;//底部TAB-订单
UIKIT_EXTERN NSString *  const MainBottomPerson;//底部TAB-个人中心
UIKIT_EXTERN NSString *  const MainBottomRed;//底部TAB-红人必备
UIKIT_EXTERN NSString *  const QiYu;//七鱼客服

/*                     登录相关                    */
UIKIT_EXTERN NSString *  const QQLogin;//QQ登录
UIKIT_EXTERN NSString *  const WXLogin;//微信登录
UIKIT_EXTERN NSString *  const CodeLogin;//手机验证码登录

/*                     支付价格相关                    */
UIKIT_EXTERN NSString *  const PayVIPNumber;//购买VIP
UIKIT_EXTERN NSString *  const PayNormalScoreNumber;//正常购买积分
UIKIT_EXTERN NSString *  const PayNotEnoughScoreNumber;//积分不足购买
UIKIT_EXTERN NSString *  const PayFirstNumber;//首充
UIKIT_EXTERN NSString *  const PayLimitNumber;//限购礼包
UIKIT_EXTERN NSString *  const PayXiLieNumber;//系列活动
UIKIT_EXTERN NSString *  const PayJiJinNumber;//基金活动
//========================================统计点击事件=========================================
