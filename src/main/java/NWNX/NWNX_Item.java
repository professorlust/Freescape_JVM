package NWNX;

import org.nwnx.nwnx2.jvm.NWObject;

import static NWNX.NWNX_Core.*;

public class NWNX_Item {

    private static final String NWNX_Item = "NWNX_Item";

    // Set oItem's weight. Will not persist through saving.
    public static void SetWeight(NWObject oItem, int w)
    {
        String sFunc = "SetWeight";

        NWNX_PushArgumentInt(NWNX_Item, sFunc, w);
        NWNX_PushArgumentObject(NWNX_Item, sFunc, oItem);

        NWNX_CallFunction(NWNX_Item, sFunc);
    }

    // Set oItem's base value in gold pieces (Total cost = base_value +
    // additional_value). Will not persist through saving.
    // NOTE: Equivalent to SetGoldPieceValue NWNX2 function
    public static void SetBaseGoldPieceValue(NWObject oItem, int g)
    {
        String sFunc = "SetBaseGoldPieceValue";

        NWNX_PushArgumentInt(NWNX_Item, sFunc, g);
        NWNX_PushArgumentObject(NWNX_Item, sFunc, oItem);

        NWNX_CallFunction(NWNX_Item, sFunc);
    }

    // Set oItem's additional value in gold pieces (Total cost = base_value +
    // additional_value). Will persist through saving.
    public static void SetAddGoldPieceValue(NWObject oItem, int g)
    {
        String sFunc = "SetAddGoldPieceValue";

        NWNX_PushArgumentInt(NWNX_Item, sFunc, g);
        NWNX_PushArgumentObject(NWNX_Item, sFunc, oItem);

        NWNX_CallFunction(NWNX_Item, sFunc);
    }

    // Get oItem's base value in gold pieces.
    public static int GetBaseGoldPieceValue(NWObject oItem)
    {
        String sFunc = "GetBaseGoldPieceValue";

        NWNX_PushArgumentObject(NWNX_Item, sFunc, oItem);

        NWNX_CallFunction(NWNX_Item, sFunc);
        return NWNX_GetReturnValueInt(NWNX_Item, sFunc);
    }

    // Get oItem's additional value in gold pieces.
    public static int GetAddGoldPieceValue(NWObject oItem)
    {
        String sFunc = "GetAddGoldPieceValue";

        NWNX_PushArgumentObject(NWNX_Item, sFunc, oItem);

        NWNX_CallFunction(NWNX_Item, sFunc);
        return NWNX_GetReturnValueInt(NWNX_Item, sFunc);
    }

    // Set oItem's base item type. This will not be visible until the
    // item is refreshed (e.g. drop and take the item, or logging out
    // and back in).
    public static void SetBaseItemType(NWObject oItem, int nBaseItem)
    {
        String sFunc = "SetBaseItemType";

        NWNX_PushArgumentInt(NWNX_Item, sFunc, nBaseItem);
        NWNX_PushArgumentObject(NWNX_Item, sFunc, oItem);

        NWNX_CallFunction(NWNX_Item, sFunc);
    }

    // Make a single change to the appearance of an item. This will not be visible to PCs until
    // the item is refreshed for them (e.g. by logging out and back in).
    // Helmet models and simple items ignore iIndex.
    // nType                            nIndex                              nValue
    // ITEM_APPR_TYPE_SIMPLE_MODEL      [Ignored]                           Model #
    // ITEM_APPR_TYPE_WEAPON_COLOR      ITEM_APPR_WEAPON_COLOR_*            0-255
    // ITEM_APPR_TYPE_WEAPON_MODEL      ITEM_APPR_WEAPON_MODEL_*            Model #
    // ITEM_APPR_TYPE_ARMOR_MODEL       ITEM_APPR_ARMOR_MODEL_*             Model #
    // ITEM_APPR_TYPE_ARMOR_COLOR       ITEM_APPR_ARMOR_COLOR_* [0]         0-255 [1]
    //
    // [0] Alternatively, where ITEM_APPR_TYPE_ARMOR_COLOR is specified, if per-part coloring is
    // desired, the following equation can be used for nIndex to achieve that:
    //
    // ITEM_APPR_ARMOR_NUM_COLORS + (ITEM_APPR_ARMOR_MODEL_ * ITEM_APPR_ARMOR_NUM_COLORS) + ITEM_APPR_ARMOR_COLOR_
    //
    // For example, to change the CLOTH1 channel of the torso, nIndex would be:
    //
    //     6 + (7 * 6) + 2 = 50
    //
    // [1] When specifying per-part coloring, the value 255 corresponds with the logical
    // function 'clear colour override', which clears the per-part override for that part.
    public static void SetItemAppearance(NWObject oItem, int nType, int nIndex, int nValue)
    {
        String sFunc = "SetItemAppearance";

        NWNX_PushArgumentInt(NWNX_Item, sFunc, nValue);
        NWNX_PushArgumentInt(NWNX_Item, sFunc, nIndex);
        NWNX_PushArgumentInt(NWNX_Item, sFunc, nType);
        NWNX_PushArgumentObject(NWNX_Item, sFunc, oItem);

        NWNX_CallFunction(NWNX_Item, sFunc);

    }

    // Return a String containing the entire appearance for oItem which can later be
    // passed to RestoreItemAppearance().
    public static String GetEntireItemAppearance(NWObject oItem)
    {
        String sFunc = "GetEntireItemAppearance";

        NWNX_PushArgumentObject(NWNX_Item, sFunc, oItem);

        NWNX_CallFunction(NWNX_Item, sFunc);
        return NWNX_GetReturnValueString(NWNX_Item, sFunc);
    }

    // Restore an item's appearance with the value returned by GetEntireItemAppearance().
    public static void RestoreItemAppearance(NWObject oItem, String sApp)
    {
        String sFunc = "RestoreItemAppearance";

        NWNX_PushArgumentString(NWNX_Item, sFunc, sApp);
        NWNX_PushArgumentObject(NWNX_Item, sFunc, oItem);

        NWNX_CallFunction(NWNX_Item, sFunc);
    }


    public static void SetArmorValue(NWObject oItem, int armorValue)
    {
        String sFunc = "SetArmorValue";

        NWNX_PushArgumentInt(NWNX_Item, sFunc, armorValue);
        NWNX_PushArgumentObject(NWNX_Item, sFunc, oItem);

        NWNX_CallFunction(NWNX_Item, sFunc);
    }

    public static int GetArmorValue(NWObject oItem)
    {
        String sFunc = "GetArmorValue";

        NWNX_PushArgumentObject(NWNX_Item, sFunc, oItem);

        NWNX_CallFunction(NWNX_Item, sFunc);
        return NWNX_GetReturnValueInt(NWNX_Item, sFunc);
    }

}
