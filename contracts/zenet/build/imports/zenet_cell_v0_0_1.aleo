program zenet_cell_v0_0_1.aleo;

struct Cells:
    state as u32;
    occupant as u32;


function get_cell:
    input r0 as u32.private;
    input r1 as u32.private;
    cast r0 r1 into r2 as Cells;
    output r2 as Cells.private;








closure get_cell_occupant_external:
    input r0 as Cells;
    input r1 as u8;
    sub r1 1u8 into r2;
    shl 1u32 r2 into r3;
    and r0.state r3 into r4;
    gt r4 0u32 into r5;
    sub r1 1u8 into r6;
    shl 1u32 r6 into r7;
    and r0.occupant r7 into r8;
    gt r8 0u32 into r9;
    ternary r9 2u8 1u8 into r10;
    ternary r5 r10 0u8 into r11;
    output r11 as u8;






closure clear_cell_external:
    input r0 as Cells;
    input r1 as u8;
    sub r1 1u8 into r2;
    shl 1u32 r2 into r3;
    or r0.state r3 into r4;
    not r3 into r5;
    and r0.state r5 into r6;
    ternary false r4 r6 into r7;
    sub r1 1u8 into r8;
    shl 1u32 r8 into r9;
    or r0.occupant r9 into r10;
    not r9 into r11;
    and r0.occupant r11 into r12;
    ternary false r10 r12 into r13;
    cast r7 r13 into r14 as Cells;
    output r14 as Cells;


closure piece_is_protected:
    input r0 as Cells;
    input r1 as u8;
    lte 26u8 r1 into r2;
    lte r1 30u8 into r3;
    and r2 r3 into r4;
    sub r1 1u8 into r5;
    shl 1u32 r5 into r6;
    and r0.state r6 into r7;
    gt r7 0u32 into r8;
    sub r1 1u8 into r9;
    shl 1u32 r9 into r10;
    and r0.occupant r10 into r11;
    gt r11 0u32 into r12;
    ternary r12 2u8 1u8 into r13;
    ternary r8 r13 0u8 into r14;
    is.eq r14 0u8 into r15;
    sub r1 1u8 into r16;
    sub r16 1u8 into r17;
    shl 1u32 r17 into r18;
    and r0.state r18 into r19;
    gt r19 0u32 into r20;
    sub r16 1u8 into r21;
    shl 1u32 r21 into r22;
    and r0.occupant r22 into r23;
    gt r23 0u32 into r24;
    ternary r24 2u8 1u8 into r25;
    ternary r20 r25 0u8 into r26;
    add r1 1u8 into r27;
    sub r27 1u8 into r28;
    shl 1u32 r28 into r29;
    and r0.state r29 into r30;
    gt r30 0u32 into r31;
    sub r27 1u8 into r32;
    shl 1u32 r32 into r33;
    and r0.occupant r33 into r34;
    gt r34 0u32 into r35;
    ternary r35 2u8 1u8 into r36;
    ternary r31 r36 0u8 into r37;
    is.eq r26 r14 into r38;
    is.eq r37 r14 into r39;
    or r38 r39 into r40;
    ternary r40 true false into r41;
    ternary r15 false r41 into r42;
    ternary r4 true r42 into r43;
    output r43 as boolean;


