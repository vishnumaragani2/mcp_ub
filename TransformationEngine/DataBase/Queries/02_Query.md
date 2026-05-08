Use TransformationEngine

select map.ID as MapId, 
map.FieldID, 
_rule.RuleMethod,
field.FieldName,
map.ExecutionOrder, 
map.MapParameters, 
_rule.RuleMethod, 
_rule.RuleDescription
from dbo.TransformationEngine_FieldRule_Map map with (nolock)
left join dbo.TransformationEngine_Field field (nolock) on map.FieldID = field.FieldID
left join dbo.TransformationEngine_Rule _rule (nolock) on map.RuleID = _rule.RuleID
where map.ID in (1088
,1381
,1816
,1603
,1598
,1382
,1817
,1639
,1089
,1383
,1356
,1640
,1412
,1642
,1119
,1120
,253
,1384
,1385
,254
,1415
) 
and map.FieldID in (2007,2005,
2006
,2011
,2016
,2016
,2017
,2018
,2020
,2024
,2024
,2025
,2025
,2026
,2027
,2026
,2026
,2027
,2027
,2026)


