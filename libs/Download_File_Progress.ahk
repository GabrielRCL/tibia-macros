download(url, target) {
    Global
    FileGetSize, bytesNow, %target%
    If (bytesNow = bytes := HttpQueryInfo(url, 5)) {
        MsgBox, 64, Done, File sizes match. Aborting.
        Return
    } Else FileRecycle, %target%
    ;~ Gui, Progress:New
    ;~ Gui, Add, Progress, w250 h20 cBlue vprog, 1
    ;~ Gui, Show ;, Downloading (%pct%`%)
    SetTimer, GetSize, 250
    UrlDownloadToFile, %url%, %target%
    err := ErrorLevel
    SetTimer, GetSize, Off

    If (err) {
        MsgBox, 48, Error, An error occurred during downloading.
        return, false
    } Else {
        GuiControl,, Progress_Bar, 100
        ;~ MsgBox, 64, Done, Done!
        return, true
    }
    Return

    GetSize:
        Gui, LoginScreen:Default
        FileGetSize, bytesNow, %target%
        If pct := Round(100 * bytesNow / bytes) {
            GuiControl,, Progress_Bar, % (Abs(pct)/10000000) + 10
        }
    Return
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; HttpQueryInfo Function ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Source: post by olfen "DllCall: HttpQueryInfo - Get HTTP headers"
;                       http://www.autohotkey.com/forum/post-64567.html#64567
;
; For flag info, see: http://msdn.microsoft.com/en-us/library/aa385351(VS.85).aspx

HttpQueryInfo(URL, QueryInfoFlag=21, Proxy="", ProxyBypass="") {
  hModule := DllCall("LoadLibrary", "str", dll := "wininet.dll")

  ;[color=#800000]; Adapt for build by 0x150||ISO
  ver := ( A_IsUnicode && !RegExMatch( A_AhkVersion, "\d+\.\d+\.4" ) ? "W" : "A" )
  InternetOpen := dll "\InternetOpen" ver
  HttpQueryInfo := dll "\HttpQueryInfo" ver
  InternetOpenUrl := dll "\InternetOpenUrl" ver[/color]

  If (Proxy != "")
  AccessType=3
  Else
  AccessType=1

  io_hInternet := DllCall( InternetOpen
  , "str", ""
  , "uint", AccessType
  , "str", Proxy
  , "str", ProxyBypass
  , "uint", 0) ;dwFlags

  If (ErrorLevel != 0 or io_hInternet = 0) {
    DllCall("FreeLibrary", "uint", hModule)
    return, -1
  }

  iou_hInternet := DllCall( InternetOpenUrl
  , "uint", io_hInternet
  , "str", url
  , "str", ""
  , "uint", 0
  , "uint", 0x80000000
  , "uint", 0)
  If (ErrorLevel != 0 or iou_hInternet = 0) {
  DllCall("FreeLibrary", "uint", hModule)
  return, -1
  }

  VarSetCapacity(buffer, 1024, 0)
  VarSetCapacity(buffer_len, 4, 0)

  Loop, 5
  {
    hqi := DllCall( HttpQueryInfo
    , "uint", iou_hInternet
    , "uint", QueryInfoFlag
    , "uint", &buffer
    , "uint", &buffer_len
    , "uint", 0)
    If (hqi = 1) {
      hqi=success
      break
    }
  }

  IfNotEqual, hqi, success, SetEnv, res, timeout

  If (hqi = "success") {
  p := &buffer
  Loop
  {
    l := DllCall("lstrlen", "UInt", p)
    VarSetCapacity(tmp_var, l+1, 0)
    DllCall("lstrcpy", "Str", tmp_var, "UInt", p)
    p += l + 1
    res := res . tmp_var
    If (*p = 0)
    Break
  }
  }

  DllCall("wininet\InternetCloseHandle",  "uint", iou_hInternet)
  DllCall("wininet\InternetCloseHandle",  "uint", io_hInternet)
  DllCall("FreeLibrary", "uint", hModule)

  return, res
}


;[ filecopy-progress ]
InfoCopy(TotalBytes, BytesWritten, Percent) {
  Progress, % Percent, %Percent%  `% Completado...`nBytes Totales: %TotalBytes%`nBytes Escritos: %BytesWritten%
  if GetKeyState("w") ;stop  copying while "w" is pressed
  return 3
  else {
  Sleep 250
  return 1
  }
  Sleep 250
}

FileCopyEx(Filename, Dest := "", OverWrite := false, Func := "", Flags := "") {
  SplitPath, Filename, ffn ;, dir, ext, fn, drive
  Dest := Dest=""?A_WorkingDir "\" ffn:GetFullPathName(Dest)
  if !(OverWrite) && (FileExist(Dest))
  return false, ErrorLevel := 2
  if !(IsObject(sf:=FileOpen(Filename, "r-wd"))) || !(IsObject(df:=FileOpen(Dest, "w-rwd", sf.Encoding)))
  return false, sf.Close(), ErrorLevel := 4
  RemainingBytes := Bytes := sf.Length, Count := Floor(Bytes/1000000), df.Length := Count?1000000:Bytes, TotalBytesWritten := 0
  Loop, % (Count?Count+1:1) {
  if (RemainingBytes>999999) {
  VarSetCapacity(Data, 1000000), sf.RawRead(Data, 1000000)
  , TotalBytesWritten := TotalBytesWritten+df.RawWrite(Data, 1000000)
  } else {
  VarSetCapacity(Data, RemainingBytes), sf.RawRead(Data, RemainingBytes)
  , TotalBytesWritten := TotalBytesWritten+df.RawWrite(Data, RemainingBytes)
  if !(Count) && (IsFunc(Func)) && (%Func%(Bytes, TotalBytesWritten, 100)=0)
  return TotalBytesWritten=Bytes, sf.Close(), df.Close(), ErrorLevel := 3
  break
  } RemainingBytes := RemainingBytes-1000000, VarSetCapacity(Data, 0), df.Length := TotalBytesWritten
  if (IsFunc(Func)) {
  Percent(10000, TotalBytesWritten / Bytes, Percent)
  if ((fReturn:=%Func%(Bytes, TotalBytesWritten, RemainingBytes>999999?Percent:100))=false) {
  return false, sf.Close(), df.Close(), ErrorLevel := 3
  } else if (fReturn=2) {
  Func := ""
  } else if (fReturn=3) {
  while !(%Func%(Bytes, TotalBytesWritten, RemainingBytes>999999?Percent:100)=1)
  Sleep, 1000
  }}} sf.Close(), df.Close()
  if (Ok:=(TotalBytesWritten=Bytes)) {
  if !(Flags[1]) ;CopyAttrib
  FileSetAttrib("+" FileGetAttrib(Filename), Dest)
  if !(Flags[2]) ;CopyTime
  FileSetTime(FileGetTime(Filename, "MCA"), Dest)
  } return Ok, ErrorLevel := !Ok
}

FileSetAttrib(Attributes, FilePattern, OperateOnFolders := false, Recurse := false) {
  FileSetAttrib, %Attributes%, %FilePattern%, %OperateOnFolders%, %Recurse%
  return !ErrorLevel
}

FileGetAttrib(Filename) {
  FileGetAttrib, OutputVar, %Filename%
  return OutputVar
}

FileGetTime(Filename, WhichTime := "M") {
  OutputVar := []
  Loop, Parse, % WhichTime
  { FileGetTime, Time, %Filename%, %WhichTime%
  if !(Time="")
  OutputVar.Push(Time)
  } return OutputVar.MaxIndex()=1?OutputVar[1]:OutputVar
}

FileSetTime(Time := "", FilePattern := "", WhichTimeMCA := "M", OperateOnFolders := false, Recurse := false) {
  if IsObject(Time)
  for k, v in Time
  FileSetTime, %v%, %FilePattern%, % k=1?"M":k=2?"C":k=3?"A":k, %OperateOnFolders%, %Recurse%
  else Loop, Parse, % WhichTimeMCA
  FileSetTime, %Time%, %FilePattern%, %A_LoopField%, %OperateOnFolders%, %Recurse%
  return !ErrorLevel
}

Percent(num, Percent, ByRef OutputPercent := "", Places := 2) {
  return Float(num-(i:=(num/100)*Percent), "0." Places), OutputPercent := IsByRef(OutputPercent)?Round(i, Places):""
}

Float(num, Type := "0.2") {
  return Format("{:" Type (RegExReplace(Type, "[^fegaEGA]")?"":"f") "}", num)
}

GetFullPathName(Filename, ByRef Length := "") {
  Size := DllCall("Kernel32.dll\GetFullPathNameW", "Str", Filename, "UInt", 0, "Ptr", 0, "PtrP", 0, "UShort"), VarSetCapacity(OutputVar, Size * 2, 0)
  , Length := DllCall("Kernel32.dll\GetFullPathNameW", "Str", Filename, "UInt", Size, "Str", OutputVar, "PtrP", 0, "UShort")
  return Length?RTrim(OutputVar, "\"):Filename, ErrorLevel := !Length
}

A_SysDir() {
  static SysDir
  if !(SysDir)
  uSize := DllCall("kernel32.dll\GetSystemDirectoryW", "Ptr", 0, "UInt", 0)
  , VarSetCapacity(SysDir, uSize * 2, 0)
  , DllCall("kernel32.dll\GetSystemDirectoryW", "Str", SysDir, "UInt", uSize)
  return SysDir
}

