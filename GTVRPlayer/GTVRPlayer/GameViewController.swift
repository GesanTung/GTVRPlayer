//
//  GameViewController.swift
//  GTVRPlayer
//
//  Created by Gesantung on 16/11/9.
//  Copyright © 2016年 Gesantung. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import CoreMotion
import SpriteKit
import AVFoundation

class GameViewController: UIViewController,SCNSceneRendererDelegate {
    
    let cameraNode = SCNNode()
    
    var sceneView = SCNView()
    
    //球形天空盒
    func createSphereNode(material: AnyObject?) -> SCNNode {
        let sphere = SCNSphere(radius: 40.0)
        sphere.firstMaterial!.isDoubleSided = true
        sphere.firstMaterial!.diffuse.contents = material
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = SCNVector3Make(0,0,0)
        return sphereNode
    }
    
    func configureScene(node sphereNode: SCNNode) {
        // Set the scene
        sceneView.frame = self.view.frame
        self.view.addSubview(sceneView)
        let scene = SCNScene()
        sceneView.scene = scene
        //sceneView.showsStatistics = true
        sceneView.allowsCameraControl = true
        // Camera, ...
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 0, 0)
        scene.rootNode.addChildNode(sphereNode)
        scene.rootNode.addChildNode(cameraNode)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let videoName = "skyrim360"
        
        let fileURL: NSURL? = NSURL.fileURL(withPath: Bundle.main.path(forResource: videoName, ofType: "mp4")!) as NSURL?
        
        let player = AVPlayer(url: fileURL as! URL)
        let videoNode = SKVideoNode(avPlayer: player)
        let size = CGSize(width: 1024,height: 1024)
        videoNode.size = size
        videoNode.position = CGPoint(x: size.width/2.0,y: size.height/2.0)
        let spriteScene = SKScene(size: size)
        spriteScene.addChild(videoNode)
        let sphereNode = createSphereNode(material:spriteScene)
        configureScene(node: sphereNode)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        sceneView.play(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
