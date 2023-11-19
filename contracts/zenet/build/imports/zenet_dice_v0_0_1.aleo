program zenet_dice_v0_0_1.aleo;



mapping dicerolls:
	key as u8.public;
	value as u8.public;

function get_random_bit:
    async get_random_bit into r0;
    output true as boolean.private;
    output r0 as zenet_dice_v0_0_1.aleo/get_random_bit.future;

finalize get_random_bit:
    get.or_use dicerolls[0u8] 0u8 into r0;
    rand.chacha into r1 as boolean;
    is.eq r1 true into r2;
    add 0u8 1u8 into r3;
    ternary r2 r3 0u8 into r4;
    rand.chacha into r5 as boolean;
    is.eq r5 true into r6;
    add r4 1u8 into r7;
    ternary r6 r7 r4 into r8;
    rand.chacha into r9 as boolean;
    is.eq r9 true into r10;
    add r8 1u8 into r11;
    ternary r10 r11 r8 into r12;
    rand.chacha into r13 as boolean;
    is.eq r13 true into r14;
    add r12 1u8 into r15;
    ternary r14 r15 r12 into r16;
    set r16 into dicerolls[0u8];
