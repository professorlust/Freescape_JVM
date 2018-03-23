package GameSystems;

import Data.Repository.SkillRepository;
import Entities.*;
import GameObject.PlayerGO;
import Helper.ColorToken;
import Helper.ErrorHelper;
import Data.Repository.CraftRepository;
import Helper.ItemHelper;
import NWNX.NWNX_Player;
import org.nwnx.nwnx2.jvm.NWObject;
import org.nwnx.nwnx2.jvm.NWScript;
import org.nwnx.nwnx2.jvm.Scheduler;
import org.nwnx.nwnx2.jvm.constants.Animation;
import org.nwnx.nwnx2.jvm.constants.DurationType;
import org.nwnx.nwnx2.jvm.constants.ObjectType;
import org.nwnx.nwnx2.jvm.constants.VfxComBlood;

import java.util.HashMap;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;


public class CraftSystem {

    private static final float CraftDelay = 10.0f;


    public static void CraftItem(final NWObject oPC, final NWObject device, final int blueprintID)
    {
        final PlayerGO pcGO = new PlayerGO(oPC);

        if(pcGO.isBusy())
        {
            NWScript.sendMessageToPC(oPC, "You are too busy right now.");
            return;
        }
        pcGO.setIsBusy(true);

        CraftRepository repo = new CraftRepository();
        CraftBlueprintEntity blueprint = repo.GetBlueprintByID(blueprintID);
        if(blueprint == null) return;

        boolean allComponentsFound = CheckItemCounts(oPC, device, blueprint.getComponents());

        if(allComponentsFound)
        {
            final float modifiedCraftDelay = CraftDelay;

            NWScript.applyEffectToObject(DurationType.TEMPORARY, NWScript.effectCutsceneImmobilize(), oPC, modifiedCraftDelay + 0.1f);
            Scheduler.assign(oPC, () -> {
                NWScript.clearAllActions(false);
                NWScript.actionPlayAnimation(Animation.LOOPING_GET_MID, 1.0f, modifiedCraftDelay);
            });
            Scheduler.delay(device, 1000 * NWScript.floatToInt(modifiedCraftDelay / 2.0f), () -> NWScript.applyEffectToObject(DurationType.INSTANT, NWScript.effectVisualEffect(VfxComBlood.SPARK_MEDIUM, false), device, 0.0f));

            NWNX_Player.StartGuiTimingBar(oPC, NWScript.floatToInt(modifiedCraftDelay), "");

            Scheduler.delay(oPC, NWScript.floatToInt(modifiedCraftDelay * 1000), () -> {
                try
                {
                    RunCreateItem(oPC, device, blueprintID);
                    pcGO.setIsBusy(false);
                }
                catch (Exception ex)
                {
                    ErrorHelper.HandleException(ex, "");
                }
            });
        }
        else
        {
            NWScript.sendMessageToPC(oPC, ColorToken.Red() + "You are missing required components..." + ColorToken.End());
        }
    }

    private static boolean CheckItemCounts(NWObject oPC, NWObject device, List<CraftComponentEntity> componentList)
    {
        PlayerGO pcGO = new PlayerGO(oPC);
        boolean allComponentsFound = false;
        HashMap<String, Integer> components = new HashMap<>();

        for(CraftComponentEntity component : componentList)
        {
            components.put(component.getItemResref(), component.getQuantity());
        }

        NWObject tempStorage = NWScript.createObject(ObjectType.PLACEABLE, "craft_temp_store", NWScript.getLocation(device), false, "");
        NWScript.setLocalObject(device, "CRAFT_TEMP_STORAGE", tempStorage);

        for(NWObject item : NWScript.getItemsInInventory(device)) {
            String resref = NWScript.getResRef(item);
            if (components.containsKey(resref) && components.get(resref) > 0) {
                components.put(resref, components.get(resref) - 1);

                NWScript.copyItem(item, tempStorage, true);
                NWScript.destroyObject(item, 0.0f);
            }

            int remainingQuantities = 0;
            for (int quantity : components.values())
                remainingQuantities += quantity;

            if (remainingQuantities <= 0) {
                allComponentsFound = true;
                break;
            }
        }

        if(!allComponentsFound)
        {
            for(NWObject item : NWScript.getItemsInInventory(tempStorage))
            {
                NWScript.copyItem(item, device, true);
                NWScript.destroyObject(item, 0.0f);
            }
            pcGO.setIsBusy(false);
        }

        return allComponentsFound;
    }

