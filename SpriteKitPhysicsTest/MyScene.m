//
//  MyScene.m
//  SpriteKitPhysicsTest
//
//  Created by Ivan on 14-6-17.
//  Copyright (c) 2014年 Ivan. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene{
    SKSpriteNode *_circle;
    SKSpriteNode *_square;
    SKSpriteNode *_triangle;
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.physicsBody=[SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
        _square=[SKSpriteNode spriteNodeWithImageNamed:@"square"];
        _square.position=CGPointMake(self.size.width * 0.25, self.size.height * 0.5);
        _square.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:_square.size];
        [self addChild:_square];
        
        _triangle=[SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        _triangle.position=CGPointMake(self.size.width * 0.75, self.size.height * 0.5);
        _triangle.size=CGSizeMake(64,64);
        
//        Core Graphics path 定义实体的边界
        CGMutablePathRef triangelPath=CGPathCreateMutable();
        CGPathMoveToPoint(triangelPath, nil, -_triangle.size.width / 2.0, -_triangle.size.height/2.0);
        CGPathAddLineToPoint(triangelPath, nil, _triangle.size.width/2.0, -_triangle.size.height/2.0);
        CGPathAddLineToPoint(triangelPath, nil,0, _triangle.size.height/2.0);

        CGPathAddLineToPoint(triangelPath, nil, -_triangle.size.width / 2.0, -_triangle.size.height/2.0);
        _triangle.physicsBody=[SKPhysicsBody bodyWithPolygonFromPath:triangelPath];
        CGPathRelease(triangelPath);

//        _triangle.physicsBody=[SKPhysicsBody bodyWithCircleOfRadius:_triangle.size.width / 12.0];
        
        [self addChild:_triangle];
        
        [self runAction:
         [SKAction repeatAction:
          [SKAction sequence:
           @[[SKAction performSelector:@selector(spawSand) onTarget:self],[SKAction waitForDuration:0.02 ]]]
                          count:200]
         ];
     
    }
    return self;
}


-(void)spawSand
{
    SKSpriteNode *sand =[SKSpriteNode spriteNodeWithImageNamed:@"virus"];
    sand.size=CGSizeMake(12, 12);
    sand.position=CGPointMake((float)(arc4random()%(int)self.size.width),self.size.height-sand.size.height);
    sand.physicsBody=[SKPhysicsBody bodyWithCircleOfRadius:sand.size.width/2];
    sand.name=@"sand";
    sand.physicsBody.restitution=0.8;         //反弹力
//    sand.physicsBody.linearDamping=1.0;      //
    sand.physicsBody.density=20.0;            //密度
    sand.physicsBody.friction=0.7;            // 摩擦力
    [self addChild:sand];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//        
//        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
//        
//        sprite.position = location;
//        
//        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
//        
//        [sprite runAction:[SKAction repeatActionForever:action]];
//        
//        [self addChild:sprite];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
