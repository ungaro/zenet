program zenet_board_v0_0_1.aleo;

record Board:
    owner as address.private;
    gates as u64.private;
    cell_state as u32.private;
    cell_occ as u32.private;
    p1 as address.private;
    p2 as address.private;

record InvisiblePieces:
    owner as address.private;
    gates as u64.private;
    positions as u32.private;


function validate_board2:
    input r0 as Board.record;
    output true as boolean.private;


closure validate_board:
    input r0 as Board.record;
    input r1 as InvisiblePieces.record;
    is.eq r0.owner r0.p1 into r2;
    and r0.cell_occ r1.positions into r3;
    and r0.cell_state r3 into r4;
    is.eq r4 0u32 into r5;
    not r0.cell_occ into r6;
    and r1.positions r6 into r7;
    and r0.cell_state r7 into r8;
    is.eq r8 0u32 into r9;
    ternary r2 r5 r9 into r10;
    output r10 as boolean;


function get_board:
    input r0 as address.private;
    input r1 as u32.private;
    input r2 as u32.private;
    input r3 as address.private;
    input r4 as address.private;
    cast r3 0u64 r1 r2 r3 r4 into r5 as Board.record;
    output r5 as Board.record;


function get_ip:
    input r0 as address.private;
    input r1 as u64.private;
    input r2 as u32.private;
    cast r0 r1 r2 into r3 as InvisiblePieces.record;
    output r3 as InvisiblePieces.record;


closure get_cell_type:
    input r0 as u8;
    is.eq r0 15u8 into r1;
    is.eq r0 26u8 into r2;
    is.eq r0 27u8 into r3;
    is.eq r0 28u8 into r4;
    is.eq r0 29u8 into r5;
    is.eq r0 30u8 into r6;
    not r1 into r7;
    not r2 into r8;
    and r7 r8 into r9;
    not r3 into r10;
    and r9 r10 into r11;
    not r4 into r12;
    and r11 r12 into r13;
    not r5 into r14;
    and r13 r14 into r15;
    and r15 r6 into r16;
    ternary r16 6u8 0u8 into r17;
    not r1 into r18;
    not r2 into r19;
    and r18 r19 into r20;
    not r3 into r21;
    and r20 r21 into r22;
    not r4 into r23;
    and r22 r23 into r24;
    and r24 r5 into r25;
    ternary r25 5u8 r17 into r26;
    not r1 into r27;
    not r2 into r28;
    and r27 r28 into r29;
    not r3 into r30;
    and r29 r30 into r31;
    and r31 r4 into r32;
    ternary r32 4u8 r26 into r33;
    not r1 into r34;
    not r2 into r35;
    and r34 r35 into r36;
    and r36 r3 into r37;
    ternary r37 3u8 r33 into r38;
    not r1 into r39;
    and r39 r2 into r40;
    ternary r40 2u8 r38 into r41;
    ternary r1 1u8 r41 into r42;
    output r42 as u8;
