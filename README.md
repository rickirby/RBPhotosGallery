# RB_PhotoGallery_Core_iOS
Modular Framework for showing collection of photos. Scrollable horizontally like Photos native apps.

### How to use:
on Cartfile, add following lines:

git "git@bitbucket.org:rb-scando/rb_photogallery_core_ios.git" == *version-number*

Then "carthage update --use-ssh"

### Current version:
0.0.6

### Change Log
--- 0.0.1
    * First Release
    
--- 0.0.2
    * Add example apps
    * Change background color to clear
    * Add readme file
    
--- 0.0.3
    * Add always bounce horizontal to support bounce on only one photo
    
--- 0.0.4
    * Fix scroll to items on iOS 14 which not working
    
--- 0.0.5
    * Fix issue random scroll on 0.0.4 when user done editing document and back to open Gallery
    * Fix with workaround for iOS 14 which scrollToItems not working with isPagingEnabled is true
