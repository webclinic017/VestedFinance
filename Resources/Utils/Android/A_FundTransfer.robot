*** Settings ***

Library     AppiumLibrary

***Keywords***

Signin With New Account- No Funding History
    Signin With Pin Credentials  ${e_emailNoFundHistory}  ${e_pwdNoFundHistory}  ${e_pinNoFundHistory}

Signin With KYC Approved Account For Online Transfer
    Signin With Pin Credentials  ${e_emailKycApprvTransfer}  ${e_pwdKycApprvTransfer}  ${e_pinKycApprvTransfer}

Signin With KYC Approved Premium Account For 1st Withdrawal
    Signin With Pin Credentials  ${e_emailKycApprvWithdrwl}  ${e_pwdKycApprvWithdrwl}  ${e_pinKycApprvWithdrwl}

Verify Transfer Landing Screen
    Wait For Page Conatin Element  ${e_cashBalance}  5s
    Verify Page Conatin Text  ${e_cashBalance}

Verify Fund Transfer Screen For New Account With No Funding History
    Page Should Not Contain Text  ${e_incmpltDeposits}
    Page Should Not Contain Text  ${e_pendingTransfers}
    Page Should Not Contain Text  ${e_cmpltedTransfers}
    Verify Transfer Landing Screen
    Verify Page Conatin Text  ${e_0CashAmt}
    Log to Console  Verified Cash Balance- $0.00
    Verify Element Visibility  ${vf_A_addFundsBtn}
    Verify Element Visibility  ${vf_A_withdrawalFundsBtn}
    Verify Element Visibility  ${vf_A_imgInTransfer}
    Log to Console  Verified Fund Transfer Screen For New Account With No Funding History!


Swipe Until Completed Transfer Section
    FOR  ${i}  IN RANGE  1  50
        ${isElementVisible} =  Run Keyword And Return Status  Verify Page Conatin Text  ${e_completedTransfers}
        IF   ${isElementVisible}
            Exit For Loop If   ${isElementVisible}
        ELSE
            Swipe By Percent  80  80   20   20  2000
        END
    END

Swipe Until Pending Transfer Section
    FOR  ${i}  IN RANGE  1  50
        ${isElementVisible} =  Run Keyword And Return Status  Verify Page Conatin Text  ${e_pendingTransfers}
        IF   ${isElementVisible}
            Exit For Loop If   ${isElementVisible}
        ELSE
            Swipe By Percent  80  80   20   20  2000
        END
    END


User Navigates To Fund Transfer Page And Check Deposit Status
    Click On Tansfer From Dashboard
    Log to Console  Transfer Clicked
    Element Should Be Visible   ${vf_A_addFundsBtn}
    Log to Console  Add funds button verified
    Verify Page Conatin Text   ${e_withdrawFunds}
    Log to Console  Withdraw funds button verified
    Verify Page Conatin Text   ${e_cashBalance}
    Log to Console  Cash balance text verified
    # Incomplete deposits
    Verify Page Conatin Text   ${e_incompleteDeposits}
    Log to Console  Incomplete deposits text verified
    Verify Page Conatin Text   ${e_continue}
    Log to Console  Continue text verified
    Verify Page Conatin Text   ${e_remove}
    Log to Console  Remove text verified
    Swipe Until Pending Transfer Section
    Swipe By Percent  80  80   20   20  2000
    # Pending transaction
    Verify Page Conatin Text   ${e_pendingTransfers}
    Log to Console  Pending Transfers text verified
    Verify Page Conatin Text   ${e_deposit}
    Log to Console  Deposit text verified
    Verify Page Conatin Text   ${e_pendingTransfersTxt}
    Log to Console  Pending Transfers processing text verified
    Swipe Until Completed Transfer Section
    Swipe By Percent  80  80   20   20  2000
    # Completed transfer
    Verify Page Conatin Text   ${e_completedTransfers}
    Log to Console  Completed transfers text verified
    Verify Page Conatin Text   ${e_depositCancelled}
    Log to Console  Deposit Cancelled text verified
    

User Adds Funds With Pre-selected Bank
    Click On Tansfer From Dashboard
    Element Should Be Visible   ${vf_A_addFundsBtn}
    Log to Console  Add funds button verified
    Wait And Click Element On Android  ${vf_A_addFundsBtn}
    Wait For Page Conatin Element  ${e_addFundsHeading}  5s
    Verify Page Conatin Text   ${e_amtToTransfer}
    Verify Page Conatin Text   ${e_transferFrom}
    Verify Page Conatin Text   ${e_switchBank}
    Click Text  ${e_switchBank}
    Wait For Page Conatin Element  ${e_selectYourBank}  5s
    Verify Page Conatin Text   ${e_slctBankTxt}
    Verify Page Conatin Text   ${e_slctBankNote}
    Verify Page Conatin Text   ${e_indian}
    Verify All Bank Names

User Adds Funds By Choosing A Bank From List
    Click On Tansfer From Dashboard
    Element Should Be Visible   ${vf_A_addFundsBtn}
    Log to Console  Add funds button verified
    Wait And Click Element On Android  ${vf_A_addFundsBtn}
    Wait For Page Conatin Element  ${e_addFundsHeading}  5s
    Verify Page Conatin Text   ${e_amtToTransfer}
    Verify Page Conatin Text   ${e_transferFrom}
    Verify Page Conatin Text   ${e_switchBank}
    Click Text  ${e_switchBank}
    Wait For Page Conatin Element  ${e_selectYourBank}  15s
    Verify Page Conatin Text   ${e_slctBankTxt}
    Verify Page Conatin Text   ${e_slctBankNote}
    Verify Page Conatin Text   ${e_indian}
    Verify All Bank Names
    Swipe By Percent  20  20   80   80  2000
    Click Text  ${e_HSBCBank}


