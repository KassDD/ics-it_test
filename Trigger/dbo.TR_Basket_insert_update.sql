-- Создаем триггер для подсчета скидки
create trigger dbo.TR_Basket_insert_update 
on dbo.Basket
after insert
as
begin
    declare
        @ID_SKU int
        ,@Count int
    
    -- Получаем ID_SKU и количество добавленных по нему записей
    select @ID_SKU = i.ID_SKU, @Count = count(*)
    from inserted as i
    group by i.ID_SKU

    -- Обновляем DiscountValue в зависимости от количества записей
    update dbo.Basket
    set DiscountValue =
        case
            when @Count >= 2
                then BaseValue * 0.05
            else 0
        end
    where ID_SKU = @ID_SKU
end