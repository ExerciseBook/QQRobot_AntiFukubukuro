{
	CoolQ SDK for Pascal/Delphi
	API版本	：	9.9
	编译器	：	FPC 3.0.0
	
	注意 Free Pascal
		里的时间库是以当前系统时间的 1970-1-1 00:00:00 作为Unix时间戳起点
		然而腾讯传递的信息是以 标准时间的1970-1-1 00:00:00 作为时间戳起点
}
library
	testdll;
	//DLL 编译

{$APPTYPE GUI}
{$I-}
{$h+}

Uses
	iconv,CoolQSDK,		//酷QSDK单元
	windows,math,dateutils,sysutils,Classes,
	
	plugin_events, //插件事件处理单元
	plugin_menu //插件菜单处理单元
	;
	//载入库






{ 
* 返回应用的ApiVer、Appid，打包后将不会调用
}
Function AppInfo:pChar;
stdcall; 
Begin
	CQAPPID:='com.superexercisebook.AntiFukubukuro';
	//请修改APPID为你的APPID
	
	
	//GlobalUTF8Mode:=true; //是否开启全局UTF8模式
	{
		酷Q的所有api现在使用的是gb18030作为unicode支持。
		开启这个功能后插件内的所有api将会由这个sdk内置的功能自动做gb18030与utf8的转换
	}
	
	//下面两行不用修改 //没毛病，的确是两行。 #滑稽
	CQAPPINFO:=CQAPIVERTEXT+','+CQAPPID;
{$IFDEF FPC}
	exit(StoP(CQAPPINFO));
{$ELSE}
	Result:=StoP(CQAPPINFO);
{$ENDIF}
End;

{
* 接收应用AuthCode，酷Q读取应用信息后，如果接受该应用，将会调用这个函数并传递AuthCode。
* 不要在本函数处理其他任何代码，以免发生异常情况。如需执行初始化代码请在Startup事件中执行（Type=1001）。
}
Function Initialize(ac:longint):longint;
stdcall;
Begin
	AuthCode:=ac;
	GlobalUTF8Mode:=true;
{$IFDEF FPC}
	exit(0);
{$ELSE}
	Result:=0;
{$ENDIF}
End;

Function _eventStartup:longint;
stdcall;
Begin
	randomize;
{$IFDEF FPC}
	exit(code_eventStartup);
{$ELSE}
	result:=code_eventStartup;
{$ENDIF}
End;

Function _eventExit:longint;
stdcall;
Begin
{$IFDEF FPC}
	exit(code_eventExit);
{$ELSE}
	result:=code_eventExit;
{$ENDIF}
End;

Function _eventEnable:longint;
stdcall;
Begin
	randomize;
{$IFDEF FPC}
	exit(code_eventEnable);
{$ELSE}
	result:=code_eventEnable;
{$ENDIF}
End;

Function _eventDisable:longint;
stdcall;
Begin
{$IFDEF FPC}
	exit(code_eventDisable);
{$ELSE}
	result:=code_eventDisable;
{$ENDIF}
End;

Function _eventPrivateMsg(
			subType,MsgID		:longint;
			fromQQ					:int64;
			const msg				:Pchar;
			font					:longint):longint;
stdcall;
Begin
{$IFDEF FPC}
	if GlobalUTF8Mode
	then
		exit(code_eventPrivateMsg(
				subType,MsgID,
				fromQQ,
				CoolQ_Tools_AnsiToUTF8(PtoS(msg)),
				font
			)
		)
	else
		exit(code_eventPrivateMsg(
				subType,MsgID,
				fromQQ,
				PtoS(msg),
				font
			)
		);
{$ELSE}
	if GlobalUTF8Mode
	then
		result:=code_eventPrivateMsg(
				subType,MsgID,
				fromQQ,
				CoolQ_Tools_AnsiToUTF8(PtoS(msg)),
				font
			)
	else
		result:=code_eventPrivateMsg(
				subType,MsgID,
				fromQQ,
				PtoS(msg),
				font
			);
{$ENDIF}
End;