# Add Funds

Click On Tansfer From Dashboard
    Wait And Click Element On Android  ${vf_A_transfer}
    Verify Transfer Landing Screen
    Log to Console  Navigated to Transfer Landing Screen

Click On Next Button Under Add Funds Flow
    Wait And Click Element On Android  ${vf_A_nextBtn}

Verify Add Funds For Non KYC Approved Account
    Wait And Click Element On Android  ${vf_A_addFundsBtn}
    Wait For Page Conatin Element  ${e_kycApprovalNeededPopup}  5s
    Verify Page Conatin Text  ${e_kycApprovalNeededPopup}
    Verify Page Conatin Text  ${e_kycApprovalNeededPopupTxt1}
    Verify Page Conatin Text  ${e_kycApprovalNeededPopupTxt2}
    Verify Element Visibility  ${vf_A_notNowBtn}
    Verify Page Conatin Text  ${e_checkStatusBtn}
    Wait And Click Element On Android  ${vf_A_notNowBtn}
    Log to Console  Verified Add Funds For Non KYC Approved Account!

Click On Switch Bank Link And Select A Bank
    [Arguments]  ${bank}  ${fundOnlineTxt}
    Click Text  ${e_switchBankLink}
    Wait For Page Conatin Element  ${e_selectYourBankHeading}  5s
    Verify Page Conatin Text  ${e_selectYourBankHeading}
    Verify Page Conatin Text  ${e_selectYourBankDesc1}
    Verify Page Conatin Text  ${e_selectYourBankDesc2}
    Verify Page Conatin Text  ${e_indianBankOpts}
    Verify Element Visibility  ${fundOnlineTxt}
    Click Text  ${bank}
    Log To Console  Selected Bank - ${bank}
    Wait For Page Conatin Element  ${bank}  5s
    Verify Page Conatin Text  ${bank}

Fill Deposit Screen
    Wait For Page Conatin Element  ${e_howMuchDepositTxt}  5s
    Verify Page Conatin Text  ${e_howMuchDepositTxt}
    Verify Page Conatin Text  ${e_amtToTransferTxt}
    Verify Page Conatin Text  ${e_$Txt}
    Input Text  ${vf_A_amtTxtBox}  ${e_amtToTransfer}
    Verify Page Conatin Text  ${e_transferFromTxt}

Click On Continue Button Under Fund Transfer
    Sleep  2s
    Wait And Click Element On Android  ${vf_A_continueBtnUnderFT}

Verify User Is Navigated To Fund Online Using ICICI Screen
    Wait For Page Conatin Element  ${e_fundOnlineUsingICICI}  5s
    Verify Page Conatin Text  ${e_fundOnlineUsingICICI}

Verify Fund Online Screen
    Verify Page Conatin Text  ${e_fundOnlineUsingICICI}
    Verify Page Conatin Text  ${e_selectDiffFundTransfer}
    Verify Page Conatin Text  ${e_importantTxt}
    Verify Page Conatin Text  ${e_importantP1}
    Verify Page Conatin Text  ${e_importantP2}
    Verify Page Conatin Text  ${e_feesTxt}
    Verify Page Conatin Text  ${e_feesP1}
    Verify Page Conatin Text  ${e_dwnldInstrctnsBtn}
    Log to Console  Verified Fund Online Screen!

Verify New Entry Created Under Incomplete Deposits
    [Arguments]  ${step}
    Verify Page Conatin Text  ${e_incmpltDeposits}
    Verify Page Conatin Text  ${e_amtToTransfer}
    Verify Page Conatin Text  ${step}
    ${todaysDate} =  Get Current Date On Android   
    Verify Page Conatin Text  ${todaysDate}
    Verify Element Visibility  ${vf_A_continueBtnUnderFT}
    Verify Element Visibility  ${vf_A_removeBtn}
    Log to Console  Verified new entry created under Incomplete Deposits!

Verify User Is Navigated To Upload The Wire Receipt Screen
    Wait For Page Conatin Element  ${e_uploadWireReceipt}  5s
    Verify Page Conatin Text  ${e_uploadWireReceipt}

Upload Wire Receipt And Verify Success Message
    Wait And Click Element On Android  ${vf_A_chooseFromLib}
    #For Local Device
    # Wait And Click Element On Android  ${vf_A_driversLicenseBackImg}
    #For BrowserStack
    Wait And Click Element On Android  ${vf_A_hamburgerMenu}
    Wait And Click Element On Android  ${vf_A_photosSubMenu}
    Wait For Page Conatin Element  ${e_selectAPhoto}  5s
    Wait And Click Element On Android  ${vf_A_picturesFolder}
    Wait For Page Conatin Element  ${e_selectAPhoto}  5s
    Verify Page Conatin Text   ${e_selectAPhoto}
    Sleep  3s
    Wait And Click Element On Android  ${vf_A_sampleImgOnBS}
    Wait For Page Conatin Element  ${e_receiptUploadSuccessMsg}  10s
    Verify Page Conatin Text  ${e_receiptUploadSuccessMsg}
    Verify Page Conatin Text  ${e_reUploadRecTxt}
    Log To Console  Uploaded Wire Receipt

