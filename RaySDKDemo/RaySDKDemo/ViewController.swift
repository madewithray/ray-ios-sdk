//
//  ViewController.swift
//  RaySDKDemo
//
//  Created by Sean Ooi on 6/18/15.
//  Copyright © 2015 Yella Inc. All rights reserved.
//

import UIKit
import RaySDK

class ViewController: UITableViewController {
    
    var items = [[String: AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ray SDK"
        
        RSDK.sharedInstanceWithApiKey("MyAPIKey")
        RSDK.sharedInstance.delegate = self
        RSDK.sharedInstance.subsequentRangingInterval = 5
        RSDK.sharedInstance.enableBackgroundProcessTimeExtension = true
        RSDK.sharedInstance.beaconMinimumThreshold = -69
        RSDK.sharedInstance.beaconExitTrigger = -70
        RSDK.sharedInstance.enableCustomWalkOut = true
        RSDK.sharedInstance.enableContinuousRanging = true
        RSDK.sharedInstance.setAuthorizationType(.Always)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count ?? 0
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 66
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! BeaconTableViewCell
        
        let dict = items[indexPath.row]
        
        guard let beacon = dict["beacon"] as? RSDKBeacon else {
            cell.majorValueLabel.text = "None"
            cell.minorValueLabel.text = "None"
            cell.rssiValueLabel.text = "None"
            
            return cell
        }
        
        cell.majorValueLabel.text = "\(beacon.major)"
        cell.minorValueLabel.text = "\(beacon.minor)"
        cell.rssiValueLabel.text = "\(beacon.rssi)"
        
        return cell
    }
}

extension ViewController: RaySDKDelegate {
    
    func rsdkDidRangeRayBeacon(beacon: [RSDKBeacon]!, inRegionWithIdentifier identifier: String) {
        print("Did range: \(beacon)", appendNewline: true)
    }
    
    func rsdkDidEnterRegionWithIdentifier(identifier: String) {
        print("Did enter region: \(identifier)", appendNewline: true)
    }
    
    func rsdkDidExitRegionWithIdentifier(identifier: String) {
        print("Did exit region: \(identifier)", appendNewline: true)
    }
    
    func rsdkDidWalkInToBeacon(beacon: RSDKBeacon!, inRegionWithIdentifier identifier: String) {
        print("Did walk in: \(beacon)", appendNewline: true)
        
        items.append(["beacon": beacon, "key": identifier])
        
        tableView.reloadData()
    }
    
    func rsdkDidWalkOutOfBeacon(beacon: RSDKBeacon!, inRegionWithIdentifier identifier: String) {
        print("Did walk out: \(beacon)", appendNewline: true)
        for (idx, item) in items.enumerate() {
            guard let key = item["key"] as? String where key == identifier else {
                continue
            }
            
            items.removeAtIndex(idx)
            break
        }
        
        tableView.reloadData()
    }
    
    func rsdkListReady() {
        print("List is ready!", appendNewline: true)
        RSDK.sharedInstance.startMonitoring()
    }
    
    func rsdkDidFailWithError(error: NSError!) {
        print("Error: \(error)", appendNewline: true)
    }
    
    func rsdkBluetoothManagerDidUpdateState(state: BluetoothState) {
        switch state {
        case .Unknown:
            print("Bluetooth state unknown", appendNewline: true)
            
        case .Resetting:
            print("Bluetooth state resetting", appendNewline: true)
            
        case .Unsupported:
            print("Bluetooth state unsupported", appendNewline: true)
            
        case .Unauthorized:
            print("Bluetooth state unauthorized", appendNewline: true)
            
        case .PoweredOff:
            print("Bluetooth state powered off", appendNewline: true)
            
        case .PoweredOn:
            print("Bluetooth state powered on", appendNewline: true)
        }
    }
}