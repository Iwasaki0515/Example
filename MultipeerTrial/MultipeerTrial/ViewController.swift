//
//  ViewController.swift
//  MultipeerTrial
//
//  Created by Majima Kentaro on 2016/07/24.
//  Copyright © 2016年 colorboxstudio. All rights reserved.
//

import UIKit
import RxMultipeer
import MultipeerConnectivity
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    typealias I = MCPeerID

    @IBOutlet weak var resourceLabel: UILabel!
    @IBOutlet weak var adButton: UIButton!
    
    @IBOutlet weak var upButton: UIButton!
    
    @IBOutlet weak var downButton: UIButton!
    
    @IBOutlet weak var connectButton: UIButton!
    
    var hoge:Variable<Int> = Variable(0)
    
    var disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        


    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        let name = UIDevice.currentDevice().name
        print("\(name): Loading")
        
        let client = CurrentClient(
            session: MultipeerConnectivitySession(
                displayName: name,
                serviceType: "multipeerex",
                encryptionPreference: .None))
        
        let other = client.connectedPeer().shareReplay(1)

        adButton.rx_tap
            .subscribeNext {
                print("\(name): begin advertising")
                client.stopBrowsing()
                client.startAdvertising()
            }
            .addDisposableTo(disposeBag)
        connectButton.rx_tap
            .subscribeNext {
                print("\(name): begin browsing")
                client.stopAdvertising()
                client.startBrowsing()
            }
            .addDisposableTo(disposeBag)
        
        
        
        Observable.combineLatest(client.connections(),
        client.nearbyPeers()) { (connections, nearby) in
            return nearby.filter { (p, _) in
                connections.map { $0.iden }.indexOf(p.iden) == nil
            }
            }
            .subscribeNext {
                print("\(name): there are \($0.count) devices nearby")
                for p in $0 {
                    print("\(name): connecting to \(p.0.iden)")
                    client.connect(p.0)
                }
            }
            .addDisposableTo(disposeBag)
        
        // Just accept everything
        client.incomingConnections()
            .subscribeNext { (_, _, respond) in respond(true) }
            .addDisposableTo(disposeBag)
        
        // Logging
        other
            .subscribeNext { print("\(name): \($0.iden) successfully connected") }
            .addDisposableTo(disposeBag)
        
        client.disconnectedPeer()
            .subscribeNext { print("\(name): \($0.iden) disconnected") }
            .addDisposableTo(disposeBag)
        
        client.receive()
            .subscribeNext { (c, m: String) in
                print("\(name): received message '\(m)' from '\(c.iden)'")
                if m=="up"{self.hoge.value++}
                if m=="down"{self.hoge.value--}
            }
            .addDisposableTo(disposeBag)
        
        let stream = other
            .map { client.send($0, streamName: "hellothere") }
            .debug()
            .switchLatest()
            .shareReplay(1)
        

        downButton.rx_tap
            .withLatestFrom(client.connections())
            .map { (cs: [Client<I>]) -> Observable<Client<I>> in cs.map { Observable.just($0) }.concat() }
            .merge()
            .map { (c: Client<I>) -> Observable<()> in
                print("\(name): sending yo to \(c.iden)")
                return client.send(c, "down")
            }
            .merge()
            .subscribeNext { _ in }
            .addDisposableTo(disposeBag)

        upButton.rx_tap
            .withLatestFrom(client.connections())
            .map { (cs: [Client<I>]) -> Observable<Client<I>> in cs.map { Observable.just($0) }.concat() }
            .merge()
            .map { (c: Client<I>) -> Observable<()> in
                print("\(name): sending yo to \(c.iden)")
                return client.send(c, "up")
            }
            .merge()
            .subscribeNext { _ in }
            .addDisposableTo(disposeBag)
        
        other.map { client.receive($0, streamName: "hellothere") }
            .switchLatest()
            .debug()
            .subscribeNext { (d: [UInt8]) in
                print("Received stream data: \(d)")
            }
            .addDisposableTo(disposeBag)
        

        resourceLabel.text = String(hoge.value)

        
        hoge.asObservable().subscribeNext { (value:Int) in
            print(value)
            dispatch_async(dispatch_get_main_queue()){[unowned self]in
                self.resourceLabel.text = String(value)
            }
        }
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

