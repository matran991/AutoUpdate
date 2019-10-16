#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icont.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GuiHTML_UDF.au3>
#include <Array.au3>
#include <Inet.au3>
#include <AutoItConstants.au3>

$guiw = @DesktopWidth;
$guih = @DesktopHeight;
$guiw = 700
$guih = 660
$guiX = (@DesktopWidth - $guiw) / 2;
$guiY = (@DesktopHeight - $guih) / 2;

$RegKey = "HKEY_CURRENT_USER\Software\Soul3";
Local $old = RegRead($RegKey,"Version");
Local $location = RegRead($RegKey,"Location");
If StringLen($old) > 0 Then
	$URL = "https://script.google.com/macros/s/AKfycbws1XUDXNrAXl5M-88-EnhIxQIybpHJpeKflSc0irTVvPF5jaU/exec?type=DarkS3"
	$data = _INetGetSource($URL);
	$data = StringToBinary($data,1);
	$data = BinaryToString($data,4);
	$split = StringSplit($data,"||",1);
	$verNew = $split[2];
	Local $info = StringReplace($split[4],"<lf>","<br>");;
	If $old <> $verNew Then
		;Local $button =	MsgBox(4,"Thông Báo",$info&@CRLF&@CRLF&"Nhấn Yes để chạy ngay file Patch để cập nhật.");
		$titlegui = 'AutoUpdate By Matran999'
		$gui = GUICreate($titlegui, $guiw, $guih, $guiX, $guiY, $WS_POPUP)
		$drag = GUICtrlCreateLabel("", 0, 0,$guiw-78, 25, -1, $GUI_WS_EX_PARENTDRAG) ; Drag
		$a = HTML_Load(@ScriptDir & '/UpdatePop.html', $guiw, $guih,0,0,1); Load file html vào main gui
		GUISetState();
		;HTML_GUICtrlSetData("contentHtml","'"&$info&"'")
		HTML_EvalJS('SetMsg("'&$info&'")');
		;ConsoleWrite($info);

		;HTML_GUICtrlSetData("contentHtml",$info)
		While 1
				If HTML_GUIGetMsg() = $GUI_EVENT_CLOSE Then
					Exit
				EndIf
			HTML_GUICtrlSetData("contentHtml","123@#")
		WEnd
		;	ShellExecute($location);
	EndIf
EndIf

Func RunPatch()
	ShellExecute($location);
	Exit;
EndFunc

Func RemoveAuto()
	$msg = MsgBox(4,"Thông Báo","Bạn thực sự muốn xóa ứng dụng tự động cập nhật."&@CRLF&"Bạn sẽ không được cập nhật những bản update mới nhất nữa."&@CRLF&@CRLF&"Bạn chắc chứ?");
	If $msg = 6 Then
		FileDelete(@StartupDir&"/AutoUpdate.exe");
		MsgBox(0,"Thông Báo","Đã xóa tự động cập nhật trên máy bạn.")
	EndIf
EndFunc

Func Goto($url)
	ShellExecute('chrome.exe',$url&' --new-tab --start-fullscreen');
EndFunc