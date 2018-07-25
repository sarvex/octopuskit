//
//  PhysicsEventComponent.swift
//  OctopusKit
//
//  Created by ShinryakuTako@invadingoctopus.io on 2017/10/28.
//  Copyright © 2018 Invading Octopus. Licensed under Apache License v2.0 (see LICENSE.txt)
//

// TODO: Tests.
// CHECK: Potential 1-frame lag due to `SKScene.update(deltaTime:)` vs `SKPhysicsContactDelegate`?
// CHECK: Warn if the entity's `OctopusScene.physicsWorld.contactDelegate` is not valid?

import GameplayKit

/// Stores events about contacts between physics bodies in a scene. The events may be observed by other components, and are cleared every frame.
///
/// - Important: For this component to function, the `OctopusScene.physicsWorld.contactDelegate` must be set to the scene.
public final class PhysicsEventComponent: OctopusComponent, OctopusUpdatableComponent {
    
    public final class ContactEvent: Equatable {
        
        public let contact: SKPhysicsContact
        public let scene: OctopusScene? // CHECK: Should this be optional?
        
        public init(contact: SKPhysicsContact,
                    scene: OctopusScene? = nil)
        {
            self.contact = contact
            self.scene = scene
        }
        
        public static func == (left: ContactEvent, right: ContactEvent) -> Bool {
            return (left.contact === right.contact
                &&  left.scene === right.scene)
        }
        
        public static func != (left: ContactEvent, right: ContactEvent) -> Bool {
            return (left.contact !== right.contact
                &&  left.scene !== right.scene)
        }
    }
    
    public var contactBeginnings = [ContactEvent]()
    public var contactEndings = [ContactEvent]()
    
    public fileprivate(set) var clearOnNextUpdate: Bool = false
    
    /// To be called every frame AFTER other components, if any, have had a chance to act upon the stored events during a given frame.
    public override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)

        // Clear the event arrays while maintaining their storage, as they are likely to grow again on the next frame.
        
        if clearOnNextUpdate {
            contactBeginnings.removeAll(keepingCapacity: true)
            contactEndings.removeAll(keepingCapacity: true)
            clearOnNextUpdate = false
        }
        
        if contactBeginnings.count > 0 || contactEndings.count > 0 {
            clearOnNextUpdate = true
        }
    }
    
}