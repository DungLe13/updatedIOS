//
//  GameScene.swift
//  SimpleGame
//
//  Created by Student on 4/24/16.
//  Copyright (c) 2016 Dung Le. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let player = SKSpriteNode(imageNamed: "Deoxys")
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        player.position = CGPoint(x: size.width * 0.85, y: size.height * 0.5)
        player.zPosition = 100
        
        self.addChild(player)
        
        let background = SKSpriteNode(imageNamed: "background")
        self.addChild(background)
        background.position = CGPointMake(self.size.width/2, self.size.height/2)
        
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        
        runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.runBlock(addTriangle), SKAction.waitForDuration(1.0)])))
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func addTriangle() {
        let triangle = SKSpriteNode(imageNamed: "Triangle")
        let actualY = random(min: triangle.size.height/2, max: size.height - triangle.size.height/2)
        
        // Position the triangle slightly off-scene along the left edge
        triangle.position = CGPoint(x: -triangle.size.width/2, y: actualY)
        triangle.zPosition = 100
        addChild(triangle)
        
        triangle.physicsBody = SKPhysicsBody(rectangleOfSize: triangle.size)
        triangle.physicsBody?.dynamic = true
        triangle.physicsBody?.categoryBitMask = PhysicsCategory.Triangle
        triangle.physicsBody?.contactTestBitMask = PhysicsCategory.Solrock
        triangle.physicsBody?.collisionBitMask = PhysicsCategory.None
        
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        // Create the action
        let actionMove = SKAction.moveTo(CGPoint(x: size.width, y: actualY), duration: NSTimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        
        triangle.runAction(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.locationInNode(self)
        
        let solrock = SKSpriteNode(imageNamed: "solrock")
        solrock.zPosition = 100
        solrock.position = player.position
        
        let offset = solrock.position - touchLocation
        if offset.x < 0 { return }
        addChild(solrock)
        
        solrock.physicsBody = SKPhysicsBody(circleOfRadius: solrock.size.width/2)
        solrock.physicsBody?.dynamic = true
        solrock.physicsBody?.categoryBitMask = PhysicsCategory.Solrock
        solrock.physicsBody?.contactTestBitMask = PhysicsCategory.Triangle
        solrock.physicsBody?.collisionBitMask = PhysicsCategory.None
        solrock.physicsBody?.usesPreciseCollisionDetection = true
        
        let direction = offset.normalized()
        let shootAmount = direction * -1000
        let realDest = shootAmount + solrock.position
        
        let actionMove = SKAction.moveTo(realDest, duration: 2.0)
        let actionMoveDone = SKAction.removeFromParent()
        solrock.runAction(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    func solrockDidCollideWithTriangle(solrock: SKSpriteNode, triangle: SKSpriteNode) {
        print("Hit")
        solrock.removeFromParent()
        triangle.removeFromParent()
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if (firstBody.categoryBitMask & PhysicsCategory.Triangle != 0) && (secondBody.categoryBitMask & PhysicsCategory.Solrock != 0) {
            solrockDidCollideWithTriangle(firstBody.node as! SKSpriteNode, triangle: secondBody.node as! SKSpriteNode)
        }
    }
}

// WARNING: MATH STUFF
func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64)) || arch(arm64)
    func sqrt(a: CGFloat) -> CGFloat {
        return CGFloat(sqrtf(Float(a)))
}
#endif

extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint {
        return self / length()
    }
}

struct PhysicsCategory {
    static let None     : UInt32 = 0
    static let All      : UInt32 = UInt32.max
    static let Triangle : UInt32 = 0b1
    static let Solrock  : UInt32 = 0b10
}