Verify And Fill The Upload Wire Receipt Received Screen
    Verify Page Conatin Text  ${e_uploadWireReceiptNote}
    Verify Page Conatin Text  ${e_yourReceiptTxt}
    Verify Page Conatin Text  ${e_yourFullName}
    Verify Page Conatin Text  ${e_yourDriveWealthTxt}
    Verify Page Conatin Text  ${e_bankName}
    Verify Page Conatin Text  ${e_iciciUnderBankName}
    Verify Page Conatin Text  ${e_amtInUSDTxt}
    Verify Page Conatin Text  ${e_amtToTransfer}
    Swipe By Percent  70  70  20  20  5000
    Verify Page Conatin Text  ${e_dateOnWireReceiptTxt}
    Click Text  ${e_selectDateTxt}
    Click Text  ${e_calenderOkBtn}
    Verify Page Conatin Text  ${e_pwdForPdfTxt}
    Verify Page Conatin Text  ${e_enterPwdTxt}
    Verify Page Conatin Text  ${e_leaveBlankTxt}
    Verify Page Conatin Text  ${e_incmpltTransferTxt}
    Click Text  ${e_uploadWireReceiptBtn}
    Upload Wire Receipt And Verify Success Message
    # Test_on_Real img on BS device- 
    Log to Console  Verified, Filled & Uploaded the Wire Receipt for Transfer

Fill And Remove A Fund Transfer
    Wait And Click Element On Android  ${vf_A_addFundsBtn}
    Fill Deposit Screen
    Sleep  3s
    Click On Next Button Under Add Funds Flow
    Verify User Is Navigated To Fund Online Using ICICI Screen
    Wait And Click Element On Android  ${vf_A_CloseIcon}
    Log to Console  Clicked on Close icon under Fund Online Using ICICI screen
    Verify Transfer Landing Screen
    Verify New Entry Created Under Incomplete Deposits  ${e_2stepToGo}
    Click On Continue Button Under Fund Transfer
    Verify User Is Navigated To Fund Online Using ICICI Screen
    Log to Console  User is returned to step 2 of the fund transfer process
    Verify Fund Online Using ICICI Screen
    Wait And Click Element On Android  ${vf_A_nextBtnUndrFundOnline}
    Verify User Is Navigated To Upload The Wire Receipt Screen
    Wait And Click Element On Android  ${vf_A_CloseIcon}
    Log to Console  Clicked on Close icon under Upload the Wire Receipt Screen
    Verify Transfer Landing Screen
    Verify New Entry Created Under Incomplete Deposits  ${e_1stepToGo}
    Click On Continue Button Under Fund Transfer
    Verify User Is Navigated To Upload The Wire Receipt Screen
    Wait And Click Element On Android  ${vf_A_CloseIcon}
    Log to Console  Clicked on Close icon under Upload the Wire Receipt Screen
    Wait And Click Element On Android  ${vf_A_removeBtn}
    Wait For Page Conatin Element  ${e_removeDepositTxt}  10s
    Verify Page Conatin Text  ${e_removeDepositTxt}
    Verify Page Conatin Text  ${e_yesBtn}
    Verify Page Conatin Text  ${e_noBtn} 
    Click Text  ${e_yesBtn}
    ${isElementVisible} =  Run Keyword And Return Status  Verify New Entry Created Under Incomplete Deposits  ${e_1stepToGo}
    IF   ${isElementVisible}  
        Log to Console  Incomplete Transfer is still present in the list
    ELSE   
        Log to Console  Removed Incomplete Transfer from the list
    END

Fill And Submit A Fund Transfer- ICICI Bank Online
    Wait And Click Element On Android  ${vf_A_addFundsBtn}
    Fill Deposit Screen
    Click On Switch Bank Link And Select A Bank  ${e_iciciBankOpt}  ${vf_A_fundOnlineTxtUnderICICI}
    Sleep  3s
    Click On Next Button Under Add Funds Flow
    Verify User Is Navigated To Fund Online Using ICICI Screen
    Verify Fund Online Screen
    # select different method
    # verify content 2 pts
    Wait And Click Element On Android  ${vf_A_nextBtnUndrFundOnline}
    Verify User Is Navigated To Upload The Wire Receipt Screen
    Verify And Fill The Upload Wire Receipt Received Screen
    Click Text  ${e_submitBtn}
    Verify Success Screen After Transaction Is Submited Successfully
    Click Text  ${e_backToDashbrdBtnSccsTransfer}
    Verify Dashboard Screen

# Withdrawal Funds

Click On Withdrawal Funds Button
    Wait And Click Element On Android  ${vf_A_withdrawalFundsBtn}

Verify Withdrawal Funds For Non KYC Approved Account
    Click On Withdrawal Funds Button
    Wait For Page Conatin Element  ${e_kycApprovalNeededPopup}  5s
    Verify Page Conatin Text  ${e_kycApprovalNeededPopup}
    Verify Page Conatin Text  ${e_kycApprovalNeededPopupTxt1}
    Verify Page Conatin Text  ${e_kycApprovalNeededPopupTxt3}
    Verify Element Visibility  ${vf_A_notNowBtn}
    Verify Page Conatin Text  ${e_checkStatusBtn}
    Wait And Click Element On Android  ${vf_A_notNowBtn}
    Log to Console  Verified Withdrawal Funds For Non KYC Approved Account!

