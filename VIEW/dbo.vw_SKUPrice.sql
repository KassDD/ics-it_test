-- Создаем представление c выводом "dbo.SKU" и стоимости одного продукта
create view dbo.vw_SKUPrice
as
select
    s.*
    ,dbo.udf_GetSKUPrice(s.ID) as UnitValue
from dbo.SKU as s
