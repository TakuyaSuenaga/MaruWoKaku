//
//  MKViewController.m
//  MaruWoKaku
//
//  Created by Takuya Suenaga on 2014/07/23.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import "MKViewController.h"
#import "MKFlatUI.h"
#import "MKLibrary.h"
#import "PerfectShape.h"
#import "ScoreView.h"
#import "MyColor.h"
#import "LogoView.h"
#import "GCManager.h"
#import "AdManager.h"

@interface MKViewController () <CanvasImageViewDelegate, LogoViewDelegate>

@end

@implementation MKViewController
{
    GCManager *gcManager;
    LogoView *logo;
}

@synthesize playData;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    gcManager = [GCManager sharedManager];
    [gcManager authenticateLocalPlayer:self];
    [MKLibrary readySound];
    self.canvas.delegate = self;
    self.logoView.backgroundColor = [UIColor clearColor];
    [self initializeViewWithShape:SHAPE_CIRCLE];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.view addSubview:[AdManager shardAdBannerView]];

    self.bestTitleLabel.font    = [UIFont MPlusFontOfSize:self.bestTitleLabel.font.pointSize];
    self.bestScoreLabel.font    = [UIFont boldMPlusFontOfSize:self.bestScoreLabel.font.pointSize];
    self.averageTitleLabel.font = [UIFont MPlusFontOfSize:self.averageTitleLabel.font.pointSize];
    self.averageScoreLabel.font = [UIFont boldMPlusFontOfSize:self.averageScoreLabel.font.pointSize];
}

- (IBAction)ranking:(id)sender {
    [gcManager showGameCenter:self];
}

- (void)clickedLogoView
{
    switch (self.shape) {
        case SHAPE_CIRCLE:
            [self initializeViewWithShape:SHAPE_SQUARE];
            break;
        case SHAPE_SQUARE:
            [self initializeViewWithShape:SHAPE_TRIANGLE];
            break;
        case SHAPE_TRIANGLE:
            [self initializeViewWithShape:SHAPE_LINE];
            break;
        case SHAPE_LINE:
            [self initializeViewWithShape:SHAPE_CIRCLE];
            break;
            
        default:
            break;
    }
}

- (void)initializeViewWithShape:(int)shape
{
    self.shape = shape;

    if (logo != nil) {
        [logo removeFromSuperview];
    }
    logo = [[LogoView alloc] initWithFrame:CGRectMake(0, 0, self.logoView.frame.size.width, self.logoView.frame.size.height) shape:shape];
    logo.delegate = self;
    [self.logoView addSubview:logo];
    
    playData = [MKLibrary getPlayDataWithShape:shape];
    if (playData == nil) {
        playData = [PlayData new];
    }
    
    self.bestScoreLabel.text = [NSString stringWithFormat:@"%.2f", playData.bestScore];
    self.averageScoreLabel.text = [NSString stringWithFormat:@"%.2f", playData.averageScore];
    
    [self.canvas clearView];
}

- (void)drawEnd:(CanvasImageView *)imageView
{
    switch (self.shape) {
        case SHAPE_CIRCLE:
            [self calculateCircle:imageView];
            break;
        case SHAPE_SQUARE:
            [self calculateSquare:imageView];
            break;
        case SHAPE_TRIANGLE:
            [self calculateTriangle:imageView];
            break;
        case SHAPE_LINE:
            [self calculateLine:imageView];
            break;
        default:
            break;
    }
}

- (void)calculateCircle:(CanvasImageView *)imageView
{
    CGSize s = imageView.image.size;
    NSMutableArray *dataArray = [self setImageToArray:imageView.image];
    
    //書いた円の中心座標を計算
    int maxX = 0, minX = s.width, maxY = 0, minY = s.height;
    for (NSValue *val in dataArray) {
        CGPoint point = [val CGPointValue];
        if (maxX < point.x) { maxX = point.x; }
        if (minX > point.x) { minX = point.x; }
        if (maxY < point.y) { maxY = point.y; }
        if (minY > point.y) { minY = point.y; }
    }
    //正円の中心座標
    CGPoint centerPoint = CGPointMake((maxX - minX) / 2 + minX, (maxY - minY) / 2 + minY);
    
    //各ポイントの半径を取得
    float radiusSum = 0;
    for (NSValue *val in dataArray) {
        CGPoint point = [val CGPointValue];
        float x = point.x - centerPoint.x;
        float y = -(point.y - centerPoint.y);
        radiusSum += sqrtf((float)(x*x + y*y));
    }
    //平均値を正円の半径とする
    float radiusAverage = radiusSum / dataArray.count;
    NSLog(@"距離：%f", radiusAverage);
    //正円を書き出し
    PerfectShape *perfectShape = [[PerfectShape alloc] initWithFrame:CGRectMake(0, 0, 260, 260)];
    perfectShape.shape = SHAPE_CIRCLE;
    perfectShape.centerPoint = centerPoint;
    perfectShape.radius = radiusAverage;
    [imageView addSubview:perfectShape];
    imageView.perfectShape = perfectShape;
    
    //スコアを表示
    float score = [self compareImage:imageView.image with:[self imageFromView:perfectShape]];
    score = score * 1.1; // 100%
    score = (score > 100)?100:score;
    if (radiusAverage < s.width/4) {
        score = score * (((radiusAverage/(s.width/2))/2) + 0.5);
    }
    [perfectShape addSubview:[self setScore:score center:centerPoint perfectShape:perfectShape]];
}