Verify Content In Withdrawal Process Screen
    Wait For Page Conatin Element  ${e_withdrawalProcess}  5s
    Verify Page Conatin Text  ${e_withdrawalProcess}
    Verify Page Conatin Text  ${e_settledCash}
    Verify Page Conatin Text  ${e_amtToWithdraw}
    Verify Element Visibility  ${vf_A_amtTxtBox}
    Verify Page Conatin Text  ${e_proceedBtn}

Click On Withdraw Funds And Verify Withdrawal Amount Screen
    Click On Withdrawal Funds Button
    Verify Content In Withdrawal Process Screen
    Verify Page Conatin Text  ${e_settledCashAmt}
    Verify Page Conatin Text  ${e_withdrawProcessNote}
    Verify Page Conatin Text  ${e_wtdrwPrcsBtn}
    Log to Console  Verified Withdrawal Amount Screen!

Verify First Withdrawal
    Click On Withdrawal Funds Button
    Verify Content In Withdrawal Process Screen
    Page Should Not Contain Text  ${e_withdrawProcessNote}
    Log to Console  Verified First Withdrawal Amount Screen!

Verify Withdrawal Amount Field Validation 
    Verify Element Visibility  ${vf_A_amtTxtBox}
    Click Text  ${e_proceedBtn}
    Wait For Page Conatin Element  ${e_proceedError}  5s
    Verify Page Conatin Text   ${e_proceedError}
    Clear Text  ${vf_A_amtTxtBox}
    Input Text  ${vf_A_amtTxtBox}  ${e_11amtToWithdraw} 
    Click Text  ${e_proceedBtn}
    Wait For Page Conatin Element  ${e_11amtToWithdrawErrMsg}  5s
    Verify Page Conatin Text  ${e_11amtToWithdrawErrMsg}
    Clear Text  ${vf_A_amtTxtBox}
    Input Text  ${vf_A_amtTxtBox}  ${e_9amtToWithdraw} 
    Click Text  ${e_proceedBtn}
    Wait For Page Conatin Element  ${e_11amtToWithdrawErrMsg}  5s
    Verify Page Conatin Text  ${e_11amtToWithdrawErrMsg}
    Clear Text  ${vf_A_amtTxtBox}
    Input Text  ${vf_A_amtTxtBox}  ${e_spclCharAmtToWithdraw} 
    Click Text  ${e_proceedBtn}
    Wait For Page Conatin Element  ${e_spclCharAmtToWithdrawErrMsg}  5s
    Verify Page Conatin Text  ${e_spclCharAmtToWithdrawErrMsg}
    Clear Text  ${vf_A_amtTxtBox}
    Input Text  ${vf_A_amtTxtBox}  ${e_15amtToWithdraw} 
    Click Text  ${e_proceedBtn}
    Wait For Page Conatin Element  ${e_withdrwlDetails}  5s
    Verify Page Conatin Text  ${e_withdrwlDetails}
    Log to Console  Verified all Validations for Withdrawal Amount!
    
Verify Second Withdrawal
    Click On Withdrawal Funds Button
    Verify Content In Withdrawal Process Screen
    Verify Page Conatin Text   ${e_withdrawProcessNote}
    Log to Console  Verified Second Withdrawal Amount Screen!

Verify All Bank Names
    Verify Page Conatin Text   ${e_AxisBank}
    Verify Page Conatin Text   ${e_ICICIBank}
    Verify Page Conatin Text   ${e_HDFCBank}
    Verify Page Conatin Text   ${e_IDFCBank}
    Verify Page Conatin Text   ${e_InduslndBank}
    Verify Page Conatin Text   ${e_KotakBank}
    Swipe By Percent  90  90  10  10  3000
    Verify Page Conatin Text   ${e_YesBank}
    Verify Page Conatin Text   ${e_BankOfBaroda}
    Verify Page Conatin Text   ${e_CitiBank}
    Verify Page Conatin Text   ${e_HSBCBank}
    Verify Page Conatin Text   ${e_SBI}
    Verify Page Conatin Text   ${e_PNB}
    Verify Page Conatin Text   ${e_OtherBank}
    Verify Page Conatin Text   ${e_international}
    Verify Page Conatin Text   ${e_nonIndianBank}


# Visit The Bank Scenarios

Click On Switch Bank Link And Select A Bank For Deposit
    [Arguments]  ${bank}
    Click Text  ${e_switchBankLink}
    Wait For Page Conatin Element  ${e_selectYourBankHeading}  5s
    Verify Page Conatin Text  ${e_selectYourBankHeading}
    Verify Page Conatin Text  ${e_selectYourBankDesc1}
    Verify Page Conatin Text  ${e_selectYourBankDesc2}
    Verify Page Conatin Text  ${e_indianBankOpts}
    FOR  ${i}  IN RANGE  1  3
        ${isElementVisible} =  Run Keyword And Return Status  Verify Page Conatin Text  ${bank}
        IF   ${isElementVisible}
            Click Text  ${bank}
            Log To Console  Selected Bank - ${bank}
            Exit For Loop If    ${isElementVisible}
        ELSE
            Swipe By Percent  80  80  20  20  3000
        END
    END
    Wait For Page Conatin Element  ${bank}  5s
    Verify Page Conatin Text  ${bank}

