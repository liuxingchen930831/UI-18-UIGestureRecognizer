//
//  ViewController.m
//  手势识别介绍
//
//  Created by liuxingchen on 16/10/19.
//  Copyright © 2016年 liuxingchen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //如果想让一个控件添加多个手势需要实现代理
    [self setupRotation];
    [self setupPinch];
    [self setupPan];
}
#pragma  makr - 代理
//是否允许开始触发手势
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    return YES;
//}

// 是否允许同时支持多个手势，默认是不支持多个手势
// 返回yes表示支持多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
// 是否允许接收手指的触摸点
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    // 获取当前的触摸点
//    CGPoint curP = [touch locationInView:self.imageView];
//
//    if (curP.x < self.imageView.bounds.size.width * 0.5) {
//        return NO;
//    }else{
//        return YES;
//    }
//}
#pragma mark - 点按手势
-(void)setupTap
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.imageView addGestureRecognizer:tap];
}
-(void)tap:(UITapGestureRecognizer *) tap
{
    NSLog(@"%s, line = %d",__FUNCTION__,__LINE__);
}

#pragma mark - 长按手势
//创建长按手势默认会触发两次
-(void)setupLongPress
{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [self.imageView addGestureRecognizer:longPress];
}
-(void)longPress:(UILongPressGestureRecognizer *)longPress
{
    //一般情况下长按手势需要判断长按的状态来处理逻辑
    if (longPress.state == UIGestureRecognizerStateBegan) {
        NSLog(@"%s, line = %d",__FUNCTION__,__LINE__);
    }
}
#pragma mark - 轻扫
-(void)setupSwipe
{
    //注意:默认的轻扫手势是向右
    UISwipeGestureRecognizer *swpie = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    [self.imageView addGestureRecognizer:swpie];
    
    // 如果以后想要一个控件支持多个方向的轻扫，必须创建多个轻扫手势，一个轻扫手势只支持一个方向
    // 默认轻扫的方向是往右
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    
    [self.imageView addGestureRecognizer:swipeDown];
}
-(void)swipe:(UISwipeGestureRecognizer *)swipe
{
    NSLog(@"swipe = %@",swipe);
}
#pragma mark - 旋转手势
-(void)setupRotation
{
    UIRotationGestureRecognizer *rotataion = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotation:)];
    [self.imageView addGestureRecognizer:rotataion];
}
//传递的旋转角度默认是都是相对于最开始的位置
-(void)rotation:(UIRotationGestureRecognizer *)rotation
{
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, rotation.rotation);
    
    // 复位 如果不想复位就用 self.imageView.transform = CGAffineTransformMakeRotation(rotation.rotation);
    rotation.rotation = 0;
    NSLog(@"%f",rotation.rotation);
}
#pragma mark - 捏合
-(void)setupPinch
{
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
    [self.imageView addGestureRecognizer:pinch];
}
-(void)pinch:(UIPinchGestureRecognizer *)pinch
{
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, pinch.scale, pinch.scale);
    // 复位 如果不想复位就用 self.imageView.transform = CGAffineTransformMakeScale(pinch.scale);
    pinch.scale = 1;
    
}
#pragma  mark - 拖拽
-(void)setupPan
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.imageView addGestureRecognizer:pan];
}
-(void)pan:(UIPanGestureRecognizer *)pan
{
    //获取当前手势的触摸点
//    CGPoint curPoint = [pan locationInView:self.imageView];
    //获取手势的移动，也就是相对于最开始的位置
    CGPoint transPoin = [pan translationInView:self.imageView];
    
    self.imageView.transform = CGAffineTransformTranslate(self.imageView.transform, transPoin.x, transPoin.y);
    //复位
    [pan setTranslation:CGPointZero inView:self.imageView];
}
@end
