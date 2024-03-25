-- Создаем функцию рассчета стоимости передаваемого продукта
create function dbo.udf_GetSKUPrice(
    @ID_SKU int
)
returns decimal(18, 2)
as
begin
    declare 
        @TotalValue decimal(18, 2)
        ,@TotalQuantity int
        ,@UnitValue decimal(18, 2)

    -- Рассчитываем сумму "BaseValue"
    select @TotalValue = SUM(b.BaseValue)
    from dbo.Basket as b
    where b.ID_SKU = @ID_SKU

    -- Рассчитываем сумму "Quantity"
    select @TotalQuantity = SUM(b.Quantity)
    from dbo.Basket as b
    where b.ID_SKU = @ID_SKU

    -- Рассчитываем стоимость передаваемого продукта с проверкой деления на 0
    if @TotalQuantity <> 0
    begin
        SET @UnitValue = @TotalValue / @TotalQuantity
    end
    else
    begin
        -- В случае деления на 0 возвращаем "null"
        SET @UnitValue = null
    end

    return @UnitValue
end