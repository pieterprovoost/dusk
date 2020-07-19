import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    let menu = NSMenu()
    let menuItem = NSMenuItem()
    let slider = NSSlider()

    @objc func changeBrightness(_ sender: Any?) {
        let brightness = slider.intValue
        let process = Process()
        process.launchPath = "/bin/sh"
        process.arguments = ["-c", "/usr/local/bin/ddcctl -d 1 -b \(brightness)"]
        process.launch()
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("dusk_32"))
            button.setButtonType(NSButton.ButtonType.momentaryChange)
        }
        constructMenu()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

    func constructMenu() {
        slider.action = #selector(AppDelegate.changeBrightness(_:))
        slider.numberOfTickMarks = 11
        slider.allowsTickMarkValuesOnly = true
        slider.minValue = 0
        slider.maxValue = 100
        slider.setFrameSize(NSSize(width: 160, height: 20))
        menuItem.view = slider
        menu.addItem(menuItem)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        statusItem.menu = menu
    }

}
