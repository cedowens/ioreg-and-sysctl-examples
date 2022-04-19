import Foundation
import CoreFoundation
import IOKit


var kh = "kern.hostname".cString(using: .utf8)
sysctlbyname(kh, nil, &size, nil, 0)
var kh2 = [CChar](repeating: 0, count: Int(size))
sysctlbyname(kh, &kh2, &size, nil, 0)
print("Hostname Info: " + String(cString: kh2))

var osInfo = ProcessInfo.processInfo.operatingSystemVersionString
var processors = ProcessInfo.processInfo.activeProcessorCount
print("Operating System Info: \(osInfo)")
print("Active Processor Count: \(processors)")

let dev = IOServiceMatching("IOPlatformExpertDevice")
let platformExpert : io_service_t = IOServiceGetMatchingService(kIOMasterPortDefault, dev)
let serialNumberAsCFString = IORegistryEntryCreateCFProperty(platformExpert, kIOPlatformSerialNumberKey as CFString, kCFAllocatorDefault, 0)
IOObjectRelease(platformExpert)
let ser: CFTypeRef = serialNumberAsCFString!.takeUnretainedValue()
print("Serial number: \(ser)")

var size = 0
var mach = "hw.machine".cString(using: .utf8)
sysctlbyname(mach, nil, &size, nil, 0)
var machine = [CChar](repeating: 0, count: Int(size))
sysctlbyname(mach, &machine, &size, nil, 0)
print("Architecture Info: " + String(cString: machine))

var mach2 = "hw.model".cString(using: .utf8)
sysctlbyname(mach2, nil, &size, nil, 0)
var machine2 = [CChar](repeating: 0, count: Int(size))
sysctlbyname(mach2, &machine2, &size, nil, 0)
var hwmodel = String(cString: machine2)
print("Hardware Model: " + String(cString: machine2))

if !(hwmodel.contains("Mac")){
    print("[-] Host IS running in a VM based on the hardware model value of \(hwmodel)")
}
else {
    print("[+] Host is a physical machine and is not in a VM based on the hardware model value of \(hwmodel)")
}

var boottime = timeval()
var sz = MemoryLayout<timeval>.size
sysctlbyname("kern.boottime", &boottime, &sz, nil, 0)
var dt = Date(timeIntervalSince1970: Double(boottime.tv_sec) + Double(boottime.tv_usec)/1_000_000.0)
print("Last boot time: \(dt)")

var mach4 = "kern.version".cString(using: .utf8)
sysctlbyname(mach4, nil, &size, nil, 0)
var machine4 = [CChar](repeating: 0, count: Int(size))
sysctlbyname(mach4, &machine4, &size, nil, 0)
print("Kernel Info: " + String(cString: machine4))

var mysize = 0
var sz2 = MemoryLayout<Int>.size
sysctlbyname("hw.memsize", &mysize, &sz2, nil, 0)
print("Memory: \(mysize)")

var mach5 = "machdep.cpu.brand_string".cString(using: .utf8)
sysctlbyname(mach5, nil, &size, nil, 0)
var machine5 = [CChar](repeating: 0, count: Int(size))
sysctlbyname(mach5, &machine5, &size, nil, 0)
print("Processor Info: " + String(cString: machine5))

let dev2 = IOServiceMatching("IOHIDSystem")
let usbinfo1 : io_service_t = IOServiceGetMatchingService(kIOMasterPortDefault, dev2)
let usbInfoAsString = IORegistryEntryCreateCFProperty(usbinfo1, kIOHIDIdleTimeKey as CFString, kCFAllocatorDefault, 0)
IOObjectRelease(usbinfo1)
let usbinfo2: CFTypeRef = usbInfoAsString!.takeUnretainedValue()
let idleTime = Int("\(usbinfo2)")
let idleTime2 = idleTime!/1000000000
print("Idle Time (no keyboard/mouse interaction) in seconds: \(idleTime2)")

var p = CGSessionCopyCurrentDictionary()!

let dict = p as? [String: AnyObject]
if dict!["CGSSessionScreenIsLocked"] != nil {
    print("[+] The screen IS currently locked!")
}
else {
    print("[-] The screen is NOT currently locked!")
}
