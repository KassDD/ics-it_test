-- Создаем процедуру обновления данных в таблице dbo.Family в поле BudgetValue
create procedure dbo.usp_MakeFamilyPurchase
    @FamilySurName varchar(255)
as
begin
    declare 
        @ErrorMessage varchar(255)
        ,@SumValue decimal(18, 2)

    -- Проверка существования семьи в SurName таблицы dbo.Family
    if not exists (select 1 from dbo.Family as f where f.SurName = @FamilySurName)
    begin
        -- Если семья отсутствует, выдаем ошибку
        set @ErrorMessage = 'Такой семьи нет'
        raiserror(@ErrorMessage, 3, 1)
        
        return
    end

    -- Рассчитываем сумму покупок переданной семьи
    select @SumValue = SUM(b.BaseValue)
    from dbo.Basket as b
        inner join dbo.Family as f on f.ID = b.ID_Family
    where f.SurName = @FamilySurName

    -- Обновляем данные в таблицы dbo.Family в поле BudgetValue
    update dbo.Family
    set BudgetValue = BudgetValue - @SumValue
    where SurName = @FamilySurName
end
