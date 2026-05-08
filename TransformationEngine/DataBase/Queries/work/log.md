# Work Log - Transformation Engine Queries
**Date:** 2026-05-08

## Database
- **Server:** AETDENTDB01
- **Database:** TransformationEngine

## Tables Identified

| # | Table | Description |
|---|-------|-------------|
| 1 | `dbo.TransformationEngine_FieldRule_Map` | Maps fields to rules (MapId, FieldID, RuleID, LayoutID, ExecutionOrder, MapParameters) |
| 2 | `dbo.TransformationEngine_Field` | Field definitions (FieldID, FieldName) |
| 3 | `dbo.TransformationEngine_Rule` | Rule definitions (RuleID, RuleMethod, RuleDescription) |
| 4 | `dbo.TransformationEngine_Layout` | Layout definitions (LayoutID, LayoutName) |

## Table Relationships
- `TransformationEngine_FieldRule_Map.FieldID` → `TransformationEngine_Field.FieldID`
- `TransformationEngine_FieldRule_Map.RuleID` → `TransformationEngine_Rule.RuleID`
- `TransformationEngine_FieldRule_Map.LayoutID` → `TransformationEngine_Layout.LayoutID`
