package GameSystems;

import Data.Repository.FarmingRepository;
import Data.Repository.PlayerRepository;
import Entities.GrowingPlantEntity;
import Entities.PlantEntity;
import Entities.PlayerEntity;
import Enumerations.BackgroundID;
import GameObject.ItemGO;
import GameObject.PlayerGO;
import Helper.ColorToken;
import org.nwnx.nwnx2.jvm.NWLocation;
import org.nwnx.nwnx2.jvm.NWObject;
import org.nwnx.nwnx2.jvm.NWVector;
import org.nwnx.nwnx2.jvm.constants.ObjectType;

import java.util.List;
import java.util.concurrent.ThreadLocalRandom;

import static org.nwnx.nwnx2.jvm.NWScript.*;

public class FarmingSystem {

    public static void OnModuleLoad()
    {
        FarmingRepository farmRepo = new FarmingRepository();
        List<GrowingPlantEntity> plants = farmRepo.GetAllActiveGrowingPlants();

        for(GrowingPlantEntity plant: plants)
        {
            String resref = "growing_plant";
            if(plant.getRemainingTicks() <= 0)
                resref = plant.getPlant().getResref();

            NWObject area = getObjectByTag(plant.getLocationAreaTag(), 0);
            NWVector position = vector(plant.getLocationX(), plant.getLocationY(), plant.getLocationZ());
            NWLocation location = location(area, position, plant.getLocationOrientation());
            NWObject plantPlc = createObject(ObjectType.PLACEABLE, resref, location, false, "");
            setLocalInt(plantPlc, "GROWING_PLANT_ID", plant.getGrowingPlantID());

            if(plant.getRemainingTicks() > 0)
            {
                setName(plantPlc, "Growing Plant (" + plant.getPlant().getName() + ")");
            }
        }
    }

    public static String OnModuleExamine(String existingDescription, NWObject examinedObject)
    {
        int plantID = getLocalInt(examinedObject, "PLANT_ID");
        if(plantID <= 0) return existingDescription;
        if(getObjectType(examinedObject) != ObjectType.ITEM) return existingDescription;

        FarmingRepository farmRepo = new FarmingRepository();
        PlantEntity plant = farmRepo.GetPlantByID(plantID);
        if(plant == null) return existingDescription;

        existingDescription += ColorToken.Orange() + "This item can be planted. Farming skill required: " + plant.getLevel() + ColorToken.End() + "\n\n";
        return existingDescription;
    }

    public static void RemoveGrowingPlant(NWObject plant)
    {
        int growingPlantID = getLocalInt(plant, "GROWING_PLANT_ID");
        if(growingPlantID <= 0) return;

        FarmingRepository farmRepo = new FarmingRepository();
        GrowingPlantEntity growingPlant = farmRepo.GetGrowingPlantByID(growingPlantID);
        growingPlant.setActive(false);

        farmRepo.Save(growingPlant);
    }

    public static void HarvestPlant(NWObject oPC, NWObject shovel, NWObject plant)
    {
        int growingPlantID = getLocalInt(plant, "GROWING_PLANT_ID");
        if(growingPlantID <= 0) return;

        int charges = getItemCharges(shovel);
        if(charges <= 0)
        {
            sendMessageToPC(oPC, "Your shovel is broken.");
            return;
        }

        FarmingRepository farmRepo = new FarmingRepository();
        GrowingPlantEntity growingPlant = farmRepo.GetGrowingPlantByID(growingPlantID);
        PlantEntity plantEntity = growingPlant.getPlant();

        if(plantEntity.getSeedResref().equals(""))
        {
            sendMessageToPC(oPC, "That plant cannot be harvested.");
            return;
        }

        PlayerRepository playerRepo = new PlayerRepository();
        PlayerGO pcGO = new PlayerGO(oPC);
        PlayerEntity pcEntity = playerRepo.GetByPlayerID(pcGO.getUUID());

        // Farmers get a 5% chance to not expend a charge.
        if (pcEntity.getBackgroundID() != BackgroundID.Farmer || ThreadLocalRandom.current().nextInt(100) + 1 > 5) {
            ItemGO shovelGO = new ItemGO(shovel);
            shovelGO.ReduceItemCharges();
        }

        growingPlant.setActive(false);
        farmRepo.Save(growingPlant);

        createItemOnObject(plantEntity.getSeedResref(), oPC, 1, "");
        destroyObject(plant, 0.0f);

        floatingTextStringOnCreature("You harvest the plant.", oPC, false);
    }

}
