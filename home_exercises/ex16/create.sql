-- KNOTS --------------------------------------------------------------------------------------------------------------
--
-- Knots are used to store finite sets of values, normally used to describe states
-- of entities (through knotted attributes) or relationships (through knotted ties).
-- Knots have their own surrogate identities and are therefore immutable.
-- Values can be added to the set over time though.
-- Knots should have values that are mutually exclusive and exhaustive.
-- Knots are unfolded when using equivalence.
--
-- ANCHORS AND ATTRIBUTES ---------------------------------------------------------------------------------------------
--
-- Anchors are used to store the identities of entities.
-- Anchors are immutable.
-- Attributes are used to store values for properties of entities.
-- Attributes are mutable, their values may change over one or more types of time.
-- Attributes have four flavors: static, historized, knotted static, and knotted historized.
-- Anchors may have zero or more adjoined attributes.
--
-- Anchor table -------------------------------------------------------------------------------------------------------
-- RE_Repo table (with 2 attributes)
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS hex16.RE_Repo (
    RE_ID IDENTITY(1,1) not null, 
    RE_Dummy bit null,
    constraint pkRE_Repo primary key (
        RE_ID
    )
) ORDER BY RE_ID SEGMENTED BY MODULARHASH(RE_ID) ALL NODES;
-- Historized attribute table -----------------------------------------------------------------------------------------
-- RE_WCH_Repo_Watches table (on RE_Repo)
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS hex16.RE_WCH_Repo_Watches (
    RE_WCH_RE_ID int not null,
    RE_WCH_Repo_Watches int not null,
    RE_WCH_ChangedAt datetime not null,
    constraint fkRE_WCH_Repo_Watches foreign key (
        RE_WCH_RE_ID
    ) references hex16.RE_Repo(RE_ID),
    constraint pkRE_WCH_Repo_Watches primary key (
        RE_WCH_RE_ID,
        RE_WCH_ChangedAt
    )
) ORDER BY RE_WCH_RE_ID, RE_WCH_ChangedAt SEGMENTED BY MODULARHASH(RE_WCH_RE_ID) ALL NODES;
-- Static attribute table ---------------------------------------------------------------------------------------------
-- RE_NAM_Repo_Name table (on RE_Repo)
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS hex16.RE_NAM_Repo_Name (
    RE_NAM_RE_ID int not null,
    RE_NAM_Repo_Name varchar(120) not null,
    constraint fkRE_NAM_Repo_Name foreign key (
        RE_NAM_RE_ID
    ) references hex16.RE_Repo(RE_ID),
    constraint pkRE_NAM_Repo_Name primary key (
        RE_NAM_RE_ID
    )
) ORDER BY RE_NAM_RE_ID SEGMENTED BY MODULARHASH(RE_NAM_RE_ID) ALL NODES;
-- Anchor table -------------------------------------------------------------------------------------------------------
-- CO_Commit table (with 4 attributes)
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS hex16.CO_Commit (
    CO_ID IDENTITY(1,1) not null, 
    CO_Dummy bit null,
    constraint pkCO_Commit primary key (
        CO_ID
    )
) ORDER BY CO_ID SEGMENTED BY MODULARHASH(CO_ID) ALL NODES;
-- Static attribute table ---------------------------------------------------------------------------------------------
-- CO_DAT_Commit_Date table (on CO_Commit)
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS hex16.CO_DAT_Commit_Date (
    CO_DAT_CO_ID int not null,
    CO_DAT_Commit_Date date not null,
    constraint fkCO_DAT_Commit_Date foreign key (
        CO_DAT_CO_ID
    ) references hex16.CO_Commit(CO_ID),
    constraint pkCO_DAT_Commit_Date primary key (
        CO_DAT_CO_ID
    )
) ORDER BY CO_DAT_CO_ID SEGMENTED BY MODULARHASH(CO_DAT_CO_ID) ALL NODES;
-- Static attribute table ---------------------------------------------------------------------------------------------
-- CO_AUT_Commit_Author table (on CO_Commit)
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS hex16.CO_AUT_Commit_Author (
    CO_AUT_CO_ID int not null,
    CO_AUT_Commit_Author varchar(100) not null,
    constraint fkCO_AUT_Commit_Author foreign key (
        CO_AUT_CO_ID
    ) references hex16.CO_Commit(CO_ID),
    constraint pkCO_AUT_Commit_Author primary key (
        CO_AUT_CO_ID
    )
) ORDER BY CO_AUT_CO_ID SEGMENTED BY MODULARHASH(CO_AUT_CO_ID) ALL NODES;
-- Static attribute table ---------------------------------------------------------------------------------------------
-- CO_MSG_Commit_Message table (on CO_Commit)
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS hex16.CO_MSG_Commit_Message (
    CO_MSG_CO_ID int not null,
    CO_MSG_Commit_Message varchar(4000) not null,
    constraint fkCO_MSG_Commit_Message foreign key (
        CO_MSG_CO_ID
    ) references hex16.CO_Commit(CO_ID),
    constraint pkCO_MSG_Commit_Message primary key (
        CO_MSG_CO_ID
    )
) ORDER BY CO_MSG_CO_ID SEGMENTED BY MODULARHASH(CO_MSG_CO_ID) ALL NODES;
-- Static attribute table ---------------------------------------------------------------------------------------------
-- CO_COM_Commit_Commit table (on CO_Commit)
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS hex16.CO_COM_Commit_Commit (
    CO_COM_CO_ID int not null,
    CO_COM_Commit_Commit varchar(150) not null,
    constraint fkCO_COM_Commit_Commit foreign key (
        CO_COM_CO_ID
    ) references hex16.CO_Commit(CO_ID),
    constraint pkCO_COM_Commit_Commit primary key (
        CO_COM_CO_ID
    )
) ORDER BY CO_COM_CO_ID SEGMENTED BY MODULARHASH(CO_COM_CO_ID) ALL NODES;
-- TIES ---------------------------------------------------------------------------------------------------------------
--
-- Ties are used to represent relationships between entities.
-- They come in four flavors: static, historized, knotted static, and knotted historized.
-- Ties have cardinality, constraining how members may participate in the relationship.
-- Every entity that is a member in a tie has a specified role in the relationship.
-- Ties must have at least two anchor roles and zero or more knot roles.
--
-- Static tie table ---------------------------------------------------------------------------------------------------
-- RE_has_CO_belongsTo table (having 2 roles)
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS hex16.RE_has_CO_belongsTo (
    RE_ID_has int not null, 
    CO_ID_belongsTo int not null, 
    constraint RE_has_CO_belongsTo_fkRE_has foreign key (
        RE_ID_has
    ) references hex16.RE_Repo(RE_ID), 
    constraint RE_has_CO_belongsTo_fkCO_belongsTo foreign key (
        CO_ID_belongsTo
    ) references hex16.CO_Commit(CO_ID), 
    constraint pkRE_has_CO_belongsTo primary key (
        RE_ID_has,
        CO_ID_belongsTo
    )
) ORDER BY
    RE_ID_has,
    CO_ID_belongsTo
SEGMENTED BY MODULARHASH(RE_ID_has) ALL NODES;
CREATE PROJECTION hex16.RE_has_CO_belongsTo__CO_ID_belongsTo
AS
SELECT
    RE_ID_has,
    CO_ID_belongsTo
FROM
    hex16.RE_has_CO_belongsTo
ORDER BY
    CO_ID_belongsTo,
    RE_ID_has
SEGMENTED BY MODULARHASH(CO_ID_belongsTo) ALL NODES;
