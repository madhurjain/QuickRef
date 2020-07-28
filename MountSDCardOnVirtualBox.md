## Mounting SD card in Virtual Box VM

********************************************************************************************************************
Answer for Windows 7 users

    Get the DeviceID of your SD card reader.

    You'll need a card in the drive, mounted by windows.

    Enter this command

    wmic diskdrive list brief

    It should look something like this:

    C:\Users\Sandy Scott>wmic diskdrive list brief
    Caption                      DeviceID            Model                        Partitions  Size
    WDC WD7500BPKT-75PK4T0       \\.\PHYSICALDRIVE0  WDC WD7500BPKT-75PK4T0       3           750153761280
    O2Micro SD SCSI Disk Device  \\.\PHYSICALDRIVE1  O2Micro SD SCSI Disk Device  1           3964584960

    The last device is the SD card reader, so the DeviceID is \\.\PHYSICALDRIVE1

    Create the link file to the SD card

    Open a command windows as Administrator

    "C:\Program Files\Oracle\VirtualBox\VBoxManage" internalcommands createrawvmdk -filename "%USERPROFILE%/Desktop/sdcard.vmdk" -rawdisk "\\.\PHYSICALDRIVE1"

    This assumes the default installation path - change it if you need to. (Ensure quotes are around the rawdisk argument.)

    The .vmdk file is a link to the SD card, you can put it anywhere on your host system, but this command just puts it on your desktop for convenience.

    Follow steps 4-6 in JinnKo's answer, the only minor tweak is that you need to start VirtualBox as an Administrator

        Next we attach the raw disk to a guest VM within the VirtualBox UI
            Ensure the guest VM is not running.
            Ensure VirtualBox is not running
            Start VirtualBox by right-clicking on it and choosing "Run as administrator"
            Open the settings area for the guest VM
            Click on "Storage" in the toolbar
            Next to the controller click on the icon to "Add Hard Disk"
            Select "Choose existing disk"
            Navigate to the /path/to/file.vmdk you used in step 3 and select it
            You should now be returned to the Storage tab and see your file.vmdk in the list.
        Start the VM
        Depending on whether you have a GUI or not the SD card may or may not automatically mount. If you need to mount is manually it is simply exposed as another standard block device, so on my guest this was exposed as /dev/sdb.

********************************************************************************************************************
