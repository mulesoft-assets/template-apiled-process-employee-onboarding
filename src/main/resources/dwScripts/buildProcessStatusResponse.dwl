%dw 1.0
%output application/json
%var sfdcSysPath = "http://" ++ p('system.api.user.sfdc.domain') ++ ":" ++ p('system.api.user.sfdc.http.port') ++ p('system.api.user.sfdc.basePath') ++ "/employees/"
%var netsuiteSysPath = "http://" ++ p('system.api.employee.nets.domain') ++ ":" ++ p('system.api.employee.nets.http.port') ++ p('system.api.employee.nets.basePath') ++ "/employees/"
%var workdaySysPath = "http://" ++ p('system.api.employee.wday.domain') ++ ":" ++ p('system.api.employee.wday.http.port') ++ p('system.api.employee.wday.basePath') ++ "/employees/"
---
{
	"id": payload.id,
	"employeeSfdcUrl": sfdcSysPath ++ payload.sfdcId,
	"employeeNetsuiteUrl": netsuiteSysPath ++ payload.netsuiteId,
	"employeeWorkdayUrl": workdaySysPath ++ payload.workdayId
}