Verify Fund Online Screen - Visit The Bank
    Wait For Page Conatin Element  ${e_selectDiffFundTransfer}  10s
    Verify Page Conatin Text  ${e_selectDiffFundTransfer}
    Verify Page Conatin Text  ${e_importantTxt}
    Verify Page Conatin Text  ${e_importantP1}
    Verify Page Conatin Text  ${e_importantP2}
    Verify Page Conatin Text  ${e_feesTxt}
    Verify Page Conatin Text  ${e_feesP1}
    Verify Page Conatin Text  ${e_dwnldInstrctnsBtn}
    Log to Console  Verified Fund Online Screen!

Switch to Fund In-Persom With Bank Method
    Click Text  ${e_selectDiffFundTransfer}
    Wait For Page Conatin Element   ${e_fundInpersonWithBank}  5s
    Click Text  ${e_fundInpersonWithBank}
    Wait For Page Conatin Element   ${e_VTBTxt1}  5s
    Verify Page Conatin Text   ${e_VTBTxt1}
    Verify Page Conatin Text   ${e_VTBTxt1}

Verify Fund Online Screen - Visit The Bank - Direct Method
    Wait For Page Conatin Element  ${e_fundInpersonWithBank}  10s
    Verify Page Conatin Text  ${e_fundInpersonWithBank}
    Verify Page Conatin Text  ${e_importantTxt}
    Verify Page Conatin Text  ${e_importantP1}
    Verify Page Conatin Text  ${e_importantP2}
    Verify Page Conatin Text  ${e_feesTxt}
    Verify Page Conatin Text  ${e_feesP1}
    Log to Console  Verified Fund Online Screen!

Switch to Fund In-Persom With Bank Method - Direct Method
    Wait For Page Conatin Element   ${e_fundInpersonWithBank}  5s
    Click Text  ${e_fundInpersonWithBank}
    Wait For Page Conatin Element   ${e_VTBTxt1}  5s
    Verify Page Conatin Text   ${e_VTBTxt1}
    Verify Page Conatin Text   ${e_VTBTxt1}

Email Forms To The Registered Email Id
    Wait For Element Visibility On Android   ${vf_A_emailFormsBtn}
    Element Should Be Enabled  ${vf_A_emailFormsBtn}
    Wait And Click Element On Android  ${vf_A_emailFormsBtn}
    Wait For Page Conatin Element  ${e_emailSentText}  5s
    Verify Page Conatin Text   ${e_emailSentText}
    Verify Page Conatin Text   ${e_sendAgain}

Verify And Fill The Upload Wire Receipt Received Screen - Visit The Bank
    [Arguments]  ${bank}
    Verify Page Conatin Text  ${e_uploadWireReceiptNote}
    Verify Page Conatin Text  ${e_yourReceiptTxt}
    Verify Page Conatin Text  ${e_yourFullName}
    Verify Page Conatin Text  ${e_yourDriveWealthTxt}
    Verify Page Conatin Text  ${e_bankName}
    Verify Page Conatin Text  ${bank}
    Verify Page Conatin Text  ${e_amtInUSDTxt}
    Swipe By Percent  90  90  10  10  3000
    Verify Page Conatin Text  ${e_dateOnWireReceiptTxt}
    Click Text  ${e_selectDateTxt}
    Wait For Page Conatin Element  ${e_calenderOkBtn}  5s
    Click Text  ${e_calenderOkBtn}
    Verify Page Conatin Text  ${e_pwdForPdfTxt}
    Verify Page Conatin Text  ${e_enterPwdTxt}
    Verify Page Conatin Text  ${e_leaveBlankTxt}
    Verify Page Conatin Text  ${e_incmpltTransferTxt}
    Click Text  ${e_uploadWireReceiptBtn}
    Upload Wire Receipt And Verify Success Message
    # Test_on_Real img on BS device- 
    Log to Console  Verified, Filled & Uploaded the Wire Receipt for Transfer

Verify Success Screen After Transaction Is Submited Successfully
    Wait For Page Conatin Element  ${e_submitTransferSuccessMsg}  10s
    Verify Page Conatin Text  ${e_submitTransferSuccessMsg}
    Verify Page Conatin Text  ${e_amtToTransferTxt}
    Verify Page Conatin Text  ${e_submitTransferSuccessMsg}
    Verify Page Conatin Text  ${e_submitTransferSuccessTxt}
    Verify Page Conatin Text  ${e_backToDashbrdBtnSccsTransfer}
    Log to Console  Verified Success screen after Transaction is submited successfully!



User Visits Axis Bank For Funding
    Click On Tansfer From Dashboard
    Sleep  2s
    Wait And Click Element On Android  ${vf_A_addFundsBtn}
    Fill Deposit Screen
    Click On Switch Bank Link And Select A Bank For Deposit  ${e_AxisBank}
    Click On Next Button Under Add Funds Flow
    Verify Fund Online Screen - Visit The Bank
    Switch to Fund In-Persom With Bank Method
    Email Forms To The Registered Email Id
    Wait And Click Element On Android  ${vf_A_nextBtnUndrFundOnline}
    Verify And Fill The Upload Wire Receipt Received Screen - Visit The Bank  ${e_AxisBank1}
    Wait For Element Visibility On Android  ${vf_A_submit}  
    Wait And Click Element On Android  ${vf_A_submit}
    Log to Console  Submit button clicked
    Verify Success Screen After Transaction Is Submited Successfully
    Click Text  ${e_backToDashbrdBtnSccsTransfer}
    Verify Dashboard Screen