closure move_or_exchange_piece:
    input r0 as Cells;
    input r1 as u8;
    input r2 as u8;
    input r3 as boolean;
    sub r1 1u8 into r4;
    shl 1u32 r4 into r5;
    and r0.state r5 into r6;
    gt r6 0u32 into r7;
    sub r1 1u8 into r8;
    shl 1u32 r8 into r9;
    and r0.occupant r9 into r10;
    gt r10 0u32 into r11;
    ternary r11 2u8 1u8 into r12;
    ternary r7 r12 0u8 into r13;
    is.eq r13 2u8 into r14;
    sub r2 1u8 into r15;
    shl 1u32 r15 into r16;
    or r0.state r16 into r17;
    not r16 into r18;
    and r0.state r18 into r19;
    ternary true r17 r19 into r20;
    sub r2 1u8 into r21;
    shl 1u32 r21 into r22;
    or r0.occupant r22 into r23;
    not r22 into r24;
    and r0.occupant r24 into r25;
    ternary r14 r23 r25 into r26;
    cast r20 r26 into r27 as Cells;
    sub r1 1u8 into r28;
    shl 1u32 r28 into r29;
    or r27.state r29 into r30;
    not r29 into r31;
    and r27.state r31 into r32;
    ternary false r30 r32 into r33;
    sub r1 1u8 into r34;
    shl 1u32 r34 into r35;
    or r27.occupant r35 into r36;
    not r35 into r37;
    and r27.occupant r37 into r38;
    ternary false r36 r38 into r39;
    cast r33 r39 into r40 as Cells;
    sub r1 1u8 into r41;
    shl 1u32 r41 into r42;
    and r0.state r42 into r43;
    gt r43 0u32 into r44;
    sub r1 1u8 into r45;
    shl 1u32 r45 into r46;
    and r0.occupant r46 into r47;
    gt r47 0u32 into r48;
    ternary r48 2u8 1u8 into r49;
    ternary r44 r49 0u8 into r50;
    sub r2 1u8 into r51;
    shl 1u32 r51 into r52;
    and r0.state r52 into r53;
    gt r53 0u32 into r54;
    sub r2 1u8 into r55;
    shl 1u32 r55 into r56;
    and r0.occupant r56 into r57;
    gt r57 0u32 into r58;
    ternary r58 2u8 1u8 into r59;
    ternary r54 r59 0u8 into r60;
    is.eq r60 2u8 into r61;
    sub r1 1u8 into r62;
    shl 1u32 r62 into r63;
    or r0.state r63 into r64;
    not r63 into r65;
    and r0.state r65 into r66;
    ternary true r64 r66 into r67;
    sub r1 1u8 into r68;
    shl 1u32 r68 into r69;
    or r0.occupant r69 into r70;
    not r69 into r71;
    and r0.occupant r71 into r72;
    ternary r61 r70 r72 into r73;
    cast r67 r73 into r74 as Cells;
    is.eq r50 2u8 into r75;
    sub r2 1u8 into r76;
    shl 1u32 r76 into r77;
    or r74.state r77 into r78;
    not r77 into r79;
    and r74.state r79 into r80;
    ternary true r78 r80 into r81;
    sub r2 1u8 into r82;
    shl 1u32 r82 into r83;
    or r74.occupant r83 into r84;
    not r83 into r85;
    and r74.occupant r85 into r86;
    ternary r75 r84 r86 into r87;
    cast r81 r87 into r88 as Cells;
    ternary r3 r40.state r88.state into r89;
    ternary r3 r40.occupant r88.occupant into r90;
    cast r89 r90 into r91 as Cells;
    ternary r3 r40.state r88.state into r92;
    ternary r3 r40.occupant r88.occupant into r93;
    cast r92 r93 into r94 as Cells;
    output r94 as Cells;


closure move_piece:
    input r0 as Cells;
    input r1 as u8;
    input r2 as u8;
    sub r1 1u8 into r3;
    shl 1u32 r3 into r4;
    and r0.state r4 into r5;
    gt r5 0u32 into r6;
    sub r1 1u8 into r7;
    shl 1u32 r7 into r8;
    and r0.occupant r8 into r9;
    gt r9 0u32 into r10;
    ternary r10 2u8 1u8 into r11;
    ternary r6 r11 0u8 into r12;
    is.eq r12 2u8 into r13;
    sub r2 1u8 into r14;
    shl 1u32 r14 into r15;
    or r0.state r15 into r16;
    not r15 into r17;
    and r0.state r17 into r18;
    ternary true r16 r18 into r19;
    sub r2 1u8 into r20;
    shl 1u32 r20 into r21;
    or r0.occupant r21 into r22;
    not r21 into r23;
    and r0.occupant r23 into r24;
    ternary r13 r22 r24 into r25;
    cast r19 r25 into r26 as Cells;
    sub r1 1u8 into r27;
    shl 1u32 r27 into r28;
    or r26.state r28 into r29;
    not r28 into r30;
    and r26.state r30 into r31;
    ternary false r29 r31 into r32;
    sub r1 1u8 into r33;
    shl 1u32 r33 into r34;
    or r26.occupant r34 into r35;
    not r34 into r36;
    and r26.occupant r36 into r37;
    ternary false r35 r37 into r38;
    cast r32 r38 into r39 as Cells;
    output r39 as Cells;