- (void)calculateSquare:(CanvasImageView *)imageView
{
    CGSize s = imageView.image.size;
    NSMutableArray *dataArray = [self setImageToArray:imageView.image];
    
    //書いた四角の中心座標を計算
    int maxX = 0, minX = s.width, maxY = 0, minY = s.height;
    for (NSValue *val in dataArray) {
        CGPoint point = [val CGPointValue];
        if (maxX < point.x) { maxX = point.x; }
        if (minX > point.x) { minX = point.x; }
        if (maxY < point.y) { maxY = point.y; }
        if (minY > point.y) { minY = point.y; }
    }
    //四角の中心座標とサイズ
    float width = maxX - minX;
    float height = maxY - minY;
    CGPoint centerPoint = CGPointMake(width/ 2 + minX, height/ 2 + minY);
    
    //四角を書き出し
    PerfectShape *perfectShape = [[PerfectShape alloc] initWithFrame:CGRectMake(0, 0, 260, 260)];
    perfectShape.shape = SHAPE_SQUARE;
    perfectShape.centerPoint = centerPoint;
    perfectShape.pRect = CGRectMake(minX, minY, width, height);
    [imageView addSubview:perfectShape];
    imageView.perfectShape = perfectShape;
    
    //スコアを表示
    float score = [self compareImage:imageView.image with:[self imageFromView:perfectShape]];
    score = score * 1.1; // 100%
    score = (score > 100)?100:score;
    if (width < s.width/2 || height < s.height/2) {
        if (width < height) {
            score = score * (((width/(s.width/2))/2) + 0.5);
        } else {
            score = score * (((height/(s.height/2))/2) + 0.5);
            
        }
    }
    [perfectShape addSubview:[self setScore:score center:centerPoint perfectShape:perfectShape]];
}

- (void)calculateTriangle:(CanvasImageView *)imageView
{
    CGSize s = imageView.image.size;
    NSMutableArray *dataArray = [self setImageToArray:imageView.image];
    
    //書いた三角形の中心座標を計算
    int maxX = 0, minX = s.width, maxY = 0, minY = s.height;
    for (NSValue *val in dataArray) {
        CGPoint point = [val CGPointValue];
        if (maxX < point.x) { maxX = point.x; }
        if (minX > point.x) { minX = point.x; }
        if (maxY < point.y) { maxY = point.y; }
        if (minY > point.y) { minY = point.y; }
    }
    //三角形の中心座標とサイズ
    float width = maxX - minX;
    float height = maxY - minY;
    CGPoint centerPoint = CGPointMake(width/ 2 + minX, height/ 2 + minY);
    
    //三角形を書き出し
    PerfectShape *perfectShape = [[PerfectShape alloc] initWithFrame:CGRectMake(0, 0, 260, 260)];
    perfectShape.shape = SHAPE_TRIANGLE;
    perfectShape.centerPoint = centerPoint;
    perfectShape.pRect = CGRectMake(minX, minY, width, height);
    [imageView addSubview:perfectShape];
    imageView.perfectShape = perfectShape;
    
    //スコアを表示
    float score = [self compareImage:imageView.image with:[self imageFromView:perfectShape]];
    score = score * 1.1; // 100%
    score = (score > 100)?100:score;
    if (width < s.width/2 || height < s.height/2) {
        if (width < height) {
            score = score * (((width/(s.width/2))/2) + 0.5);
        } else {
            score = score * (((height/(s.height/2))/2) + 0.5);
            
        }
    }
    [perfectShape addSubview:[self setScore:score center:centerPoint perfectShape:perfectShape]];
}

