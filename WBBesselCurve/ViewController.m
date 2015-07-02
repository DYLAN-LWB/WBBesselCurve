//
//  ViewController.m
//  WBBesselCurve
//
//  Created by 李伟宾 on 15/6/23.
//  Copyright (c) 2015年 李伟宾. All rights reserved.
//

#import "ViewController.h"
#import "UIBezierPath+BesselCurve.h"
@interface ViewController (){
    
    UIBezierPath   *_curve;
    CAShapeLayer   *_shapeLayer;
    
    NSMutableArray *_actionArray;
    NSMutableArray *_pointArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // - 添加个x, y轴
    [self setUpFrameOfAxes];
    
    // - 贝塞尔曲线
    [self setUpBesslCurveWithMargin:self.view.frame.size.width * 0.1
                             beginY:self.view.frame.size.height * 0.5
                  contractionFactor:0.8];
    
    [self setUpBesslCurveWithMargin:self.view.frame.size.width * 0.1
                             beginY:self.view.frame.size.height * 0.9
                  contractionFactor:0.1];


}
- (void) setUpFrameOfAxes{
    CGFloat margin = self.view.frame.size.width * 0.1;
    CGFloat beginY = self.view.frame.size.height * 0.5;
    
    UIView *viewX = [[UIView alloc] initWithFrame:CGRectMake(margin - 10, beginY, margin*8, 0.5)];
    viewX.backgroundColor = [UIColor blackColor];
    [self.view addSubview:viewX];
    
    UIView *viewY = [[UIView alloc] initWithFrame:CGRectMake(margin - 10, beginY, 0.5, -beginY + 80)];
    viewY.backgroundColor = [UIColor blackColor];
    [self.view addSubview:viewY];
    
    NSArray *nameArray = @[@"注意",@"记忆",@"思维",@"自律",@"执行",@"竞争",@"自尊",@"信任",@"情商"];
    for (int i = 0; i < 9; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(margin*(i+1)-15, beginY, margin, 30)];
        label.text = nameArray[i];
        label.font = [UIFont systemFontOfSize:11];
        [self.view addSubview:label];
    }
}

- (void) setUpBesslCurveWithMargin:(CGFloat)margin beginY:(CGFloat)beginY contractionFactor:(CGFloat)contractionFactor{

    // - 给出的各项数据为 4,6,3,5,4,2,6,4,3 , 要定一个基数
    CGFloat base = -beginY * 0.05;
    
    NSValue *point1Value = [NSValue valueWithCGPoint:CGPointMake(margin*1, beginY + base * 4)];
    NSValue *point2Value = [NSValue valueWithCGPoint:CGPointMake(margin*2, beginY + base * 6)];
    NSValue *point3Value = [NSValue valueWithCGPoint:CGPointMake(margin*3, beginY + base * 3)];
    NSValue *point4Value = [NSValue valueWithCGPoint:CGPointMake(margin*4, beginY + base * 5)];
    NSValue *point5Value = [NSValue valueWithCGPoint:CGPointMake(margin*5, beginY + base * 4)];
    NSValue *point6Value = [NSValue valueWithCGPoint:CGPointMake(margin*6, beginY + base * 2)];
    NSValue *point7Value = [NSValue valueWithCGPoint:CGPointMake(margin*7, beginY + base * 6)];
    NSValue *point8Value = [NSValue valueWithCGPoint:CGPointMake(margin*8, beginY + base * 4)];
    NSValue *point9Value = [NSValue valueWithCGPoint:CGPointMake(margin*9, beginY + base * 3)];
    
    _pointArray = [NSMutableArray array];
    
    [_pointArray addObjectsFromArray:@[point1Value, point2Value, point3Value, point4Value, point5Value, point6Value, point7Value,point8Value,point9Value]];
    

    _curve = [UIBezierPath bezierPath];
    
    // - 起点
    [_curve moveToPoint:CGPointMake(margin*1, beginY + base * 4)];
    
    // - 曲线的弯曲程度, 默认0.7
    _curve.contractionFactor = contractionFactor;

    // - 数组元素为: 点point
    [_curve addBezierThroughPoints:_pointArray];

    
    // - 是否添加点来直观的显示数据
    if (beginY > self.view.frame.size.height*0.6) {
        
        [self drawPoint:CGPointMake(margin*1, beginY + base * 4)];
        [self drawPoint:CGPointMake(margin*2, beginY + base * 6)];
        [self drawPoint:CGPointMake(margin*3, beginY + base * 3)];
        [self drawPoint:CGPointMake(margin*4, beginY + base * 5)];
        [self drawPoint:CGPointMake(margin*5, beginY + base * 4)];
        [self drawPoint:CGPointMake(margin*6, beginY + base * 2)];
        [self drawPoint:CGPointMake(margin*7, beginY + base * 6)];
        [self drawPoint:CGPointMake(margin*8, beginY + base * 4)];
        [self drawPoint:CGPointMake(margin*9, beginY + base * 3)];
    }
    
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.strokeColor = [UIColor blueColor].CGColor;
    _shapeLayer.fillColor = nil;
    _shapeLayer.lineWidth = 1;
    _shapeLayer.path = _curve.CGPath;
    _shapeLayer.lineCap = kCALineCapRound;
    [self.view.layer addSublayer:_shapeLayer];

}

- (void)drawPoint:(CGPoint)point {
    
    CALayer * pointLayer = [CALayer layer];
    pointLayer.bounds = CGRectMake(0, 0, 7, 7);
    pointLayer.cornerRadius = 5;
    pointLayer.position = point;
    pointLayer.backgroundColor = [UIColor redColor].CGColor;
    pointLayer.opaque = YES;
    [self.view.layer addSublayer:pointLayer];
}
@end
