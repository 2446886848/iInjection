//
//  AppDelegate.swift
//  AppSigner
//
//  Created by Daniel Radtke on 11/2/15.
//  Copyright © 2015 Daniel Radtke. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var mainView: MainView!
    let fileManager = FileManager.default
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        /*
        let sc = XSystemCommand();
        sc.rystemCommand("cd /Users/kjx/Desktop/Test &&unzip -o wexin.ipa && ./yololib  Payload/WeChat.app/WeXin  Payload/WeChat.app/libhookFile.dylib");
        */
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        
        try? fileManager.removeItem(atPath: Log.logName)
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    @IBAction func fixSigning(_ sender: NSMenuItem) {
        if let tempFolder = mainView.makeTempFolder() {
            iASShared.fixSigning(tempFolder)
            try? fileManager.removeItem(atPath: tempFolder)
            mainView.populateCodesigningCerts()
        }
    }

    @IBAction func nsMenuLinkClick(_ sender: NSMenuLink) {
        NSWorkspace.shared.open(URL(string: sender.url!)!)
    }
    @IBAction func viewLog(_ sender: AnyObject) {
        NSWorkspace.shared.openFile(Log.logName)
    }
    @IBAction func checkForUpdates(_ sender: NSMenuItem) {
        UpdatesController.checkForUpdate(forceShow: true)
        func updateCheckStatus(_ status: Bool, data: Data?, response: URLResponse?, error: Error?){
            if status == false {
                DispatchQueue.main.async {
                    let alert = NSAlert()

                    if error != nil {
                        alert.messageText = "There was a problem checking for a new version."
                        alert.informativeText = "More information is available in the application log."
                        Log.write(error!.localizedDescription)
                    } else {
                        alert.messageText = "You are currently running the latest version."
                    }
                    alert.runModal()
                }
            }
        }
        UpdatesController.checkForUpdate(forceShow: true, callbackFunc: updateCheckStatus)
    }
}