- (void)calculateLine:(CanvasImageView *)imageView
{
    CGSize s = imageView.image.size;
    NSMutableArray *dataArray = [self setImageToArray:imageView.image];
    
    //書いた直線の中心座標を計算
    int maxX = 0, minX = s.width, maxY = 0, minY = s.height;
    CGPoint pMaxX, pMinX, pMaxY, pMinY;
    for (NSValue *val in dataArray) {
        CGPoint point = [val CGPointValue];
        if (maxX < point.x) { maxX = point.x; pMaxX = point; }
        if (minX > point.x) { minX = point.x; pMinX = point; }
        if (maxY < point.y) { maxY = point.y; pMaxY = point; }
        if (minY > point.y) { minY = point.y; pMinY = point; }
    }
    //直線の中心座標とサイズ
    float width = maxX - minX;
    float height = maxY - minY;
    CGPoint centerPoint = CGPointMake(width/ 2 + minX, height/ 2 + minY);
    
    CGPoint pStart, pEnd;
    if (width < height) {
        int xMaxSum = 0, xMaxCount = 0, xMinSum = 0, xMinCount = 0;
        for (NSValue *val in dataArray) {
            CGPoint point = [val CGPointValue];
            if (pMaxY.y == point.y) { xMaxSum += point.x, xMaxCount++; }
            if (pMinY.y == point.y) { xMinSum += point.x, xMinCount++; }
        }
        pStart = CGPointMake(xMaxSum / xMaxCount, pMaxY.y);
        pEnd   = CGPointMake(xMinSum / xMinCount, pMinY.y);;
    } else {
        int yMaxSum = 0, yMaxCount = 0, yMinSum = 0, yMinCount = 0;
        for (NSValue *val in dataArray) {
            CGPoint point = [val CGPointValue];
            if (pMaxX.x == point.x) { yMaxSum += point.y, yMaxCount++; }
            if (pMinX.x == point.x) { yMinSum += point.y, yMinCount++; }
        }
        pStart = CGPointMake(pMaxX.x, yMaxSum / yMaxCount);
        pEnd   = CGPointMake(pMinX.x, yMinSum / yMinCount);;
    }
    float distance = sqrtf((pStart.x - pEnd.x)*(pStart.x - pEnd.x) + (pStart.y - pEnd.y)*(pStart.y - pEnd.y));
    
    //直線を書き出し
    PerfectShape *perfectShape = [[PerfectShape alloc] initWithFrame:CGRectMake(0, 0, 260, 260)];
    perfectShape.shape = SHAPE_LINE;
    perfectShape.centerPoint = centerPoint;
    perfectShape.startPoint = pStart;
    perfectShape.endPoint = pEnd;
    perfectShape.pRect = CGRectMake(minX, minY, width, height);
    [imageView addSubview:perfectShape];
    imageView.perfectShape = perfectShape;
    
    //スコアを表示
    float score = [self compareImage:imageView.image with:[self imageFromView:perfectShape]];
    score = score * 1.05; // 100%
    score = (score > 100)?100:score;
    if (distance < s.width/2) {
        score = score * (distance / s.width * 0.5 + 0.5);
    }
    [perfectShape addSubview:[self setScore:score center:centerPoint perfectShape:perfectShape]];
}

- (void)regressionLine:(NSMutableArray *)dataArray a:(double*)a b:(double*)b
{
    NSMutableArray *regress = [NSMutableArray new];
    double sx = 0.0, sy = 0.0;
    int xNow = -1, xCount = 0, ySum = 0, yCount = 0;
    for (NSValue *val in dataArray) {
        CGPoint point = [val CGPointValue];
        
        if (xNow != point.x) {
            if (xNow != -1) {
                [regress addObject:[NSValue valueWithCGPoint:CGPointMake(xNow, ySum / yCount)]];
            }
            ySum = 0, yCount = 0;
            xNow = point.x;
            xCount++;
        }
        ySum += point.y;
        yCount++;
    }
    
    for (NSValue *val in regress) {
        CGPoint point = [val CGPointValue];
        sx += point.x;
        sy += point.y;
    }
    double MeanX = sx / regress.count;
    double MeanY = sy / regress.count;
    
    double ssx = 0.0, ssy = 0.0, sxy = 0.0, sRxRy = 0.0, ssRx = 0.0;
    for (NSValue *val in regress) {
        CGPoint point = [val CGPointValue];
        ssx += sqrt(point.x - MeanX);
        ssy += sqrt(point.y - MeanY);
        sxy += (point.x - MeanY) * (point.y - MeanY);
        sRxRy += point.x * point.y;
        ssRx  += sqrt(point.x);
    }
    *a = (regress.count * sRxRy - sx * sy) / (regress.count * ssRx - sqrt(sx));
    *b = (ssRx * sy - sx * sRxRy) / (regress.count * ssRx - sqrt(sx));
}