Function _eventGroupMsg(
			subType,MsgID		:longint;
			fromgroup,fromQQ		:int64;
			const fromAnonymous,msg	:Pchar;
			font					:longint):longint;
stdcall;
Begin
{$IFDEF FPC}
	if GlobalUTF8Mode
	then
		exit(code_eventGroupMsg(
				subType,MsgID,
				fromgroup,fromQQ,
				PtoS(fromAnonymous),
				CoolQ_Tools_AnsiToUTF8(PtoS(msg)),
				font
			)
		)
	else
		exit(code_eventGroupMsg(
				subType,MsgID,
				fromgroup,fromQQ,
				PtoS(fromAnonymous),
				PtoS(msg),
				font
			)
		);
{$ELSE}
	if GlobalUTF8Mode
	then
		result:=code_eventGroupMsg(
				subType,MsgID,
				fromgroup,fromQQ,
				PtoS(fromAnonymous),
				CoolQ_Tools_AnsiToUTF8(PtoS(msg)),
				font
			)
	else
		result:=code_eventGroupMsg(
				subType,MsgID,
				fromgroup,fromQQ,
				PtoS(fromAnonymous),
				PtoS(msg),
				font
			);
{$ENDIF}
End;

Function _eventDiscussMsg(
			subType,MsgID		:longint;
			fromDiscuss,fromQQ		:int64;
			msg						:Pchar;
			font					:longint):longint;
stdcall;
Begin
{$IFDEF FPC}
	if GlobalUTF8Mode
	then
		exit(code_eventDiscussMsg(
			subType,MsgID,
			fromDiscuss,fromQQ,
			CoolQ_Tools_AnsiToUTF8(PtoS(msg)),
			font
			)
		)
	else
		exit(code_eventDiscussMsg(
			subType,MsgID,
			fromDiscuss,fromQQ,
			PtoS(msg),
			font
			)
		)
{$ELSE}
	if GlobalUTF8Mode
	then
		result:=code_eventDiscussMsg(
			subType,MsgID,
			fromDiscuss,fromQQ,
			CoolQ_Tools_AnsiToUTF8(PtoS(msg)),
			font
			)
	else
		result:=code_eventDiscussMsg(
			subType,MsgID,
			fromDiscuss,fromQQ,
			PtoS(msg),
			font
			)
{$ENDIF}
End;

Function _eventGroupUpload(
			subType,sendTime	:longint;
			fromGroup,fromQQ	:int64;
			fileinfo			:Pchar):longint;
stdcall;
Begin
{$IFDEF FPC}
	exit(code_eventGroupUpload(
			subType,sendTime,
			fromGroup,fromQQ,
			PtoS(fileinfo)));
{$ELSE}
	result:=code_eventGroupUpload(
			subType,sendTime,
			fromGroup,fromQQ,
			PtoS(fileinfo));
{$ENDIF}
End;

Function _eventSystem_GroupAdmin(
			subType,sendTime		:longint;
			fromGroup,
			beingOperateQQ			:int64):longint;
stdcall;
Begin
{$IFDEF FPC}
	exit(code_eventSystem_GroupAdmin(
		subType,sendTime,
		fromGroup,
		beingOperateQQ
		)
	); 
{$ELSE}
	result:=code_eventSystem_GroupAdmin(
		subType,sendTime,
		fromGroup,
		beingOperateQQ
		);
{$ENDIF}
End;

Function _eventSystem_GroupMemberDecrease(
			subType,sendTime		:longint;
			fromGroup,fromQQ,
			beingOperateQQ			:int64):longint;
stdcall;
Begin
{$IFDEF FPC}
	exit(code_eventSystem_GroupMemberDecrease(
			subType,sendTime,
			fromGroup,fromQQ,
			beingOperateQQ
		)
	);
{$ELSE}
	result:=code_eventSystem_GroupMemberDecrease(
			subType,sendTime,
			fromGroup,fromQQ,
			beingOperateQQ
		);
{$ENDIF}
End;