closure exchange_pieces:
    input r0 as Cells;
    input r1 as u8;
    input r2 as u8;
    sub r1 1u8 into r3;
    shl 1u32 r3 into r4;
    and r0.state r4 into r5;
    gt r5 0u32 into r6;
    sub r1 1u8 into r7;
    shl 1u32 r7 into r8;
    and r0.occupant r8 into r9;
    gt r9 0u32 into r10;
    ternary r10 2u8 1u8 into r11;
    ternary r6 r11 0u8 into r12;
    sub r2 1u8 into r13;
    shl 1u32 r13 into r14;
    and r0.state r14 into r15;
    gt r15 0u32 into r16;
    sub r2 1u8 into r17;
    shl 1u32 r17 into r18;
    and r0.occupant r18 into r19;
    gt r19 0u32 into r20;
    ternary r20 2u8 1u8 into r21;
    ternary r16 r21 0u8 into r22;
    is.eq r22 2u8 into r23;
    sub r1 1u8 into r24;
    shl 1u32 r24 into r25;
    or r0.state r25 into r26;
    not r25 into r27;
    and r0.state r27 into r28;
    ternary true r26 r28 into r29;
    sub r1 1u8 into r30;
    shl 1u32 r30 into r31;
    or r0.occupant r31 into r32;
    not r31 into r33;
    and r0.occupant r33 into r34;
    ternary r23 r32 r34 into r35;
    cast r29 r35 into r36 as Cells;
    is.eq r12 2u8 into r37;
    sub r2 1u8 into r38;
    shl 1u32 r38 into r39;
    or r36.state r39 into r40;
    not r39 into r41;
    and r36.state r41 into r42;
    ternary true r40 r42 into r43;
    sub r2 1u8 into r44;
    shl 1u32 r44 into r45;
    or r36.occupant r45 into r46;
    not r45 into r47;
    and r36.occupant r47 into r48;
    ternary r37 r46 r48 into r49;
    cast r43 r49 into r50 as Cells;
    output r50 as Cells;


closure clear_invisible_pieces:
    input r0 as Cells;
    input r1 as u32;
    not r1 into r2;
    and r0.state r2 into r3;
    not r1 into r4;
    and r0.occupant r4 into r5;
    cast r3 r5 into r6 as Cells;
    output r6 as Cells;


closure piece_is_valid:
    input r0 as u8;
    input r1 as address;
    input r2 as address;
    input r3 as address;
    input r4 as Cells;
    sub r0 1u8 into r5;
    shl 1u32 r5 into r6;
    and r4.state r6 into r7;
    gt r7 0u32 into r8;
    sub r0 1u8 into r9;
    shl 1u32 r9 into r10;
    and r4.occupant r10 into r11;
    gt r11 0u32 into r12;
    ternary r12 2u8 1u8 into r13;
    ternary r8 r13 0u8 into r14;
    is.eq r14 1u8 into r15;
    is.eq r1 r2 into r16;
    is.eq r14 2u8 into r17;
    is.eq r1 r3 into r18;
    not r15 into r19;
    and r19 r17 into r20;
    ternary r20 r18 false into r21;
    ternary r15 r16 r21 into r22;
    output r22 as boolean;
