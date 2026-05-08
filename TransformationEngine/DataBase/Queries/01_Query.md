Use TransformationEngine
select distinct map.ID as MapId, 
map.FieldID, 
_rule.RuleMethod,
map.ExecutionOrder,
map.LayoutID ,
layout.LayoutName
from dbo.TransformationEngine_FieldRule_Map map with (nolock)
left join dbo.TransformationEngine_Field field (nolock) on map.FieldID = field.FieldID
left join dbo.TransformationEngine_Rule _rule (nolock) on map.RuleID = _rule.RuleID
left join [dbo].[TransformationEngine_Layout] layout (nolock) on map.LayoutID = layout.LayoutID
where 
map.LayoutID = 4 and 
map.ID in (
1335
,1336
,191
) 
and map.FieldID in (
2506
,2506
,2506
)
order by map.ExecutionOrder
 
