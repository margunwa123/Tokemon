/* Nama Tokemon (Nama, Hp, Basic Att, Skill Att, Type) */
/* Normal Tokemon */
tokemon(zigzogaan,1500,100,200,water).
tokemon(bulbasaur,2000,50,100,leaf).
tokemon(blue_eyes_white_dragonmon,80,130,1700,fire).
tokemon(toketchur,1200,150,250,fire).
tokemon(momon,2000,60,90,leaf).
tokemon(engasmon,1000,180,300,water).
/* Legendary Tokemon */
leg_tokemon(hadimon,7000,250,500,water).
leg_tokemon(mariomon,5000,350,700,fire).
leg_tokemon(ajimon,6000,300,600,leaf).
leg_tokemon(danmon,6500,250,700,water).
/* Tokemon Awal */
tokemona(wow,2000,100,100,fire).
%tokemona().
%tokemona().

/* Type Tokemon */
strong(fire,leaves).
strong(leaves,water).
strong(water,fire).