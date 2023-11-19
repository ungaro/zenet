program zenet_dice.aleo;

struct DiceArray:
    stick1 as field;
    stick2 as field;
    stick3 as field;
    stick4 as field;

struct PlayerInit:
    player_addr as address;
    user_secret_hash as field;

struct Player:
    user as address;
    game_hash as field;
    user_secret_hash as field;

struct DiceRolls:
    user as address;
    game_hash as field;
    dice_values as DiceArray;
    current_turn as field;


mapping game_hash_to_turn_counter:
	key as field.public;
	value as field.public;

function init_game_hash:
    input r0 as PlayerInit.public;
    input r1 as PlayerInit.public;
    assert.neq r0.user_secret_hash 0field;
    assert.neq r1.user_secret_hash 0field;
    add r0.user_secret_hash r1.user_secret_hash into r2;
    cast r0.player_addr r2 r0.user_secret_hash into r3 as Player;
    cast r1.player_addr r2 r1.user_secret_hash into r4 as Player;
    cast 0field 0field 0field 0field into r5 as DiceArray;
    cast r3.user r2 r5 0field into r6 as DiceRolls;
    async init_game_hash r2 into r7;
    output r3 as Player.private;
    output r4 as Player.private;
    output r6 as DiceRolls.private;
    output r7 as zenet_dice.aleo/init_game_hash.future;

finalize init_game_hash:
    input r0 as field.public;
    set 0field into game_hash_to_turn_counter[r0];


closure roll_stick:
    input r0 as field;
    input r1 as field;
    input r2 as field;
    add r0 r1 into r3;
    add r3 r2 into r4;
    hash.psd2 r4 into r5 as u8;
    lt r5 63u8 into r6;
    ternary r6 0field 1field into r7;
    output r7 as field;


closure calculate_total_roll:
    input r0 as DiceArray;
    add r0.stick1 r0.stick2 into r1;
    add r1 r0.stick3 into r2;
    add r2 r0.stick4 into r3;
    output r3 as field;


function roll_dice:
    input r0 as DiceRolls.private;
    input r1 as Player.private;
    input r2 as field.private;
    assert.eq r0.game_hash r1.game_hash;
    assert.neq r0.game_hash 0field;
    hash.psd2 r2 into r3 as field;
    assert.eq r1.user_secret_hash r3;
    add r0.current_turn 1field into r4;
    call roll_stick r4 r0.dice_values.stick1 r2 into r5;
    call roll_stick r4 r0.dice_values.stick2 r2 into r6;
    call roll_stick r4 r0.dice_values.stick3 r2 into r7;
    call roll_stick r4 r0.dice_values.stick4 r2 into r8;
    cast r5 r6 r7 r8 into r9 as DiceArray;
    call calculate_total_roll r9 into r10;
    is.eq r10 1field into r11;
    is.eq r10 4field into r12;
    or r11 r12 into r13;
    is.eq r10 0field into r14;
    or r13 r14 into r15;
    cast r1.user r0.game_hash r9 r4 into r16 as DiceRolls;
    async roll_dice r0.game_hash r4 r15 into r17;
    output r16 as DiceRolls.private;
    output r15 as boolean.private;
    output r17 as zenet_dice.aleo/roll_dice.future;

finalize roll_dice:
    input r0 as field.public;
    input r1 as field.public;
    input r2 as boolean.public;
    get game_hash_to_turn_counter[r0] into r3;
    add r3 1field into r4;
    assert.eq r1 r4;
    set r3 into game_hash_to_turn_counter[r0];
    set r1 into game_hash_to_turn_counter[r0];