User Visits ICICI Bank For Funding
    Click On Tansfer From Dashboard
    Sleep  2s
    Wait And Click Element On Android  ${vf_A_addFundsBtn}
    Fill Deposit Screen
    Click On Switch Bank Link And Select A Bank For Deposit  ${e_ICICIBank}
    Click On Next Button Under Add Funds Flow
    Verify Fund Online Screen - Visit The Bank
    Switch to Fund In-Persom With Bank Method
    Email Forms To The Registered Email Id
    Wait And Click Element On Android  ${vf_A_nextBtnUndrFundOnline}
    Verify And Fill The Upload Wire Receipt Received Screen - Visit The Bank  ${e_ICICIBank1}
    Wait For Element Visibility On Android  ${vf_A_submit}  
    Wait And Click Element On Android  ${vf_A_submit}
    Log to Console  Submit button clicked
    Verify Success Screen After Transaction Is Submited Successfully
    Click Text  ${e_backToDashbrdBtnSccsTransfer}
    Verify Dashboard Screen

User Visits HDFC Bank For Funding
    Click On Tansfer From Dashboard
    Sleep  2s
    Wait And Click Element On Android  ${vf_A_addFundsBtn}
    Fill Deposit Screen
    Click On Switch Bank Link And Select A Bank For Deposit  ${e_HDFCBank}
    Click On Next Button Under Add Funds Flow
    Verify Fund Online Screen - Visit The Bank
    Switch to Fund In-Persom With Bank Method
    Email Forms To The Registered Email Id
    Wait And Click Element On Android  ${vf_A_nextBtnUndrFundOnline}
    Verify And Fill The Upload Wire Receipt Received Screen - Visit The Bank  ${e_HDFCBank1}
    Wait For Element Visibility On Android  ${vf_A_submit}  
    Wait And Click Element On Android  ${vf_A_submit}
    Log to Console  Submit button clicked
    Verify Success Screen After Transaction Is Submited Successfully
    Click Text  ${e_backToDashbrdBtnSccsTransfer}
    Verify Dashboard Screen

User Visits Kotak Bank For Funding
    Click On Tansfer From Dashboard
    Sleep  2s
    Wait And Click Element On Android  ${vf_A_addFundsBtn}
    Fill Deposit Screen
    Click On Switch Bank Link And Select A Bank For Deposit - Kotak Bank
    Click On Next Button Under Add Funds Flow
    Verify Fund Online Screen - Visit The Bank
    Switch to Fund In-Persom With Bank Method
    Email Forms To The Registered Email Id
    Wait And Click Element On Android  ${vf_A_nextBtnUndrFundOnline}
    Verify And Fill The Upload Wire Receipt Received Screen - Visit The Bank  ${e_KotakBank1}
    Wait For Element Visibility On Android  ${vf_A_submit}  
    Wait And Click Element On Android  ${vf_A_submit}
    Log to Console  Submit button clicked
    Verify Success Screen After Transaction Is Submited Successfully
    Click Text  ${e_backToDashbrdBtnSccsTransfer}
    Verify Dashboard Screen

Click On Switch Bank Link And Select A Bank For Deposit - Kotak Bank
    Click Text  ${e_switchBankLink}
    Wait For Page Conatin Element  ${e_selectYourBankHeading}  5s
    Verify Page Conatin Text  ${e_selectYourBankHeading}
    Verify Page Conatin Text  ${e_selectYourBankDesc1}
    Verify Page Conatin Text  ${e_selectYourBankDesc2}
    Verify Page Conatin Text  ${e_indianBankOpts}
    Click Text  ${e_KotakBank}
    Log To Console  Selected Bank - ${e_KotakBank}
    Wait For Page Conatin Element  ${e_KotakBankFull}  5s
    Verify Page Conatin Text  ${e_KotakBankFull}

User Visits Yes Bank For Funding
    Click On Tansfer From Dashboard
    Sleep  2s
    Wait And Click Element On Android  ${vf_A_addFundsBtn}
    Fill Deposit Screen
    Click On Switch Bank Link And Select A Bank For Deposit  ${e_YesBank}
    Click On Next Button Under Add Funds Flow
    Verify Fund Online Screen - Visit The Bank - Direct Method
    Switch to Fund In-Persom With Bank Method - Direct Method
    Email Forms To The Registered Email Id
    Wait And Click Element On Android  ${vf_A_nextBtnUndrFundOnline}
    Verify And Fill The Upload Wire Receipt Received Screen - Visit The Bank  ${e_YesBank1}
    Wait For Element Visibility On Android  ${vf_A_submit}  
    Wait And Click Element On Android  ${vf_A_submit}
    Log to Console  Submit button clicked
    Verify Success Screen After Transaction Is Submited Successfully
    Click Text  ${e_backToDashbrdBtnSccsTransfer}
    Verify Dashboard Screen

