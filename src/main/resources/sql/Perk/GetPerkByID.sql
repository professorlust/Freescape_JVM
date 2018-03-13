

SELECT p.PerkID ,
       p.Name ,
       p.FeatID ,
       p.IsActive ,
       p.JavaScriptName ,
       p.BaseManaCost ,
       p.BaseCastingTime ,
       p.Description ,
       p.PerkCategoryID ,
       p.CooldownCategoryID ,
       p.IsQueuedWeaponSkill
FROM dbo.Perks p
WHERE p.PerkID = :perkID