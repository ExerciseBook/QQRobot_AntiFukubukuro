{
     本文件为 伪Essentials_仿GroupManager 的SDK
	 社区地址 https://cqp.cc/t/25690
}

unit ESSGM;
{$IFDEF FPC}
	{$MODE DELPHI}
{$ENDIF}
{$UNITPATH ..\}

interface
//function GM_Initialize(AuthCode:longint):longint;
function GM_GetPermissionStatus(Group,QQ:int64;Permission:Ansistring):longint;
function GM_GetPermissionValue(Group,QQ:int64;Permission:Ansistring):Ansistring;

implementation

uses CoolQSDK;

//function GM_Initialize(AuthCode:longint):longint;
//	stdcall; external 'ESSGM.dll' name 'Initialize';	
function GM_GetPermissionStatus_(Group,QQ:int64;Permission:Pchar):longint;
	stdcall; external 'ESSGM.dll' name 'GM_GetPermissionStatus';
function GM_GetPermissionValue_(Group,QQ:int64;Permission:Pchar):Pchar;
	stdcall; external 'ESSGM.dll' name 'GM_GetPermissionValue';
	
function GM_GetPermissionStatus(Group,QQ:int64;Permission:Ansistring):longint;
Begin
	result:=(GM_GetPermissionStatus_(Group,QQ,StoP(Permission)));
End;
function GM_GetPermissionValue(Group,QQ:int64;Permission:Ansistring):Ansistring;
Begin
	result:=(PtoS(GM_GetPermissionValue_(Group,QQ,StoP(Permission))));
End;

end.