Function _eventSystem_GroupMemberIncrease(
			subType,sendTime		:longint;
			fromGroup,fromQQ,
			beingOperateQQ			:int64):longint;
stdcall;
Begin
{$IFDEF FPC}
	exit(code_eventSystem_GroupMemberIncrease(
			subType,sendTime,
			fromGroup,fromQQ,
			beingOperateQQ	
		)
	); 
{$ELSE}
	result:=code_eventSystem_GroupMemberIncrease(
			subType,sendTime,
			fromGroup,fromQQ,
			beingOperateQQ	
		);
{$ENDIF}
End;

Function _eventFriend_Add(
			subType,sendTime		:longint;
			fromQQ					:int64):longint;
stdcall;
Begin
{$IFDEF FPC}
	exit(code_eventFriend_Add(
			subType,sendTime,fromQQ
		)
	);
{$ELSE}
	result:=code_eventFriend_Add(
			subType,sendTime,fromQQ
		);
{$ENDIF}
End;

Function _eventRequest_AddFriend(
			subType,sendTime			:longint;
			fromQQ						:int64;
			const msg,responseFlag		:Pchar):longint;
stdcall;
Begin
{$IFDEF FPC}
	if GlobalUTF8Mode
	then
		exit(code_eventRequest_AddFriend(
				subType,sendTime,
				fromQQ,
				CoolQ_Tools_AnsiToUTF8(PtoS(msg)),
				responseFlag
			)
		)
	else
		exit(code_eventRequest_AddFriend(
				subType,sendTime,
				fromQQ,
				PtoS(msg),
				responseFlag
			)
		);
{$ELSE}
	if GlobalUTF8Mode
	then
		result:=code_eventRequest_AddFriend(
				subType,sendTime,
				fromQQ,
				CoolQ_Tools_AnsiToUTF8(PtoS(msg)),
				responseFlag
			)
	else
		result:=code_eventRequest_AddFriend(
				subType,sendTime,
				fromQQ,
				PtoS(msg),
				responseFlag
			);
{$ENDIF}
End;

Function _eventRequest_AddGroup(
			subType,sendTime			:longint;
			fromGroup,fromQQ			:int64;
			msg,responseFlag			:Pchar):longint;
stdcall;
Begin
{$IFDEF FPC}
	if GlobalUTF8Mode
	then
		exit(code_eventRequest_AddGroup(
				subType,sendTime,
				fromGroup,fromQQ,
				CoolQ_Tools_AnsiToUTF8(PtoS(msg)),
				responseFlag
			)
		)
	else
		exit(code_eventRequest_AddGroup(
				subType,sendTime,
				fromGroup,fromQQ,
				PtoS(msg),
				responseFlag
			)
		);
{$ELSE}
	if GlobalUTF8Mode
	then
		result:=code_eventRequest_AddGroup(
				subType,sendTime,
				fromGroup,fromQQ,
				CoolQ_Tools_AnsiToUTF8(PtoS(msg)),
				responseFlag
			)
	else
		result:=code_eventRequest_AddGroup(
				subType,sendTime,
				fromGroup,fromQQ,
				PtoS(msg),
				responseFlag
			);
{$ENDIF}
End;

exports
	//这里是允许外部调用的函数列表
	//index 后面跟着的数字只是强迫症调整顺序用的←_← 貌似没有什么实际用途
	AppInfo index 1,
	Initialize index 2,
	_eventStartup index 3,
	_eventExit index 4,
	_eventEnable index 5,
	_eventDisable index 6,
	_eventPrivateMsg index 7,
	_eventGroupMsg index 8,
	_eventDiscussMsg index 9,
	_eventGroupUpload index 10,
	_eventSystem_GroupAdmin index 11,
	_eventSystem_GroupMemberDecrease index 12,
	_eventSystem_GroupMemberIncrease index 13,
	_eventFriend_Add index 14,
	_eventRequest_AddFriend index 15,
	_eventRequest_AddGroup index 16,
	
	
	_menuA index 17,
	_menuB index 18;
	
Begin
End.