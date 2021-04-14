*** Settings ***
Library     OperatingSystem
Library     AppiumLibrary
Resource    ../../Tests/Android/A_Import.robot

Suite Setup  Open App On Emulator
# Suite Setup  Launch Android App
Suite Teardown  Quit Android Application

# Complete Suite: 
# robot -d Results Tests/Android/A_Tests.robot
 
# Executing Specific Tag: 
# robot -d Results -i SL31 Tests/Android/A_Tests.robot
 
# To run specific test on browserstack:    
# robot --variable environmentToRunTest:Browserstack --variable browserstack_userName:browserstackmool1 --variable browserstack_accessKey:fbqx1hqxFBNeHGEfH1tW --variable appURL:bs://691e806da04c31df1138e84cbb5d377050bff8e3 -d Results -i SL34 Tests/Android/A_Tests.robot


*** Test Cases ***
# Verify Landing Screen
Verify Landing Screen Widgets Logo & Text
    [Tags]  SL01  Welcome 
    App logo & text is displayed at the top

#
Points on Security, Compliance and Recommendations in Landing Screen
    [Tags]  SL02  Welcome 
    Verify 3 points on Security, Compliance and Recommendations with icons are displayed
    Verify Heading for each point is displayed

Start Investing button is redirects to Sigin screen
    [Tags]  SL03  Welcome 
    User Navigates To Signin Screen

Switch between Sign In and Sign up by selecting provided links
    [Tags]  SL05  Signin
    User Navigates To Signin Screen
    User Clicks On Signup Link
    User Clicks On Signin Link 

Signin With Valid Login Credentials 
    [Tags]  SL06  Signin
    [Teardown]  Rest Android Application
    User Navigates To Signin Screen
    Signin With Valid Credentials - Funded Account

# Pre-req: To be executed after SL06
User Selects The Already Present Account In Easy Signin Page
    [Tags]  SL10  Signin
    [Teardown]  Rest Android Application
    User Navigates To Easy Signin Screen
    User Selects The Already Present Account In Easy Signin
    Verify Dashboard Screen

Signin As Different User Link In Easy Signin Page
    [Tags]  SL11  Signin
    User Navigates To Signin Screen

Signin With Invalid Login Credentials
    [Tags]  SL07  Signin
    User Navigates To Signin Screen
    Signin With Invalid Credentials

# Note: Error message is not verified, as discussed currently on low priority
Error Message On Empty Password Entered
    [Tags]  SL08 
    User Navigates To Signin Screen
    User Enters Only Email
    Click On Signin Button

# Note: Error message is not verified, as discussed currently on low priority
Error Message On Empty Email Entered
    [Tags]  SL09  
    User Navigates To Signin Screen
    User Enters Only Password
    Click On Signin Button

# Note: Error msg needs to be verified
Signin With Social Account - Apple With Invalid Login Credentials
    [Tags]  SL13  Signin
    [Teardown]  Rest Android Application
    User Navigates To Signin Screen
    Click On Continue With Apple Button
    Signin With Invalid Credentials - Apple

# Note: Issue- User is not navigating to Dashboard page. So, Dashboard screen is not verified
Google With Valid Login Credentials
    [Tags]  SL14  Signin
    [Teardown]  Rest Android Application
    User Navigates To Signin Screen
    Click On Continue With Google Button
    Signin With Valid Credentials - Google
    Verify Dashboard Screen

Google With Invalid Login Credentials
    [Tags]  SL15  Signin
    [Teardown]  Rest Android Application
    User Navigates To Signin Screen
    Click On Continue With Google Button
    Signin With Invalid Credentials - Google

#Pre-req: To be executed after SL15
Previously Loggedin Account Is Displayed In Google Social Signin
    [Tags]  SL18  Signin
    [Teardown]  Rest Android Application
    User Navigates To Signin Screen
    Click On Continue With Google Button
    Choose An Gmail Account From The Existing Accounts
    Verify Dashboard Screen

Facebook With Invalid Login Credentials
    [Tags]  SL17  Signin
    [Teardown]  Rest Android Application
    User Navigates To Signin Screen
    Click On Continue With Facebook Button
    Signin With Invalid Credentials - Facebook

Facebook With Valid Login Credentials
    [Tags]  SL16  Signin
    [Teardown]  Rest Android Application
    User Navigates To Signin Screen
    Click On Continue With Facebook Button
    Signin With Valid Credentials - Facebook
    Verify Dashboard Screen

Signup With New Email & Password
    [Tags]  SL23  Signup
    [Teardown]  Rest Android Application
    User Navigates To Signup Screen
    User Enters New Email Password & Signups
    Verify Dashboard Screen

Signup With Invalid EmailID 
    [Tags]  SL24  Signup
    [Teardown]  Rest Android Application
    User Navigates To Signup Screen
    New User Enters Invalid Email & Verify Error Message

Signup With Invalid EmailID - Only Domain Name
    [Tags]  SL25  Signup
    [Teardown]  Rest Android Application
    User Navigates To Signup Screen
    New User Enters Only Domain Name & Verify Error Message

Signup - Resend Code
    [Tags]  SL26  Signup
    [Teardown]  Rest Android Application
    User Navigates To Signup Screen
    User Enters New Email Password & Signups
    Click On Resend Code
    Verify Dashboard Screen

User Password Mismatches Password Criteria 
    [Tags]  SL27  Signup
    [Teardown]  Rest Android Application
    User Navigates To Signup Screen
    User Enters Invalid Password
    Verify Password Combination Criteria 

Signup With Existing Email & Verify Error Message
    [Tags]  SL29  Signup
    [Teardown]  Rest Android Application
    User Navigates To Signup Screen
    User Enters Existing Email Password & Signups

User Signups With Existing Google Account & Password  
    [Tags]  SL30  Signup
    [Teardown]  Rest Android Application
    User Navigates To Signup Screen
    User Enters Existing Google Account Password To Signup

#Blocker: OTP required
User Resets The Password
    [Tags]  SL_31  ForgotPassword
    [Teardown]  Rest Android Application
    User Navigates To Signin Screen
    User Updates Password

User Enters An Invalid Email Id In Forgot Password Validation Screen
    [Tags]  SL_32  ForgotPassword
    [Teardown]  Rest Android Application
    User Navigates To Signin Screen
    User Enters Invalid Email

User Enters Ivalid Code With Valid Password In Reset Password Screen
    [Tags]  SL_33  ForgotPassword
    [Teardown]  Rest Android Application
    User Navigates To Signin Screen
    User Enters Invalid Code For Password Reset

User Enters Different New And Confirm Passwords
    [Tags]  SL_36  ForgotPassword
    [Teardown]  Rest Android Application
    User Navigates To Signin Screen
    User Enters Different Passwords In Both Fields

#Blocker: Unable to inspect error popup
User Enters Only Code Without Password
    [Tags]  SL_37  ForgotPassword
    [Teardown]  Rest Android Application
    User Navigates To Signin Screen
    User Enters Only Code

Changed for committing