%dw 1.0
%output application/json
---
{
	"sfdcId":payload[0].id,
	"netsuiteId":payload[1].id,
	"workdayId":payload[2].id
}