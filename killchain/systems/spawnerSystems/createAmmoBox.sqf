_pos = _this select 0;

_ammoBoxVN = "CargoNet_01_box_F" createVehicle _pos;
sleep 1;
clearMagazineCargoGlobal _ammoBoxVN;
clearWeaponCargoGlobal _ammoBoxVN;
clearItemCargoGlobal _ammoBoxVN;

// basics 
_ammoBoxVN addWeaponCargo ["vn_m16", 5];
_ammoBoxVN addWeaponCargo ["vn_m72", 4];
_ammoBoxVN addItemCargo ["vn_b_item_trapkit", 1];
_ammoBoxVN addItemCargo ["vn_b_item_toolkit", 1];
_ammoBoxVN addItemCargo ["FirstAidKit", 15];
_ammoBoxVN addItemCargo ["Medikit", 1];

// bullets and mags 
_ammoBoxVN addMagazineAmmoCargo ["vn_m16_20_mag", 60, 18];
_ammoBoxVN addMagazineAmmoCargo ["vn_m60_100_mag", 15, 100];
_ammoBoxVN addMagazineAmmoCargo ["vn_rpd_100_mag", 15, 100];
_ammoBoxVN addMagazineAmmoCargo ["vn_mk22_mag", 5, 14];
_ammoBoxVN addMagazineAmmoCargo ["vn_m14_mag", 20, 20];
_ammoBoxVN addMagazineAmmoCargo ["vn_carbine_30_mag", 20, 30];
_ammoBoxVN addMagazineAmmoCargo ["vn_m3a1_mag", 20, 30];
_ammoBoxVN addMagazineAmmoCargo ["vn_m38_mag", 10, 5];
_ammoBoxVN addMagazineAmmoCargo ["vn_m1911_mag", 20, 7];
_ammoBoxVN addMagazineAmmoCargo ["vn_22mm_m19_wp_mag", 5, 1];
_ammoBoxVN addMagazineAmmoCargo ["vn_22mm_m1a2_frag_mag", 5, 1];
_ammoBoxVN addMagazineAmmoCargo ["vn_22mm_m22_smoke_mag", 5, 1];

// 40mm 
_ammoBoxVN addMagazineAmmoCargo ["vn_40mm_m406_he_mag", 30, 1];
_ammoBoxVN addMagazineAmmoCargo ["vn_40mm_m680_smoke_w_mag", 6, 1];
_ammoBoxVN addMagazineAmmoCargo ["vn_40mm_m682_smoke_r_mag", 6, 1];
_ammoBoxVN addMagazineAmmoCargo ["vn_40mm_m715_smoke_g_mag", 6, 1];
_ammoBoxVN addMagazineAmmoCargo ["vn_40mm_m716_smoke_y_mag", 6, 1];
_ammoBoxVN addMagazineAmmoCargo ["vn_40mm_m717_smoke_p_mag", 6, 1];

// buck
_ammoBoxVN addMagazineAmmoCargo ["vn_m1897_buck_mag", 20, 6];
_ammoBoxVN addMagazineAmmoCargo ["vn_m1897_fl_mag", 5, 6];

// To Be Classified
_ammoBoxVN addMagazineAmmoCargo ["vn_welrod_mag", 5, 8];
_ammoBoxVN addMagazineAmmoCargo ["vn_hd_mag", 10, 10];
_ammoBoxVN addMagazineAmmoCargo ["vn_hp_mag", 10, 13];
_ammoBoxVN addMagazineAmmoCargo ["vn_m129_mag", 5, 1];
_ammoBoxVN addMagazineAmmoCargo ["vn_m128_mag", 5, 1];
_ammoBoxVN addMagazineAmmoCargo ["vn_m127_mag", 5, 1];
_ammoBoxVN addMagazineAmmoCargo ["vn_m40a1_mag", 5,5];
_ammoBoxVN addMagazineAmmoCargo ["vn_m10_mag", 6, 6];
_ammoBoxVN addMagazineAmmoCargo ["vn_m14_grenade_mag", 5, 1];
_ammoBoxVN addMagazineAmmoCargo ["vn_m34_grenade_mag", 12, 1];

// bangs
_ammoBoxVN addMagazineAmmoCargo ["vn_mine_m18_mag", 6];
_ammoBoxVN addMagazineAmmoCargo ["vn_mine_satchel_remote_02_mag", 2, 1];
_ammoBoxVN addMagazineAmmoCargo ["vn_mine_tripwire_m16_04_mag", 6, 1];
_ammoBoxVN addMagazineAmmoCargo ["vn_m61_grenade_mag", 20, 1];
_ammoBoxVN addMagazineAmmoCargo ["vn_m72_mag", 10, 1];

// colours
_ammoBoxVN addMagazineAmmoCargo ["vn_m18_green_mag", 4, 1];
_ammoBoxVN addMagazineAmmoCargo ["vn_m18_purple_mag", 4, 1];
_ammoBoxVN addMagazineAmmoCargo ["vn_m18_red_mag", 4, 1];
_ammoBoxVN addMagazineAmmoCargo ["vn_m18_yellow_mag", 4, 1];
_ammoBoxVN addMagazineAmmoCargo ["vn_m18_white_mag", 10, 1];
_ammoBoxVN addMagazineAmmoCargo ["vn_v40_grenade_mag", 6, 3];
_ammoBoxVN addMagazineAmmoCargo ["vn_40mm_m583_flare_w_mag", 3, 1];
_ammoBoxVN addMagazineAmmoCargo ["vn_40mm_m661_flare_g_mag", 3, 1];
_ammoBoxVN addMagazineAmmoCargo ["vn_40mm_m695_flare_y_mag", 3, 1];
_ammoBoxVN addMagazineAmmoCargo ["vn_40mm_m662_flare_r_mag", 3, 1];