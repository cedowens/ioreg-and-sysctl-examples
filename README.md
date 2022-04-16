# ioreg-and-sysctl-examples
Basic examples of programmatically interacting with ioreg and sysutil in Swift to query system information. This example queries the following information:

- Serial Number (IOServiceMatching query)
- Architecture Info (sysctlbyname query)
- Hardware Model (sysctlbyname query)
- Boot Time (sysctlbyname query)
- Kernel Version (sysctlbyname query)
- Memory (sysctlbyname query)
- Processor Info (sysctlbyname query)
- idle Time (IOServiceMatching query)
- Checking Whether The Screen is Locked (via CGSSessionCopyCurrentDictionary)

