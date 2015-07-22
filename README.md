
![MadeWithRay](http://i.imgur.com/V7j2nrp.png)

[![Join the chat at https://gitter.im/madewithray/ray-ios-sdk](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/madewithray/ray-ios-sdk?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

# RaySDK for iOS
The RaySDK allows you to interact with Ray beacons in the wild.

##Prerequisites
RaySDK is compatible with projects for iOS 8 and above

##Installation
1. Drag the **RaySDK.framework** file into your project
2. Under your peoject's target's _General_ settings, make sure **RaySDK.framework** is included under _Embedded Binaries_ as well as _Linked Frameworks and Libraries_
	
##Usage
1. Register your _API Key_ by calling `RSDK.sharedInstanceWithApiKey("YourAPIKey")`
2. Set the SDK delegate `RSDK.sharedInstance.delegate`
3. Set the location service `AuthorizationType` to request. `.Always` or `.WhenInUse`. 
	* If location services has not yet been requested, the SDK will attempt to request for it.
	* Make sure the `NSLocationAlwaysUsageDescription` or `NSLocationWhenInUseUsageDescription` key is present in your plist file.
4. Call `RSDK.sharedInstance.startMonitoring()` to begin monitoring for _Ray_ beacons

__*Additional documentation can be found [here](http://madewithray.github.io/ray-ios-sdk/)*__

###Optional Configurations
**Variable** | **Description**
--- | --- | ---
`beaconRSSITrigger` | The value where a beacon should be registered as "in-range". Default value is -75.
`beaconMinimumThreshold` | The minimum value of the range where the beacon should stay in in-order to be considered "in-range". Value must be less than `beaconMaximumThreshold` and within range of (∞, 0). Default value is -85.
`beaconMaximumThreshold` | The maximum value of the range where the beacon should stay in in-order to be considered "in-range". Value must be greater than `beaconMinimumThreshol.d` and within range of (∞, 0]. Default value is 0.
`beaconExitTrigger` | The value where a beacon should be registered as "out-of-range". Value must be less than `beaconMinimumThreshold`. Default value is -90.
`walkInTimeToWait` | The time to wait (seconds) before a beacon is registered when entering its region. Default value is 10 seconds.
`walkOutTimeToWait` | The time to wait (seconds) before a beacon is registered when exiting its region. Default value is 10 seconds.
`subsequentRangingInterval` | The time to wait (seconds) between identifying identical beacons. Default value is 6 hours.
`enableBackgroundProcessTimeExtension` | If `true`, background process time will be extended while app is in background. Default value is `false`.
`enableContinuousRanging` | If `true`, `rsdkDidRangeRayBeacon:inRegionWithIdentifier:` will continuously return all ranged beacons. Avoid continuous ranging to conserve battery.
`enableCustomWalkOut` | If `true`, `rsdkDidWalkOutOfBeacon:inRegionWithIdentifier:` will adhere to `beaconExitTrigger` and `walkOutTimeToWait` values. Default value is `false`.
`hasWalkedIn` | Returns true if device is registered as `walked-in`. False is device is not in range of beacons or has `walked-out` of range.