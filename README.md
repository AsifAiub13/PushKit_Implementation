# iOS_PushKit_Implementation (Tested on iOS 11)
Testing PushKit on iOS device:

1. Checkout the project.
2. Run it. Get ur device token from xcode  console : “DEVICE_TOKEN GENERATED! <xxxxxxxx xxxxxxxx xxxxxxxx xxxxxxxx xxxxxxxx xxxxxxxx xxxxxxxx>
3. Copy the token & remove “<“ “>” and spaces. It will look like this xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
4. Open terminal. Install houston by: sudo gem install -n /usr/local/bin houston
5. Make ur voip certificate from apple developer account. Download and save it.
6. Put the certificate in ur project directory, where the .xcodeproj sits.
7. Now open terminal. 
    1. cd <PROJECT_DIRECTORY>
    2. apn push “DEVICE_TOKEN” -c VOIP_CERFICATE_NAME.cer -m “YOUR_PUSH_TEXT”
8. Enjoy! ;)
