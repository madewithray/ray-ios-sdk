//
//  MainTableViewController.swift
//  SDKDemo
//
//  Created by Sean Ooi on 6/11/15.
//  Copyright (c) 2015 Yella Inc. All rights reserved.
//

import UIKit
import RaySDK

class MainTableViewController: UITableViewController {

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

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        let dict = items[indexPath.row]
        if let beacon = dict["beacon"] as? RSDKBeacon {
            cell.textLabel?.text = "\(beacon.major)-\(beacon.minor)"
            cell.detailTextLabel?.text = "RSSI: \(beacon.rssi)"
        }
        else {
            cell.textLabel?.text = "Some beacon"
            cell.detailTextLabel?.text = "RSSI: I have no idea"
        }

        return cell
    }

}

extension MainTableViewController: RaySDKDelegate {
    
    func rsdkDidRangeRayBeacon(beacon: [RSDKBeacon]!, inRegionWithIdentifier identifier: String) {
        println("Did range: \(beacon)")
    }
    
    func rsdkDidEnterRegionWithIdentifier(identifier: String) {
        println("Did enter region: \(identifier)")
    }
    
    func rsdkDidExitRegionWithIdentifier(identifier: String) {
        println("Did exit region: \(identifier)")
    }
    
    func rsdkDidWalkInToBeacon(beacon: RSDKBeacon!, inRegionWithIdentifier identifier: String) {
        println("Did walk in: \(beacon)")
        
        items.append(["beacon": beacon, "key": identifier])
        tableView.reloadData()
    }
    
    func rsdkDidWalkOutOfBeacon(beacon: RSDKBeacon!, inRegionWithIdentifier identifier: String) {
        println("Did walk out: \(beacon)")
        for (idx, item) in enumerate(items) {
            if let key = item["key"] as? String where key == identifier {
                items.removeAtIndex(idx)
                break
            }
        }
        tableView.reloadData()
    }
    
    func rsdkListReady() {
        println("List is ready!")
        RSDK.sharedInstance.startMonitoring()
    }
    
    func rsdkDidFailWithError(error: NSError!) {
        println("Error: \(error)")
    }
    
    func rsdkBluetoothManagerDidUpdateState(state: BluetoothState) {
        switch state {
        case .Unknown:
            println("Bluetooth state unknown")
            
        case .Resetting:
            println("Bluetooth state resetting")
            
        case .Unsupported:
            println("Bluetooth state unsupported")
            
        case .Unauthorized:
            println("Bluetooth state unauthorized")
            
        case .PoweredOff:
            println("Bluetooth state powered off")
            
        case .PoweredOn:
            println("Bluetooth state powered on")
        }
    }
}