User Visits Bank Of Baroda For Funding
    Click On Tansfer From Dashboard
    Sleep  2s
    Wait And Click Element On Android  ${vf_A_addFundsBtn}
    Fill Deposit Screen
    Click On Switch Bank Link And Select A Bank For Deposit  ${e_BankOfBaroda}
    Click On Next Button Under Add Funds Flow
    Verify Fund Online Screen - Visit The Bank - Direct Method
    Switch to Fund In-Persom With Bank Method - Direct Method
    Email Forms To The Registered Email Id
    Wait And Click Element On Android  ${vf_A_nextBtnUndrFundOnline}
    Verify And Fill The Upload Wire Receipt Received Screen - Visit The Bank  ${e_BankOfBaroda1}
    Wait For Element Visibility On Android  ${vf_A_submit}  
    Wait And Click Element On Android  ${vf_A_submit}
    Log to Console  Submit button clicked
    Verify Success Screen After Transaction Is Submited Successfully
    Click Text  ${e_backToDashbrdBtnSccsTransfer}
    Verify Dashboard Screen

User Visits Citi Bank For Funding
    Click On Tansfer From Dashboard
    Sleep  2s
    Wait And Click Element On Android  ${vf_A_addFundsBtn}
    Fill Deposit Screen
    Click On Switch Bank Link And Select A Bank For Deposit - Citi Bank
    Click On Next Button Under Add Funds Flow
    Verify Fund Online Screen - Visit The Bank - Direct Method
    Switch to Fund In-Persom With Bank Method - Direct Method
    Email Forms To The Registered Email Id
    Wait And Click Element On Android  ${vf_A_nextBtnUndrFundOnline}
    Verify And Fill The Upload Wire Receipt Received Screen - Visit The Bank  ${e_CitiBank1}
    Wait For Element Visibility On Android  ${vf_A_submit}  
    Wait And Click Element On Android  ${vf_A_submit}
    Log to Console  Submit button clicked
    Verify Success Screen After Transaction Is Submited Successfully
    Click Text  ${e_backToDashbrdBtnSccsTransfer}
    Verify Dashboard Screen

Click On Switch Bank Link And Select A Bank For Deposit - Citi Bank
    Click Text  ${e_switchBankLink}
    Wait For Page Conatin Element  ${e_selectYourBankHeading}  5s
    Verify Page Conatin Text  ${e_selectYourBankHeading}
    Verify Page Conatin Text  ${e_selectYourBankDesc1}
    Verify Page Conatin Text  ${e_selectYourBankDesc2}
    Verify Page Conatin Text  ${e_indianBankOpts}
    Swipe By Percent  90  90  10  10  3000
    Click Text  ${e_CitiBank}
    Log To Console  Selected Bank - ${e_CitiBank}
    Wait For Page Conatin Element  ${e_CitiBankFull}  5s
    Verify Page Conatin Text  ${e_CitiBankFull}

User Visits HSBC Bank For Funding
    Click On Tansfer From Dashboard
    Sleep  2s
    Wait And Click Element On Android  ${vf_A_addFundsBtn}
    Fill Deposit Screen
    Click On Switch Bank Link And Select A Bank For Deposit  ${e_HSBCBank}
    Click On Next Button Under Add Funds Flow
    Verify Fund Online Screen - Visit The Bank - Direct Method
    Switch to Fund In-Persom With Bank Method - Direct Method
    Email Forms To The Registered Email Id
    Wait And Click Element On Android  ${vf_A_nextBtnUndrFundOnline}
    Verify And Fill The Upload Wire Receipt Received Screen - Visit The Bank  ${e_HSBCBank1}
    Wait For Element Visibility On Android  ${vf_A_submit}  
    Wait And Click Element On Android  ${vf_A_submit}
    Log to Console  Submit button clicked
    Verify Success Screen After Transaction Is Submited Successfully
    Click Text  ${e_backToDashbrdBtnSccsTransfer}
    Verify Dashboard Screen

User Visits State Bank Of India For Funding
    Click On Tansfer From Dashboard
    Sleep  2s
    Wait And Click Element On Android  ${vf_A_addFundsBtn}
    Fill Deposit Screen
    Click On Switch Bank Link And Select A Bank For Deposit - SBI Bank
    Click On Next Button Under Add Funds Flow
    Verify Fund Online Screen - Visit The Bank - Direct Method
    Switch to Fund In-Persom With Bank Method - Direct Method
    Email Forms To The Registered Email Id
    Wait And Click Element On Android  ${vf_A_nextBtnUndrFundOnline}
    Verify And Fill The Upload Wire Receipt Received Screen - Visit The Bank  ${e_SBI1}
    Wait For Element Visibility On Android  ${vf_A_submit}  
    Wait And Click Element On Android  ${vf_A_submit}
    Log to Console  Submit button clicked
    Verify Success Screen After Transaction Is Submited Successfully
    Click Text  ${e_backToDashbrdBtnSccsTransfer}
    Verify Dashboard Screen

Click On Switch Bank Link And Select A Bank For Deposit - SBI Bank
    Click Text  ${e_switchBankLink}
    Wait For Page Conatin Element  ${e_selectYourBankHeading}  5s
    Verify Page Conatin Text  ${e_selectYourBankHeading}
    Verify Page Conatin Text  ${e_selectYourBankDesc1}
    Verify Page Conatin Text  ${e_selectYourBankDesc2}
    Verify Page Conatin Text  ${e_indianBankOpts}
    Swipe By Percent  90  90  10  10  3000
    Click Text  ${e_SBI}
    Log To Console  Selected Bank - ${e_SBI}
    Wait For Page Conatin Element  ${e_SBIBankFull}  5s
    Verify Page Conatin Text  ${e_SBIBankFull}

