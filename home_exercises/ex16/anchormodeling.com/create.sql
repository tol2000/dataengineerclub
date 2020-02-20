drop table hex16.RE_Repo;
drop table hex16.RE_WCH_Repo_Watches;
drop table hex16.RE_NAM_Repo_Name;
drop table hex16.CO_Commit;
drop table hex16.CO_DAT_Commit_Date;
drop table hex16.CO_AUT_Commit_Author;
drop table hex16.CO_MSG_Commit_Message;
drop table hex16.CO_COM_Commit_Commit;
drop table hex16.RE_has_CO_belongsTo;

-- Anchor table -------------------------------------------------------------------------------------------------------
-- RE_Repo table (with 2 attributes)
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS hex16.RE_Repo (
    RE_ID STRING not null
);
-- Historized attribute table -----------------------------------------------------------------------------------------
-- RE_WCH_Repo_Watches table (on RE_Repo)
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS hex16.RE_WCH_Repo_Watches (
    RE_WCH_RE_ID STRING not null,
    RE_WCH_Repo_Watches INT64 not null,
    RE_WCH_ChangedAt datetime not null
);
-- Static attribute table ---------------------------------------------------------------------------------------------
-- RE_NAM_Repo_Name table (on RE_Repo)
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS hex16.RE_NAM_Repo_Name (
    RE_NAM_RE_ID STRING not null,
    RE_NAM_Repo_Name STRING not null
);

-- Anchor table -------------------------------------------------------------------------------------------------------
-- CO_Commit table (with 4 attributes)
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS hex16.CO_Commit (
    CO_ID STRING not null, 
);
-- Static attribute table ---------------------------------------------------------------------------------------------
-- CO_DAT_Commit_Date table (on CO_Commit)
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS hex16.CO_DAT_Commit_Date (
    CO_DAT_CO_ID STRING not null,
    CO_DAT_Commit_Date DATETIME not null
);
-- Static attribute table ---------------------------------------------------------------------------------------------
-- CO_AUT_Commit_Author table (on CO_Commit)
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS hex16.CO_AUT_Commit_Author (
    CO_AUT_CO_ID STRING not null,
    CO_AUT_Commit_Author STRING not null
);
-- Static attribute table ---------------------------------------------------------------------------------------------
-- CO_MSG_Commit_Message table (on CO_Commit)
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS hex16.CO_MSG_Commit_Message (
    CO_MSG_CO_ID INT64 not null,
    CO_MSG_Commit_Message STRING not null
);
-- Static attribute table ---------------------------------------------------------------------------------------------
-- CO_COM_Commit_Commit table (on CO_Commit)
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS hex16.CO_COM_Commit_Commit (
    CO_COM_CO_ID STRING not null,
    CO_COM_Commit_Commit STRING not null
);

-- Static tie table ---------------------------------------------------------------------------------------------------
-- RE_has_CO_belongsTo table (having 2 roles)
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS hex16.RE_has_CO_belongsTo (
    RE_ID_has STRING not null, 
    CO_ID_belongsTo STRING not null
);

-- Представления для заполнения хранилища
-----------------------------------------------------------------------------------------------------------------------

create or replace view hex16.etl_nonhistorical_repository as
-- Неисторические данные по репозиториям
-- Добавляются только одиин раз
-- Изменение имени репозитория - новая сущность (запись в якоре)
select GENERATE_UUID() as re_id, t.repo_name
  from `bigquery-public-data.github_repos.sample_repos` t
  left outer join `crafty-centaur-261609.hex16.RE_NAM_Repo_Name` re on t.repo_name = re.RE_NAM_Repo_Name 
  where repo_name in (
    -- для примера берем несколько наиболее часто просматриваемых репозиториев
    'FreeCodeCamp/FreeCodeCamp',
    'firehol/netdata',
    'joshbuchea/HEAD'
  )
  and re.RE_NAM_RE_ID is null -- выбираем только несуществующие у нас репозитории
;

-- Следующий блок имитирует загрузку нового репозитория и его неисторичных данных по одной строке
-- Выполняем его до тех пор, пока не возникнет ошибка, связанная с тем, что источник пуст
-----------------------------------------------------------------------------------------------------------------------
-- Загрузка нового репозитория
declare pp_re_id, pp_re_name string;
set (pp_re_id, pp_re_name) =
(
  select as struct re_id, repo_name
    from hex16.etl_nonhistorical_repository
    limit 1
);
insert into `hex16.RE_Repo` (re_id) values (pp_re_id);
insert into `hex16.RE_NAM_Repo_Name` (RE_NAM_RE_ID, RE_NAM_Repo_Name) values (pp_re_id, pp_re_name);
-- Просмотр хранилища репозиториев
select *
  from `hex16.RE_Repo` r
  inner join `hex16.RE_NAM_Repo_Name` rn on r.RE_ID = rn.RE_NAM_RE_ID;

-- Загрузка исторических данных по репозиториям (просмотры)
-----------------------------------------------------------------------------------------------------------------------
-- Представление-источник исторических данных по репозиториям
--create or replace view hex16.etl_historical_repository_watches as
-- Исторические данные по репозиториям
-- Только по тем репозиториям, что у нас уже есть.
-- Предполагаем, что перед этим уже загрузили все новые репозитории в соотв. якорь
-- При каждой загрузке добавляем новую запись в историю количества просмотров репозитория
-- Хотел сделать дедупликацию, то есть при том же количестве просмотров, что был,
--   обновлять только историческую дату, но потом вспомнил, что якорная модель запрещает
--   в таких данных любые апдейты, только новые записи, да и DWH плохо относится к апдейтам,
--   а еще и может нарушиться партицирование или сегментирование, поэтому забраковал.
select rn.RE_NAM_RE_ID as RE_ID, t.watch_count, current_datetime() as changed_at
  from `bigquery-public-data.github_repos.sample_repos` t
  inner join `crafty-centaur-261609.hex16.RE_NAM_Repo_Name` rn on t.repo_name = rn.RE_NAM_Repo_Name
  -- Предполагаю, что current_datetime() в этом запросе вернет в двух местах одно и то же значение, иначе условие ниже может не выполниться.
  -- Где-то я читал, что именно current_datetime() возвращает таймстамп начала выполнения всего запроса, но, возможно, это не в bigquery.
  -- Возможно, в реальной системе я бы для надежности попытался выбрать его где-то в одном месте, но тогда это был бы скрипт, а не представление-источник
  left outer join `crafty-centaur-261609.hex16.RE_WCH_Repo_Watches` rw on rn.RE_NAM_RE_ID = rw.RE_WCH_RE_ID and current_datetime() = rw.RE_WCH_ChangedAt 
;
-- Загружаем оптом всю историю всех репозиториев, что есть у нас в хранилище
-- В реальном мире, наверное, это будет слишком, можно грузить только измененные
--   просмотры или распараллелить...
-- Запрос можно выполнить несколько раз, чтобы создалась история
insert into `hex16.RE_WCH_Repo_Watches` ( RE_WCH_RE_ID, RE_WCH_Repo_Watches, RE_WCH_ChangedAt )
select RE_ID
       -- при помощи секунд имитируем изменения в просмотрах, т.к. датасет меняется не часто.
       , watch_count + extract(second from current_datetime())
       , changed_at from `hex16.etl_historical_repository_watches`;

