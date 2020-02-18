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
    RE_WCH_Repo_Watches STRING not null,
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

-- Заполнение репозиториев
-- Представление-источник
-- Здесь считаем, что имя репозитория (бизнес-ключ) постоянно
-- и мы не пишем репозиторий с тем же именем, а только обновляем
-- его исторические данные (просмотры)
-----------------------------------------------------------------------------------------------------------------------
select t.*, GENERATE_UUID() as re_id
-- Репозиторий не должен существовать (repo_name not in hex16.RE_NAM_Repo_Name)
  from `bigquery-public-data.github_repos.sample_repos` t
  where repo_name in (
    'FreeCodeCamp/FreeCodeCamp',
    'firehol/netdata',
    'joshbuchea/HEAD'
  )