    private static void RunCreateItem(NWObject oPC, NWObject device, int blueprintID)
    {
        NWObject tempStorage = NWScript.getLocalObject(device, "CRAFT_TEMP_STORAGE");
        PlayerGO pcGO = new PlayerGO(oPC);
        CraftRepository craftRepo = new CraftRepository();
        SkillRepository skillRepo = new SkillRepository();

        CraftBlueprintEntity blueprint = craftRepo.GetBlueprintByID(blueprintID);
        PCSkillEntity pcSkill = skillRepo.GetPCSkillByID(pcGO.getUUID(), blueprint.getSkill().getSkillID());
        float chance = CalculateChanceToCreateItem(pcSkill.getRank(), blueprint.getLevel());
        float roll = ThreadLocalRandom.current().nextFloat() * 100.0f;
        float xpModifier;

        if(roll <= chance)
        {
            // Success!
            for(NWObject item : NWScript.getItemsInInventory(tempStorage))
            {
                NWScript.destroyObject(item, 0.0f);
            }

            NWScript.createItemOnObject(blueprint.getItemResref(), oPC, blueprint.getQuantity(), "");
            NWScript.sendMessageToPC(oPC, "You created " + blueprint.getQuantity() + "x " + blueprint.getItemName() + "!");
            xpModifier = 1.0f;
        }
        else
        {
            // Failure...
            NWObject[] items = NWScript.getItemsInInventory(tempStorage);
            int chanceToLoseItems = 20;

            for(NWObject item : items)
            {
                if(ThreadLocalRandom.current().nextInt(100) > chanceToLoseItems)
                {
                    NWScript.copyItem(item, device, true);
                }
                NWScript.destroyObject(item, 0.0f);
            }

            NWScript.sendMessageToPC(oPC, "You failed to create that item...");
            xpModifier = 0.2f;
        }

        float xp = SkillSystem.CalculateSkillAdjustedXP(250, blueprint.getLevel(), pcSkill.getRank()) * xpModifier;
        NWScript.destroyObject(tempStorage, 0.0f);
        SkillSystem.GiveSkillXP(oPC, blueprint.getSkill().getSkillID(), (int)xp);
    }

    private static String CalculateDifficulty(int pcLevel, int blueprintLevel)
    {
        int delta = pcLevel - blueprintLevel;
        String difficulty = "";

        if(delta <= -5)
        {
            difficulty = ColorToken.Custom(255, 62, 150) + "Impossible" + ColorToken.End();
        }
        else if(delta >= 4)
        {
            difficulty = ColorToken.Custom(102, 255, 102) + "Trivial" + ColorToken.End();
        }
        else
        {
            switch (delta)
            {
                case -4:
                    difficulty = ColorToken.Custom(220, 20, 60) + "Extremely Difficult" + ColorToken.End();
                    break;
                case -3:
                    difficulty = ColorToken.Custom(255, 69, 0) + "Very Difficult" + ColorToken.End();
                    break;
                case -2:
                    difficulty = ColorToken.Custom(255, 165, 0) + "Difficult" + ColorToken.End();
                    break;
                case -1:
                    difficulty = ColorToken.Custom(238, 238, 0) + "Challenging" + ColorToken.End();
                    break;
                case 0:
                    difficulty = ColorToken.Custom(255, 255, 255) + "Moderate" + ColorToken.End();
                    break;
                case 1:
                    difficulty = ColorToken.Custom(65, 105, 225) + "Easy" + ColorToken.End();
                    break;
                case 2:
                    difficulty = ColorToken.Custom(113, 113, 198) + "Very Easy" + ColorToken.End();
                    break;
                case 3:
                    difficulty = ColorToken.Custom(153, 255, 255) + "Extremely Easy" + ColorToken.End();
                    break;
            }
        }


        return difficulty;
    }


    private static float CalculateChanceToCreateItem(int pcLevel, int blueprintLevel)
    {
        int delta = pcLevel - blueprintLevel;
        float percentage = 0.0f;

        if (delta <= -5)
        {
            percentage = 0.0f;
        }
        else if(delta >= 4)
        {
            percentage = 95.0f;
        }
        else
        {
            switch (delta)
            {
                case -4:
                    percentage = 15.0f;
                    break;
                case -3:
                    percentage = 25.0f;
                    break;
                case -2:
                    percentage = 40.0f;
                    break;
                case -1:
                    percentage = 60.0f;
                    break;
                case 0:
                    percentage = 75.0f;
                    break;
                case 1:
                    percentage = 82.5f;
                    break;
                case 2:
                    percentage = 87.0f;
                    break;
                case 3:
                    percentage = 90.0f;
                    break;
            }
        }


        return percentage;
    }

    public static String BuildBlueprintHeader(NWObject oPC, int blueprintID)
    {
        PlayerGO pcGO = new PlayerGO(oPC);
        CraftRepository craftRepo = new CraftRepository();
        SkillRepository skillRepo = new SkillRepository();

        CraftBlueprintEntity blueprint = craftRepo.GetBlueprintByID(blueprintID);
        PCSkillEntity pcSkill = skillRepo.GetPCSkillByID(pcGO.getUUID(), blueprint.getSkill().getSkillID());


        String header = ColorToken.Green() + "Blueprint: " + ColorToken.End() + ColorToken.White() + blueprint.getItemName() + ColorToken.End() + "\n\n";
        header += ColorToken.Green() + "Skill: " + ColorToken.End() + ColorToken.White() + pcSkill.getSkill().getName() + " (" + pcSkill.getRank() + ")" + ColorToken.End() + "\n";
        header += ColorToken.Green() + "Difficulty: " + ColorToken.End() + CalculateDifficulty(pcSkill.getRank(), blueprint.getLevel()) + "\n\n";
        header += ColorToken.Green() + "Components: " + ColorToken.End() + "\n\n";

        for(CraftComponentEntity component : blueprint.getComponents())
        {
            String name = ItemHelper.GetNameByResref(component.getItemResref());
            header += ColorToken.White() + component.getQuantity() + "x " + name + ColorToken.End() + "\n";
        }

        return header;
    }

}
