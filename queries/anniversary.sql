set @user_name = 'Roughneck';
set @user_id = (select user_id from f3soil.users where user_name = @user_name);
select @user_id, @user_name;
select
    *
from f3soil.backblast
where backblast like concat('%', @user_id, '%')
   or backblast like concat('%', @user_name, '%')
order by Date
    limit 3;
