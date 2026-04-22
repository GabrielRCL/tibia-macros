; DATA ================================================================================
LoadGDIplus(){
    GLOBAL
    VarSetCapacity(startInput, A_PtrSize = 8 ? 24 : 16, 0)
    startInput := Chr(1)
    HModuleGdip := DllCall("LoadLibrary", "Str", "gdiplus", "Ptr")
    DllCall("gdiplus\GdiplusStartup", "Ptr*", pToken, "Ptr", &startInput, "Ptr", 0)
    ProcBitBlt := DllCall("GetProcAddress", "Ptr", DllCall("GetModuleHandle", "Str", "gdi32", "Ptr"), "AStr", "BitBlt", "Ptr")
    ProcCreateBitmap := DllCall("GetProcAddress", "Ptr", HModuleGdip, "AStr", "GdipCreateBitmapFromHBITMAP", "Ptr")
    ProcBitmapLock := DllCall("GetProcAddress", "Ptr", HModuleGdip, "AStr", "GdipBitmapLockBits", "Ptr")
    ProcBitmapUnlock := DllCall("GetProcAddress", "Ptr", HModuleGdip, "AStr", "GdipBitmapUnlockBits", "Ptr")
    ProcDisposeImage := DllCall("GetProcAddress", "Ptr", HModuleGdip, "AStr", "GdipDisposeImage", "Ptr")
    Ptr := A_PtrSize ? "UPtr" : "UInt"
    PtrA := Ptr . "*"
    MCode_ImageSearch := "8b44243883ec205355565783f8010f857a0100008b7c2458897c24143b7c24600f8db50b00008b44244c8b5c245c8b4c24448b7424548be80fafef896c242490897424683bf30f8d0a0100008d64240033c033db8bf5896c241c895c2420894424183b4424480f8d0401000033c08944241085c90f8e9d0000008b5424688b7c24408beb8d34968b54246403df8d4900b803000000803c18008b442410745e8b44243c0fb67c2f020fb64c06028d04113bf87f792bca3bf97c738b44243c0fb64c06018b4424400fb67c28018d04113bf87f5a2bca3bf97c548b44243c0fb63b0fb60c068d04113bf87f422bca3bf97c3c8b4424108b7c24408b4c24444083c50483c30483c604894424103bc17c818b5c24208b74241c0374244c8b44241840035c24508974241ce92dffffff8b6c24688b5c245c8b4c244445896c24683beb8b6c24240f8c06ffffff8b44244c8b7c24148b7424544703e8897c2414896c24243b7c24600f8cd5feffffe96b0a00008b4424348b4c246889088b4424388b4c24145f5e5d890833c05b83c420c383f8020f85870100008b7c24604f897c24103b7c24580f8c310a00008b44244c8b5c245c8b4c24448bef0fafe8f7d8894424188b4424548b742418896c24288d4900894424683bc30f8d0a0100008d64240033c033db8bf5896c2420895c241c894424243b4424480f8d0401000033c08944241485c90f8e9d0000008b5424688b7c24408beb8d34968b54246403df8d4900b803000000803c03008b442414745e8b44243c0fb67c2f020fb64c06028d04113bf87f792bca3bf97c738b44243c0fb64c06018b4424400fb67c28018d04113bf87f5a2bca3bf97c548b44243c0fb63b0fb60c068d04113bf87f422bca3bf97c3c8b4424148b7c24408b4c24444083c50483c30483c604894424143bc17c818b5c241c8b7424200374244c8b44242440035c245089742420e92dffffff8b6c24688b5c245c8b4c244445896c24683beb8b6c24280f8c06ffffff8b7c24108b4424548b7424184f03ee897c2410896c24283b7c24580f8dd5feffffe9db0800008b4424348b4c246889088b4424388b4c24105f5e5d890833c05b83c420c383f8030f85650100008b7c24604f897c24103b7c24580f8ca10800008b44244c8b6c245c8b5c24548b4c24448bf70faff04df7d8896c242c897424188944241c8bff896c24683beb0f8c020100008d64240033c033db89742424895c2420894424283b4424480f8d76ffffff33c08944241485c90f8e9f0000008b5424688b7c24408beb8d34968b54246403dfeb038d4900b803000000803c03008b442414745e8b44243c0fb67c2f020fb64c06028d04113bf87f752bca3bf97c6f8b44243c0fb64c06018b4424400fb67c28018d04113bf87f562bca3bf97c508b44243c0fb63b0fb60c068d04113bf87f3e2bca3bf97c388b4424148b7c24408b4c24444083c50483c30483c604894424143bc17c818b5c24208b7424248b4424280374244c40035c2450e92bffffff8b6c24688b5c24548b4c24448b7424184d896c24683beb0f8d0affffff8b7c24108b44241c4f03f0897c2410897424183b7c24580f8c580700008b6c242ce9d4feffff83f8040f85670100008b7c2458897c24103b7c24600f8d340700008b44244c8b6c245c8b5c24548b4c24444d8bf00faff7896c242c8974241ceb098da424000000008bff896c24683beb0f8c020100008d64240033c033db89742424895c2420894424283b4424480f8d06feffff33c08944241485c90f8e9f0000008b5424688b7c24408beb8d34968b54246403dfeb038d4900b803000000803c03008b442414745e8b44243c0fb67c2f020fb64c06028d04113bf87f752bca3bf97c6f8b44243c0fb64c06018b4424400fb67c28018d04113bf87f562bca3bf97c508b44243c0fb63b0fb60c068d04113bf87f3e2bca3bf97c388b4424148b7c24408b4c24444083c50483c30483c604894424143bc17c818b5c24208b7424248b4424280374244c40035c2450e92bffffff8b6c24688b5c24548b4c24448b74241c4d896c24683beb0f8d0affffff8b44244c8b7c24104703f0897c24108974241c3b7c24600f8de80500008b6c242ce9d4feffff83f8050f85890100008b7c2454897c24683b7c245c0f8dc40500008b5c24608b6c24588b44244c8b4c2444eb078da42400000000896c24103beb0f8d200100008be80faf6c2458896c241c33c033db8bf5896c2424895c2420894424283b4424480f8d0d01000033c08944241485c90f8ea60000008b5424688b7c24408beb8d34968b54246403dfeb0a8da424000000008d4900b803000000803c03008b442414745e8b44243c0fb67c2f020fb64c06028d04113bf87f792bca3bf97c738b44243c0fb64c06018b4424400fb67c28018d04113bf87f5a2bca3bf97c548b44243c0fb63b0fb60c068d04113bf87f422bca3bf97c3c8b4424148b7c24408b4c24444083c50483c30483c604894424143bc17c818b5c24208b7424240374244c8b44242840035c245089742424e924ffffff8b7c24108b6c241c8b44244c8b5c24608b4c24444703e8897c2410896c241c3bfb0f8cf3feffff8b7c24688b6c245847897c24683b7c245c0f8cc5feffffe96b0400008b4424348b4c24688b74241089088b4424385f89305e5d33c05b83c420c383f8060f85670100008b7c2454897c24683b7c245c0f8d320400008b6c24608b5c24588b44244c8b4c24444d896c24188bff896c24103beb0f8c1a0100008bf50faff0f7d88974241c8944242ceb038d490033c033db89742424895c2420894424283b4424480f8d06fbffff33c08944241485c90f8e9f0000008b5424688b7c24408beb8d34968b54246403dfeb038d4900b803000000803c03008b442414745e8b44243c0fb67c2f020fb64c06028d04113bf87f752bca3bf97c6f8b44243c0fb64c06018b4424400fb67c28018d04113bf87f562bca3bf97c508b44243c0fb63b0fb60c068d04113bf87f3e2bca3bf97c388b4424148b7c24408b4c24444083c50483c30483c604894424143bc17c818b5c24208b7424248b4424280374244c40035c2450e92bffffff8b6c24108b74241c0374242c8b5c24588b4c24444d896c24108974241c3beb0f8d02ffffff8b44244c8b7c246847897c24683b7c245c0f8de60200008b6c2418e9c2feffff83f8070f85670100008b7c245c4f897c24683b7c24540f8cc10200008b6c24608b5c24588b44244c8b4c24444d896c241890896c24103beb0f8c1a0100008bf50faff0f7d88974241c8944242ceb038d490033c033db89742424895c2420894424283b4424480f8d96f9ffff33c08944241485c90f8e9f0000008b5424688b7c24408beb8d34968b54246403dfeb038d4900b803000000803c18008b442414745e8b44243c0fb67c2f020fb64c06028d04113bf87f752bca3bf97c6f8b44243c0fb64c06018b4424400fb67c28018d04113bf87f562bca3bf97c508b44243c0fb63b0fb60c068d04113bf87f3e2bca3bf97c388b4424148b7c24408b4c24444083c50483c30483c604894424143bc17c818b5c24208b7424248b4424280374244c40035c2450e92bffffff8b6c24108b74241c0374242c8b5c24588b4c24444d896c24108974241c3beb0f8d02ffffff8b44244c8b7c24684f897c24683b7c24540f8c760100008b6c2418e9c2feffff83f8080f85640100008b7c245c4f897c24683b7c24540f8c510100008b5c24608b6c24588b44244c8b4c24448d9b00000000896c24103beb0f8d200100008be80faf6c2458896c241c33c033db8bf5896c2424895c2420894424283b4424480f8d9dfcffff33c08944241485c90f8ea60000008b5424688b7c24408beb8d34968b54246403dfeb0a8da424000000008d4900b803000000803c03008b442414745e8b44243c0fb67c2f020fb64c06028d04113bf87f792bca3bf97c738b44243c0fb64c06018b4424400fb67c28018d04113bf87f5a2bca3bf97c548b44243c0fb63b0fb604068d0c103bf97f422bc23bf87c3c8b4424148b7c24408b4c24444083c50483c30483c604894424143bc17c818b5c24208b7424240374244c8b44242840035c245089742424e924ffffff8b7c24108b6c241c8b44244c8b5c24608b4c24444703e8897c2410896c241c3bfb0f8cf3feffff8b7c24688b6c24584f897c24683b7c24540f8dc5feffff8b4424345fc700ffffffff8b4424345e5dc700ffffffffb85ff0ffff5b83c420c3,4c894c24204c89442418488954241048894c24085355565741544155415641574883ec188b8424c80000004d8bd94d8bd0488bda83f8010f85b3010000448b8c24a800000044890c24443b8c24b80000000f8d66010000448bac24900000008b9424c0000000448b8424b00000008bbc2480000000448b9424a0000000418bcd410fafc9894c24040f1f84000000000044899424c8000000453bd00f8dfb000000468d2495000000000f1f800000000033ed448bf933f6660f1f8400000000003bac24880000000f8d1701000033db85ff7e7e458bf4448bce442bf64503f7904d63c14d03c34180780300745a450fb65002438d040e4c63d84c035c2470410fb64b028d0411443bd07f572bca443bd17c50410fb64b01450fb650018d0411443bd07f3e2bca443bd17c37410fb60b450fb6108d0411443bd07f272bca443bd17c204c8b5c2478ffc34183c1043bdf7c8fffc54503fd03b42498000000e95effffff8b8424c8000000448b8424b00000008b4c24044c8b5c2478ffc04183c404898424c8000000413bc00f8c20ffffff448b0c24448b9424a000000041ffc14103cd44890c24894c2404443b8c24b80000000f8cd8feffff488b5c2468488b4c2460b85ff0ffffc701ffffffffc703ffffffff4883c418415f415e415d415c5f5e5d5bc38b8424c8000000e9860b000083f8020f858c010000448b8c24b800000041ffc944890c24443b8c24a80000007cab448bac2490000000448b8424c00000008b9424b00000008bbc2480000000448b9424a0000000418bc9410fafcd418bc5894c2404f7d8894424080f1f400044899424c8000000443bd20f8d02010000468d2495000000000f1f80000000004533f6448bf933f60f1f840000000000443bb424880000000f8d56ffffff33db85ff0f8e81000000418bec448bd62bee4103ef4963d24903d3807a03007460440fb64a02418d042a4c63d84c035c2470410fb64b02428d0401443bc87f5d412bc8443bc97c55410fb64b01440fb64a01428d0401443bc87f42412bc8443bc97c3a410fb60b440fb60a428d0401443bc87f29412bc8443bc97c214c8b5c2478ffc34183c2043bdf7c8a41ffc64503fd03b42498000000e955ffffff8b8424c80000008b9424b00000008b4c24044c8b5c2478ffc04183c404898424c80000003bc20f8c19ffffff448b0c24448b9424a0000000034c240841ffc9894c240444890c24443b8c24a80000000f8dd0feffffe933feffff83f8030f85c4010000448b8c24b800000041ffc944898c24c8000000443b8c24a80000000f8c0efeffff8b842490000000448b9c24b0000000448b8424c00000008bbc248000000041ffcb418bc98bd044895c24080fafc8f7da890c24895424048b9424a0000000448b542404458beb443bda0f8c13010000468d249d0000000066660f1f84000000000033ed448bf933f6660f1f8400000000003bac24880000000f8d0801000033db85ff0f8e96000000488b4c2478458bf4448bd6442bf64503f70f1f8400000000004963d24803d1807a03007460440fb64a02438d04164c63d84c035c2470410fb64b02428d0401443bc87f63412bc8443bc97c5b410fb64b01440fb64a01428d0401443bc87f48412bc8443bc97c40410fb60b440fb60a428d0401443bc87f2f412bc8443bc97c27488b4c2478ffc34183c2043bdf7c8a8b842490000000ffc54403f803b42498000000e942ffffff8b9424a00000008b8424900000008b0c2441ffcd4183ec04443bea0f8d11ffffff448b8c24c8000000448b542404448b5c240841ffc94103ca44898c24c8000000890c24443b8c24a80000000f8dc2feffffe983fcffff488b4c24608b8424c8000000448929488b4c2468890133c0e981fcffff83f8040f857f010000448b8c24a800000044890c24443b8c24b80000000f8d48fcffff448bac2490000000448b9424b00000008b9424c0000000448b8424a00000008bbc248000000041ffca418bcd4489542408410fafc9894c2404669044899424c8000000453bd00f8cf8000000468d2495000000000f1f800000000033ed448bf933f6660f1f8400000000003bac24880000000f8df7fbffff33db85ff7e7e458bf4448bce442bf64503f7904d63c14d03c34180780300745a450fb65002438d040e4c63d84c035c2470410fb64b028d0411443bd07f572bca443bd17c50410fb64b01450fb650018d0411443bd07f3e2bca443bd17c37410fb60b450fb6108d0411443bd07f272bca443bd17c204c8b5c2478ffc34183c1043bdf7c8fffc54503fd03b42498000000e95effffff8b8424c8000000448b8424a00000008b4c24044c8b5c2478ffc84183ec04898424c8000000413bc00f8d20ffffff448b0c24448b54240841ffc14103cd44890c24894c2404443b8c24b80000000f8cdbfeffffe9defaffff83f8050f85ab010000448b8424a000000044890424443b8424b00000000f8dc0faffff8b9424c0000000448bac2498000000448ba424900000008bbc2480000000448b8c24a8000000428d0c8500000000898c24c800000044894c2404443b8c24b80000000f8d09010000418bc4410fafc18944240833ed448bf833f6660f1f8400000000003bac24880000000f8d0501000033db85ff0f8e87000000448bf1448bce442bf64503f74d63c14d03c34180780300745d438d040e4c63d84d03da450fb65002410fb64b028d0411443bd07f5f2bca443bd17c58410fb64b01450fb650018d0411443bd07f462bca443bd17c3f410fb60b450fb6108d0411443bd07f2f2bca443bd17c284c8b5c24784c8b542470ffc34183c1043bdf7c8c8b8c24c8000000ffc54503fc4103f5e955ffffff448b4424048b4424088b8c24c80000004c8b5c24784c8b54247041ffc04103c4448944240489442408443b8424b80000000f8c0effffff448b0424448b8c24a800000041ffc083c10444890424898c24c8000000443b8424b00000000f8cc5feffffe946f9ffff488b4c24608b042489018b442404488b4c2468890133c0e945f9ffff83f8060f85aa010000448b8c24a000000044894c2404443b8c24b00000000f8d0bf9ffff8b8424b8000000448b8424c0000000448ba424900000008bbc2480000000428d0c8d00000000ffc88944240c898c24c80000006666660f1f840000000000448be83b8424a80000000f8c02010000410fafc4418bd4f7da891424894424084533f6448bf833f60f1f840000000000443bb424880000000f8df900000033db85ff0f8e870000008be9448bd62bee4103ef4963d24903d3807a03007460440fb64a02418d042a4c63d84c035c2470410fb64b02428d0401443bc87f64412bc8443bc97c5c410fb64b01440fb64a01428d0401443bc87f49412bc8443bc97c41410fb60b440fb60a428d0401443bc87f30412bc8443bc97c284c8b5c2478ffc34183c2043bdf7c8a8b8c24c800000041ffc64503fc03b42498000000e94fffffff8b4424088b8c24c80000004c8b5c247803042441ffcd89442408443bac24a80000000f8d17ffffff448b4c24048b44240c41ffc183c10444894c2404898c24c8000000443b8c24b00000000f8ccefeffffe991f7ffff488b4c24608b4424048901488b4c246833c0448929e992f7ffff83f8070f858d010000448b8c24b000000041ffc944894c2404443b8c24a00000000f8c55f7ffff8b8424b8000000448b8424c0000000448ba424900000008bbc2480000000428d0c8d00000000ffc8890424898c24c8000000660f1f440000448be83b8424a80000000f8c02010000410fafc4418bd4f7da8954240c8944240833ed448bf833f60f1f8400000000003bac24880000000f8d4affffff33db85ff0f8e89000000448bf1448bd6442bf64503f74963d24903d3807a03007460440fb64a02438d04164c63d84c035c2470410fb64b02428d0401443bc87f63412bc8443bc97c5b410fb64b01440fb64a01428d0401443bc87f48412bc8443bc97c40410fb60b440fb60a428d0401443bc87f2f412bc8443bc97c274c8b5c2478ffc34183c2043bdf7c8a8b8c24c8000000ffc54503fc03b42498000000e94fffffff8b4424088b8c24c80000004c8b5c24780344240c41ffcd89442408443bac24a80000000f8d17ffffff448b4c24048b042441ffc983e90444894c2404898c24c8000000443b8c24a00000000f8dcefeffffe9e1f5ffff83f8080f85ddf5ffff448b8424b000000041ffc84489442404443b8424a00000000f8cbff5ffff8b9424c0000000448bac2498000000448ba424900000008bbc2480000000448b8c24a8000000428d0c8500000000898c24c800000044890c24443b8c24b80000000f8d08010000418bc4410fafc18944240833ed448bf833f6660f1f8400000000003bac24880000000f8d0501000033db85ff0f8e87000000448bf1448bce442bf64503f74d63c14d03c34180780300745d438d040e4c63d84d03da450fb65002410fb64b028d0411443bd07f5f2bca443bd17c58410fb64b01450fb650018d0411443bd07f462bca443bd17c3f410fb603450fb6108d0c10443bd17f2f2bc2443bd07c284c8b5c24784c8b542470ffc34183c1043bdf7c8c8b8c24c8000000ffc54503fc4103f5e955ffffff448b04248b4424088b8c24c80000004c8b5c24784c8b54247041ffc04103c44489042489442408443b8424b80000000f8c10ffffff448b442404448b8c24a800000041ffc883e9044489442404898c24c8000000443b8424a00000000f8dc6feffffe946f4ffff8b442404488b4c246089018b0424488b4c2468890133c0e945f4ffff"
    if ( A_PtrSize == 8 )
    MCode_ImageSearch := SubStr(MCode_ImageSearch,InStr(MCode_ImageSearch,",")+1)
    else
    MCode_ImageSearch := SubStr(MCode_ImageSearch,1,InStr(MCode_ImageSearch,",")-1)
    VarSetCapacity(ImageSearchMCode, LEN := StrLen(MCode_ImageSearch)//2, 0)
    Loop, %LEN%
    NumPut("0x" . SubStr(MCode_ImageSearch,(2*A_Index)-1,2), ImageSearchMCode, A_Index-1, "uchar")
    MCode_ImageSearch := ""
    DllCall("VirtualProtect", Ptr,&ImageSearchMCode, Ptr,VarSetCapacity(ImageSearchMCode), "uint",0x40, PtrA,0)
    return
}

PrintScreenData(){
    GLOBAL

	if (TibiaServer != "Global") {
		FindProcessesID := active_id	;tibia client
	} else {
		FindProcessesID := Haystack_id	;obs studio
	}

	if (screen_capture_mode = "PrintDC" ) {
		return PrintScreenDC()
	} else {
		return PrintScreenPW()
	}
}
PrintScreenPW(){
    GLOBAL
    static PWWinID, WinTitle, WinX, WinY, WinW, WinH, ClientWidth, ClientHeight, Area, hBitmap
    
    if ( !WinID && FindProcessesID ) {
        WinID := WinExist("ahk_ID " FindProcessesID)
        PWWinID := WinID
        WinExist( GameInfo )
        WinGetClass, WindowClass
        WinGet , WinExE, ProcessName
        Process, Exist , %WinExE%
        WinGetTitle, WindowTitle
        WindowInfo:={ID: WinID, Title: WindowTitle, Class: WindowClass, IDClassNN: WinID, Exe: WinExE, pID: errorlevel}
        Area := DllCall("CreateCompatibleDC","Ptr",0,"Ptr")
    }
    if !WinExist( "ahk_id" PWWinID ) {
        FindProcessesID := ""
        WinTitle := ""
        WinID := ""
        RETURN False
    }
    WinGetTitle, WindowTitle
    WinGetPos, GetWinX, GetWinY, GetWinW, GetWinH
    if (WindowTitle != WinTitle || GetWinX != WinX || GetWinY != WinY || GetWinW != WinW || GetWinH != WinH ) {
        If (WindowTitle != WinTitle){
                NewName := StrSplit(WindowTitle, "-")
                If (NewName.2)
                NewName := Trim(NewName.2)
                Else
                NewName := WindowTitle
                GuiControl, Main:, WindowTitle, %NewName%
                WindowInfo.Title  := NewName
        }
        WinTitle:=WindowTitle, WinX:=GetWinX, WinY:=GetWinY, WinW:=GetWinW, WinH:=GetWinH
        VarSetCapacity(rect,16), DllCall("GetClientRect","Ptr",PWWinID,"Ptr",&rect), ClientWidth := NumGet(rect,8,"int"), ClientHeight := NumGet(rect,12,"int")
        DllCall("DeleteObject", "Ptr",hBitmap),VarSetCapacity(bi,40,0),NumPut(40,bi,0,"int"),NumPut(ClientWidth,bi,4,"int"),NumPut(-ClientHeight,bi,8,"int"),NumPut(1,bi,12,"short"),NumPut(32,bi,14,"short")
        hBitmap := DllCall("CreateDIBSection","Ptr",0,"Ptr",&bi,"int",0,"Ptr*",PrintScan,"Ptr",0,"int",0,"Ptr")
        DllCall("SelectObject","Ptr",Area,"Ptr",hBitmap,"Ptr")
        ScanBit := PrintScan
        StrideBit := ClientWidth*4
        PNGScanWidth := ClientWidth
        PNGScanHeight := ClientHeight
        WindowInfo.HBITMAP:= hBitmap
        WindowInfo.Window :={x: WinX , y: WinY, w: WinW, h: WinH}
        WindowInfo.Client :={w: ClientWidth, h: ClientHeight}
        WindowInfo.ClassNN:={x: Round((WinW-ClientWidth)/2), y: Round(WinH-ClientHeight-(WinW-ClientWidth)/2), w: ClientWidth, h: ClientHeight}
    }
    DllCall("PrintWindow","Ptr",PWWinID,"Ptr",Area,"int",1)
}
PrintScreenDC(){
    GLOBAL
    static DCWinID, WinTitle, WinX, WinY, WinW, WinH, ClientWidth, ClientHeight, Area, hBitmap
    if ( !WinID && FindProcessesID ) {
        WinID := WinExist("ahk_ID " FindProcessesID)
        DCWinID := WinID
        WinExist( GameInfo )
        WinGetClass, WindowClass
        WinGet , WinExE, ProcessName
        Process, Exist , %WinExE%
        WinGetTitle, WindowTitle
        WindowInfo:={ID: WinID, Title: WindowTitle, Class: WindowClass, IDClassNN: WinID, Exe: WinExE, pID: errorlevel}
        Area := DllCall("CreateCompatibleDC","Ptr",0,"Ptr")
    }
    if !WinExist( "ahk_id" DCWinID ) {
        FindProcessesID := ""
        WinTitle := ""
        WinID := ""
        RETURN False
    }
    WinGetTitle, WindowTitle
    WinGetPos, GetWinX, GetWinY, GetWinW, GetWinH
    if (WindowTitle != WinTitle || GetWinX != WinX || GetWinY != WinY || GetWinW != WinW || GetWinH != WinH ) {
        If (WindowTitle != WinTitle){
                NewName := StrSplit(WindowTitle, "-")
                If (NewName.2)
                NewName := Trim(NewName.2)
                Else
                NewName := WindowTitle
                GuiControl, Main:, WindowTitle, %NewName%
                WindowInfo.Title  := NewName
        }
        WinTitle:=WindowTitle, WinX:=GetWinX, WinY:=GetWinY, WinW:=GetWinW, WinH:=GetWinH
        VarSetCapacity(rect,16), DllCall("GetClientRect","Ptr",DCWinID,"Ptr",&rect), ClientWidth := NumGet(rect,8,"int"), ClientHeight := NumGet(rect,12,"int")
        DllCall("DeleteObject", "Ptr",hBitmap),VarSetCapacity(bi,40,0),NumPut(40,bi,0,"int"),NumPut(ClientWidth,bi,4,"int"),NumPut(-ClientHeight,bi,8,"int"),NumPut(1,bi,12,"short"),NumPut(32,bi,14,"short")
        hBitmap := DllCall("CreateDIBSection","Ptr",0,"Ptr",&bi,"int",0,"Ptr*",PrintScan,"Ptr",0,"int",0,"Ptr")
        DllCall("SelectObject","Ptr",Area,"Ptr",hBitmap,"Ptr")
        ScanBit := PrintScan
        StrideBit := ClientWidth*4
        PNGScanWidth := ClientWidth
        PNGScanHeight := ClientHeight
        WindowInfo.HBITMAP:= hBitmap
        WindowInfo.Window :={x: WinX , y: WinY, w: WinW, h: WinH}
        WindowInfo.Client :={w: ClientWidth, h: ClientHeight}
        WindowInfo.ClassNN:={x: Round((WinW-ClientWidth)/2), y: Round(WinH-ClientHeight-(WinW-ClientWidth)/2), w: ClientWidth, h: ClientHeight}
    }
    hDC := DllCall("GetDC","Ptr",DCWinID,"Ptr",0,"int",0)
    DllCall(ProcBitBlt,"Ptr",Area,"int",0,"int",0,"int",ClientWidth,"int",ClientHeight,"Ptr",hDC,"int",0,"int",0,"uint",0xCC0020)
    DllCall("DeleteDC","Ptr",hDC)
}
SearchPNG(ND,x,y,sx,sy,Tole:=0,ByRef Found:="",Mode:=1,Draw:=0,AreaDraw:=0){
    GLOBAL
      If !( ScanBit && ND.Scan )
      Return Found:=-1001
      If Tole not between 0 and 255
      return Found:=-1002
      If ( ( x < 0 ) || ( y < 0 ) )
      return Found:=-1003
      If Mode not between 1 and 8
      return Found:=-1004
      OutX := ( !sx ? PNGScanWidth - ND.Width +1 : sx - ND.Width +1 )
      OutY := ( !sy ? PNGScanHeight - ND.Height+1 : sy - ND.Height+1 )
      If ( OutX > (sx-ND.Width+1) )
      return Found:=-3003
      If ( OutY > (sy-ND.Height+1) )
      return Found:=-3004
      Info := LockedBitsSearch(StrideBit,ScanBit,ND.Stride,ND.Scan,ND.Width,ND.Height,FoundX,FoundY,x,y,OutX,OutY,Tole,Mode)
      if (AreaDraw = 1)
		;DrawRectangle(x+WindowInfo.ClassNN.x,y+WindowInfo.ClassNN.y,sx-x,sy-y,"0xffffffff")
      if (Info == 0 && Draw = 1){
            ;DrawRectangle(FoundX+WindowInfo.ClassNN.x, FoundY+WindowInfo.ClassNN.y, ND.Width, ND.Height ,"0xffFF0000")
            ;DrawRectangle(FoundX+WindowInfo.ClassNN.x, FoundY+WindowInfo.ClassNN.y, 1, 1 ,"0xffffff00")
      }
      if (Info == 0)
      Found := {1: 1, 2: FoundX, 3: FoundY}
      else
      Found := {1: 0}
      return
}


; LIB ================================================================================
LockedBitsSearch(hStride,hScan,nStride,nScan,nWidth,nHeight,ByRef x:="",ByRef y:="",slx1:=0,sly1:=0,slx2:=0,sly2:=0,Variation:=0,SearchDirection:=1){
    GLOBAL
    If ( slx2 < slx1 )
    return -3001
    If ( sly2 < sly1 )
    return -3002
    If ( slx2-slx1 == 0 )
    return -3005
    If ( sly2-sly1 == 0 )
    return -3006
    E := DllCall( &ImageSearchMCode,"int*",x,"int*",y,Ptr,hScan, Ptr,nScan,"int",nWidth,"int",nHeight,"int",hStride,"int",nStride,"int",slx1,"int",sly1,"int",slx2,"int",sly2,"int",Variation,"int",SearchDirection,"cdecl int")
    Return ( E == "" ? -3007 : E )
}

BitmapFromBase64(BitLock, Type, B64, NameFile:=""){
    GLOBAL
    VarSetCapacity(B64Len, 0)
    , DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", StrLen(B64), "UInt", 0x01, "Ptr", 0, "UIntP", B64Len, "Ptr", 0, "Ptr", 0)
    , VarSetCapacity(B64Dec, B64Len, 0)
    , DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", StrLen(B64), "UInt", 0x01, "Ptr", &B64Dec, "UIntP", B64Len, "Ptr", 0, "Ptr", 0)
    , pStream := DllCall("Shlwapi.dll\SHCreateMemStream", "Ptr", &B64Dec, "UInt", B64Len, "UPtr")
    , DllCall("Gdiplus.dll\GdipCreateBitmapFromStream", "Ptr", pStream, "PtrP", pBitmap)
    , ObjRelease(pStream)
    if Type
    DllCall("Gdiplus.dll\GdipCreateHBITMAPFromBitmap", "UInt", pBitmap, "UInt*", hBitmap, "Int", 0XFFFFFFFF)
    , Gdip_DisposeImage(pBitmap)
        if (BitLock && !Type) {
            Gdip_GetImageDimensions(pBitmap,nWidth,nHeight)
            , Gdip_LockBits(pBitmap,0,0,nWidth,nHeight,nStride,nScan,nBitmapData)
            if (NameFile != "") {
                Gdip_SaveBitmapToFile(pBitmap, A_WorkingDir "\" NameFile ".png")
                MsgBox, % "Saved File: " A_WorkingDir "\" NameFile ".png"
            }
            return Object := {Stride: nStride,Scan: nScan,Width: nWidth,Height: nHeight, Bitmap: (Type ? hBitmap : pBitmap)}
        } Else {
            if (NameFile != "") {
                tmpBitmap := Gdip_CreateBitmapFromHBITMAP(hBitmap)
                Gdip_SaveBitmapToFile(tmpBitmap, "test/" NameFile ".png")
                MsgBox, % "Saved File: " NameFile
            }
            return Type ? hBitmap : pBitmap
        }
}

EncodeBitmapTo64string(pBitmap, ext, Quality:=75) {
	if Ext not in BMP,DIB,RLE,JPG,JPEG,JPE,JFIF,GIF,TIF,TIFF,PNG
		return -1
	Extension := "." Ext

	DllCall("gdiplus\GdipGetImageEncodersSize", "uint*", nCount, "uint*", nSize)
	VarSetCapacity(ci, nSize)
	DllCall("gdiplus\GdipGetImageEncoders", "uint", nCount, "uint", nSize, Ptr, &ci)
	if !(nCount && nSize)
		return -2



	Loop, %nCount%
	{
		sString := StrGet(NumGet(ci, (idx := (48+7*A_PtrSize)*(A_Index-1))+32+3*A_PtrSize), "UTF-16")
		if !InStr(sString, "*" Extension)
			continue
		pCodec := &ci+idx
		break
	}

	if !pCodec
	return -3

        if (Quality != 75)
         {
               Quality := (Quality < 0) ? 0 : (Quality > 100) ? 100 : Quality
               if Extension in .JPG,.JPEG,.JPE,.JFIF
               {
                     DllCall("gdiplus\GdipGetEncoderParameterListSize", Ptr, pBitmap, Ptr, pCodec, "uint*", nSize)
                     VarSetCapacity(EncoderParameters, nSize, 0)
                     DllCall("gdiplus\GdipGetEncoderParameterList", Ptr, pBitmap, Ptr, pCodec, "uint", nSize, Ptr, &EncoderParameters)
                     Loop, % NumGet(EncoderParameters, "UInt")
                     {
                        elem := (24+(A_PtrSize ? A_PtrSize : 4))*(A_Index-1) + 4 + (pad := A_PtrSize = 8 ? 4 : 0)
                        if (NumGet(EncoderParameters, elem+16, "UInt") = 1) && (NumGet(EncoderParameters, elem+20, "UInt") = 6)
                        {
                              p := elem+&EncoderParameters-pad-4
                              NumPut(Quality, NumGet(NumPut(4, NumPut(1, p+0)+20, "UInt")), "UInt")
                              break
                        }
                     }
               }
         }

         DllCall("ole32\CreateStreamOnHGlobal", "ptr",0, "int",true, "ptr*",pStream)
         DllCall("gdiplus\GdipSaveImageToStream", "ptr",pBitmap, "ptr",pStream, "ptr",pCodec, "uint",p ? p : 0)

         DllCall("ole32\GetHGlobalFromStream", "ptr",pStream, "uint*",hData)
         pData := DllCall("GlobalLock", "ptr",hData, "uptr")
         nSize := DllCall("GlobalSize", "uint",pData)

         VarSetCapacity(Bin, nSize, 0)
         DllCall("RtlMoveMemory", "ptr",&Bin , "ptr",pData , "uint",nSize)
         DllCall("GlobalUnlock", "ptr",hData)
         DllCall(NumGet(NumGet(pStream + 0, 0, "uptr") + (A_PtrSize * 2), 0, "uptr"), "ptr",pStream)
         DllCall("GlobalFree", "ptr",hData)

         DllCall("Crypt32.dll\CryptBinaryToString", "ptr",&Bin, "uint",nSize, "uint",0x01, "ptr",0, "uint*",base64Length)
         VarSetCapacity(base64, base64Length*2, 0)
         DllCall("Crypt32.dll\CryptBinaryToString", "ptr",&Bin, "uint",nSize, "uint",0x01, "ptr",&base64, "uint*",base64Length)
         Bin := ""
         VarSetCapacity(Bin, 0)
         VarSetCapacity(base64, -1)

         return base64
}

CorToDec(hex,ByRef Out:=""){
    GLOBAL
    hex := "FF" SubStr(hex, 2)
    , VarSetCapacity(Out, 66, 0)
    , val := DllCall("msvcrt.dll\_wcstoui64", "Str", hex, "UInt", 0, "UInt", 16, "CDECL Int64")
    , DllCall("msvcrt.dll\_i64tow", "Int64", val, "Str", Out, "UInt", 10, "CDECL")
    return Out
}

GetColorDecimal(X, Y){
    GLOBAL
    If ( ScanBit && StrideBit && X>=0 && Y>=0 && X < PNGScanWidth && Y < PNGScanHeight )
    return NumGet(ScanBit + 0, X * 4 + Y * StrideBit, "UInt")
}

GetColorHex(X, Y){
    GLOBAL
    If ( ScanBit && StrideBit && X>=0 && Y>=0 && X < PNGScanWidth && Y < PNGScanHeight )
    return "#" SubStr(Format("{1:#x}", NumGet(ScanBit + 0, X * 4 + Y * StrideBit, "UInt")), 5)
}