- (ScoreView*)setScore:(float)score center:(CGPoint)centerPoint perfectShape:(UIView*)perfectShape
{
    float rScore = [self roundf2:score];
    float averageScore = (playData.averageScore * playData.playCount + rScore) / ++playData.playCount;
    playData.averageScore = [self roundf2:averageScore];
    self.averageScoreLabel.text = [NSString stringWithFormat:@"%.2f", playData.averageScore];
    ScoreView *scoreView = [[ScoreView alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
    if (playData.bestScore < rScore) {
        playData.bestScore = rScore;
        playData.bestImage = self.canvas.image;
        playData.perfectShape = [self imageFromView:perfectShape];
        self.bestScoreLabel.text = [NSString stringWithFormat:@"%.2f", rScore];
        scoreView.titleLabel.text = @"New Best !";
        scoreView.titleLabel.textColor = [MyColor moderateRedColor];
        scoreView.titleLabel.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:17];
        [MKLibrary bestscoreSound];
        [gcManager uploadScore:rScore Shape:self.shape];
    } else {
        [MKLibrary scoreSound];
    }
    
    [MKLibrary savePlayData:playData Shape:self.shape];
    
    scoreView.scoreLabel.text = [NSString stringWithFormat:@"%.2f", rScore];
    scoreView.center = centerPoint;
    
    return scoreView;
}

- (float)roundf2:(float)num
{
    NSDecimalNumber *decimal = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",num]];
    // 小数点第3位を四捨五入
    int scale = 2;
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                                                                      scale:scale
                                                                                           raiseOnExactness:NO
                                                                                            raiseOnOverflow:NO
                                                                                           raiseOnUnderflow:NO
                                                                                        raiseOnDivideByZero:NO];
    decimal = [decimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [decimal floatValue];
}

- (NSMutableArray*)setImageToArray:(UIImage*)image
{
    CGImageRef imageRef = image.CGImage;
    CGDataProviderRef dataProvider = CGImageGetDataProvider(imageRef);
    CFDataRef dataRef = CGDataProviderCopyData(dataProvider);
    UInt8* buffer = (UInt8*)CFDataGetBytePtr(dataRef);
    size_t bytesPerRow = CGImageGetBytesPerRow(imageRef);
    
    //書いた図形の座標を配列に追加
    CGSize s = image.size;
    NSMutableArray *dataArray = [NSMutableArray new];
    for (int x = 0; x < s.width; x++) {
        for (int y = 0; y < s.height; y++) {
            UInt8 *pixelPtr = buffer + (int)(y) * bytesPerRow + (int)(x) * 4;
            if (*pixelPtr) {
                [dataArray addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
            }
        }
    }
    return dataArray;
}

- (UIImage*)imageFromView:(UIView*)myView
{
    UIImage *image;
    UIGraphicsBeginImageContext(myView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [myView.layer renderInContext:context];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (float)compareImage:(UIImage*)image1 with:(UIImage*)image2
{
    int numOfPixels = 0;
    int matches = 0;
    CGSize size;
    
    // image1
    CGImageRef  imageRef1 = image1.CGImage;
    CGDataProviderRef dataProvider1 = CGImageGetDataProvider(imageRef1);
    CFDataRef dataRef1 = CGDataProviderCopyData(dataProvider1);
    UInt8* buffer1 = (UInt8*)CFDataGetBytePtr(dataRef1);
    size_t bytesPerRow1 = CGImageGetBytesPerRow(imageRef1);
    
    // image1
    CGImageRef  imageRef2 = image2.CGImage;
    CGDataProviderRef dataProvider2 = CGImageGetDataProvider(imageRef2);
    CFDataRef dataRef2 = CGDataProviderCopyData(dataProvider2);
    UInt8* buffer2 = (UInt8*)CFDataGetBytePtr(dataRef2);
    size_t bytesPerRow2 = CGImageGetBytesPerRow(imageRef2);
    
    if (CGSizeEqualToSize(image1.size, image2.size)) {
        size = image1.size;
    } else {
        size.width  = (image1.size.width <= image2.size.width)?image1.size.width:image2.size.width;
        size.height = (image1.size.height <= image2.size.height)?image1.size.height:image2.size.height;
    }
    
    for (int x = 0; x < size.width; x++) {
        for (int y = 0; y < size.height; y++) {
            // image1
            UInt8 *pixelPtr1 = buffer1 + (int)(y) * bytesPerRow1 + (int)(x) * 4;
            // image2
            UInt8 *pixelPtr2 = buffer2 + (int)(y) * bytesPerRow2 + (int)(x) * 4;
            if (*pixelPtr1 == 0) {
                if (*pixelPtr2 != 0) {
                    numOfPixels++;
                }
            } else {
                if (*pixelPtr2 != 0) {
                    matches++;
                }
                numOfPixels++;
            }
        }
    }
    
    CFRelease(dataRef1);
    CFRelease(dataRef2);
    
    NSLog(@"compareImage : matches=%d numOfPixels=%d", matches, numOfPixels);
    return (matches == 0)?0:(float)matches/numOfPixels*100;
}

@end
