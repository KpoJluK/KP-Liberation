/*
    KP Liberation arsenal dialog

    File: KPLIB_arsenal.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-11-12
    Last Update: 2019-05-02
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        A lightweight pre arsenal dialog which provides several features, like equipment loading/copying and the arsenal access.
*/

class SPEC_arsenal {
    idd = SPEC_IDC_ARSENAL_DIALOG;
    movingEnable = 0;

    class controlsBackground {

        class SPEC_DialogTitle: KPGUI_PRE_DialogTitleC {
            text = "$STR_KPLIB_DIALOG_ARSENAL_TITLE";
        };

        class KPLIB_DialogArea: KPGUI_PRE_DialogBackgroundC {};

    };

    class controls {

        class SPEC_LoadoutList: KPGUI_PRE_ListBox {
            idc = SPEC_IDC_ARSENAL_LOADOUTLIST;
            x = KP_GETCX(KP_X_VAL_C,KP_WIDTH_VAL_C,0,1);
            y = KP_GETCY(KP_Y_VAL_C,KP_HEIGHT_VAL_C,0,48);
            w = KP_GETW(KP_WIDTH_VAL_C,1);
            h = KP_GETH(KP_HEIGHT_VAL_C,(48/32));
        };

        class SPEC_ButtonLoad: KPGUI_PRE_InlineButton {
            text = "$STR_KPLIB_DIALOG_ARSENAL_LOAD";
            x = KP_GETCX(KP_X_VAL_C,KP_WIDTH_VAL_C,0,1);
            y = KP_GETCY(KP_Y_VAL_C,KP_HEIGHT_VAL_C,32,48);
            w = KP_GETW(KP_WIDTH_VAL_C,1);
            h = KP_GETH(KP_HEIGHT_VAL_C,16);
            onButtonClick = "[] call SPEC_fnc_arsenal_applyLoadout";
        };

        class SPEC_ButtonSetDefault: SPEC_ButtonLoad {
            text = "$STR_KPLIB_DIALOG_ARSENAL_DEFAULT";
            y = KP_GETCY(KP_Y_VAL_C,KP_HEIGHT_VAL_C,35,48);
            h = KP_GETH(KP_HEIGHT_VAL_C,24);
            onButtonClick = "[] call SPEC_fnc_arsenal_setDefaultLoadout";
        };

        class SPEC_ComboNear: KPGUI_PRE_Combo {
            idc = SPEC_IDC_ARSENAL_COMBONEAR;
            x = KP_GETCX(KP_X_VAL_C,KP_WIDTH_VAL_C,0,1);
            y = KP_GETCY(KP_Y_VAL_C,KP_HEIGHT_VAL_C,39,48);
            w = KP_GETW(KP_WIDTH_VAL_C,(12/11));
            h = KP_GETH(KP_HEIGHT_VAL_C,24);
        };

        class SPEC_RefreshNear: KPGUI_PRE_CloseCross {
            text = "KPGUI\res\icon_refresh.paa";
            x = KP_GETCX(KP_X_VAL_C,KP_WIDTH_VAL_C,11,12);
            y = KP_GETCY(KP_Y_VAL_C,KP_HEIGHT_VAL_C,39,48);
            w = KP_GETW(KP_WIDTH_VAL_C,12);
            h = KP_GETH(KP_HEIGHT_VAL_C,24);
            tooltip = "$STR_KPLIB_REFRESH";
            action = "[] call SPEC_fnc_arsenal_getNearPlayers";
        };

        class SPEC_ButtonLoadNear: SPEC_ButtonSetDefault {
            text = "$STR_KPLIB_DIALOG_ARSENAL_LOADNEAR";
            y = KP_GETCY(KP_Y_VAL_C,KP_HEIGHT_VAL_C,41,48);
            onButtonClick = "[] call SPEC_fnc_arsenal_copyLoadout";
        };

        class SPEC_ButtonOpen: SPEC_ButtonLoad {
            text = "$STR_KPLIB_DIALOG_ARSENAL_OPEN";
            y = KP_GETCY(KP_Y_VAL_C,KP_HEIGHT_VAL_C,45,48);
            onButtonClick = "[] call SPEC_fnc_arsenal_openArsenal";
        };

        class KPLIB_DialogCross: KPGUI_PRE_DialogCrossC {};

    };

};