User Visits Punjab National Bank For Funding
    Click On Tansfer From Dashboard
    Sleep  2s
    Wait And Click Element On Android  ${vf_A_addFundsBtn}
    Fill Deposit Screen
    Click On Switch Bank Link And Select A Bank For Deposit  ${e_PNB}
    Click On Next Button Under Add Funds Flow
    Verify Fund Online Screen - Visit The Bank - Direct Method
    Switch to Fund In-Persom With Bank Method - Direct Method
    Email Forms To The Registered Email Id
    Wait And Click Element On Android  ${vf_A_nextBtnUndrFundOnline}
    Verify And Fill The Upload Wire Receipt Received Screen - Visit The Bank  ${e_PNB1}
    Wait For Element Visibility On Android  ${vf_A_submit}  
    Wait And Click Element On Android  ${vf_A_submit}
    Log to Console  Submit button clicked
    Verify Success Screen After Transaction Is Submited Successfully
    Click Text  ${e_backToDashbrdBtnSccsTransfer}
    Verify Dashboard Screen

User Visits Other Indian Bank For Funding
    Click On Tansfer From Dashboard
    Sleep  2s
    Wait And Click Element On Android  ${vf_A_addFundsBtn}
    Fill Deposit Screen
    Click On Switch Bank Link And Select A Bank For Deposit  ${e_OtherBank}
    Click On Next Button Under Add Funds Flow
    Verify Fund Online Screen - Visit The Bank - Other Bank
    Sleep  5s
    Other Bank Fund In Person Screen - Next Button
    Verify And Fill The Upload Wire Receipt Received Screen - Other Bank
    Wait For Element Visibility On Android  ${vf_A_submit}  
    Wait And Click Element On Android  ${vf_A_submit}
    Log to Console  Submit button clicked
    Verify Success Screen After Transaction Is Submited Successfully
    Click Text  ${e_backToDashbrdBtnSccsTransfer}
    Verify Dashboard Screen

Verify Fund Online Screen - Visit The Bank - Other Bank
    Wait For Page Conatin Element  ${e_fundInpersonWithBank}  10s
    Verify Page Conatin Text  ${e_fundInpersonWithBank}
    Verify Page Conatin Text  ${e_OtherBanksDetails1}
    Verify Page Conatin Text  ${e_OtherBanksTxt1}
    Verify Page Conatin Text  ${e_OtherBanksDetails2}
    Verify Page Conatin Text  ${e_OtherBanksTxt2}
    Verify Page Conatin Text  ${e_accInfo}
    Verify Page Conatin Text  ${e_furtherCredit}
    Verify Page Conatin Text  ${e_DWInfoTxt}
    Verify Page Conatin Text  ${e_accNum}
    Swipe By Percent  90  90  10  10  3000
    Verify Page Conatin Text  ${e_beneInfoEmail}
    Verify Page Conatin Text  ${e_beneInfoPhNo}
    Verify Page Conatin Text  ${e_bankInfo}
    Verify Page Conatin Text  ${e_routingNum}
    Verify Page Conatin Text  ${e_swiftCode}
    Swipe By Percent  90  90  10  10  3000
    Verify Page Conatin Text  ${e_OtherBanksDetails3}
    Verify Page Conatin Text  ${e_OtherBanksTxt3}
    Verify Page Conatin Text  ${e_importantTxt}
    Verify Page Conatin Text  ${e_importantP1}
    Verify Page Conatin Text  ${e_importantP2}
    Verify Page Conatin Text  ${e_feesTxt}
    Verify Page Conatin Text  ${e_feesP1}
    Log to Console  Verified Fund Online Screen!

Other Bank Fund In Person Screen - Next Button
    Wait For Element Visibility On Android  ${vf_A_nextBtnUndrFundOnline}
    Wait And Click Element On Android  ${vf_A_nextBtnUndrFundOnline}

Verify And Fill The Upload Wire Receipt Received Screen - Other Bank
    Verify Page Conatin Text  ${e_uploadWireReceiptNote}
    Verify Page Conatin Text  ${e_yourReceiptTxt}
    Verify Page Conatin Text  ${e_yourFullName}
    Verify Page Conatin Text  ${e_yourDriveWealthTxt}
    Verify Page Conatin Text  ${e_bankName}
    Wait For Element Visibility On Android   ${vf_A_enterBankName}
    Input Text  ${vf_A_enterBankName}  ${e_sampleBank}
    Verify Page Conatin Text  ${e_amtInUSDTxt}
    Swipe By Percent  90  90  10  10  3000
    Verify Page Conatin Text  ${e_dateOnWireReceiptTxt}
    Click Text  ${e_selectDateTxt}
    Wait For Page Conatin Element  ${e_calenderOkBtn}  5s
    Click Text  ${e_calenderOkBtn}
    Verify Page Conatin Text  ${e_pwdForPdfTxt}
    Verify Page Conatin Text  ${e_enterPwdTxt}
    Verify Page Conatin Text  ${e_leaveBlankTxt}
    Verify Page Conatin Text  ${e_incmpltTransferTxt}
    Click Text  ${e_uploadWireReceiptBtn}
    Upload Wire Receipt And Verify Success Message    
