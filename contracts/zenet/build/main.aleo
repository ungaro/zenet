import zenet_board_v0_0_1.aleo;
import zenet_cell_v0_0_1.aleo;
import vrf_v0_0_1.aleo;
program zenet.aleo;












closure get_opponent:
    input r0 as zenet_board_v0_0_1.aleo/Board.record;
    is.eq r0.owner r0.p1 into r1;
    ternary r1 r0.p2 r0.p1 into r2;
    output r2 as address;


function new:
    input r0 as address.private;
    call zenet_board_v0_0_1.aleo/get_board self.caller 1023u32 682u32 self.caller r0 into r1;
    call zenet_board_v0_0_1.aleo/get_ip self.caller 0u64 0u32 into r2;
    call zenet_board_v0_0_1.aleo/get_ip r0 0u64 0u32 into r3;
    output r1 as zenet_board_v0_0_1.aleo/Board.record;
    output r2 as zenet_board_v0_0_1.aleo/InvisiblePieces.record;
    output r3 as zenet_board_v0_0_1.aleo/InvisiblePieces.record;


function move:
    input r0 as u8.private;
    input r1 as u8.private;
    input r2 as zenet_board_v0_0_1.aleo/Board.record;
    input r3 as zenet_board_v0_0_1.aleo/InvisiblePieces.record;
    call zenet_board_v0_0_1.aleo/validate_board r2 r3 into r4;
    assert.eq r4 true;
    call zenet_cell_v0_0_1.aleo/get_cell 8u32 10u32 into r5;
    lte 1u8 r1 into r6;
    lte r1 5u8 into r7;
    and r6 r7 into r8;
    assert.eq r8 true;
    add r0 r1 into r9;
    call zenet_cell_v0_0_1.aleo/get_cell_occupant_external r5 r0 into r10;
    is.eq r10 1u8 into r11;
    is.eq r10 2u8 into r12;
    or r11 r12 into r13;
    assert.eq r13 true;
    call zenet_cell_v0_0_1.aleo/get_cell_occupant_external r5 r9 into r14;
    is.neq r14 r10 into r15;
    assert.eq r15 true;
    is.eq r14 0u8 into r16;
    call zenet_cell_v0_0_1.aleo/piece_is_protected r5 r9 into r17;
    not r16 into r18;
    not r17 into r19;
    and r18 r19 into r20;
    not r17 into r21;
    and r16 r21 into r22;
    or r20 r22 into r23;
    assert.eq r23 true;
    call zenet_cell_v0_0_1.aleo/move_or_exchange_piece r5 r0 r9 r16 into r24;
    sub r0 1u8 into r25;
    shl 1u32 r25 into r26;
    and r3.positions r26 into r27;
    gt r27 0u32 into r28;
    sub r0 1u8 into r29;
    shl 1u32 r29 into r30;
    or r3.positions r30 into r31;
    not r30 into r32;
    and r3.positions r32 into r33;
    ternary false r31 r33 into r34;
    sub r9 1u8 into r35;
    shl 1u32 r35 into r36;
    or r34 r36 into r37;
    not r36 into r38;
    and r34 r38 into r39;
    ternary true r37 r39 into r40;
    ternary r28 r40 r3.positions into r41;
    is.eq r1 2u8 into r42;
    is.eq r1 3u8 into r43;
    or r42 r43 into r44;
    call get_opponent r2 into r45;
    ternary r44 r45 r2.owner into r46;
    call zenet_board_v0_0_1.aleo/get_board self.caller 1023u32 682u32 self.caller r2.p2 into r47;
    call zenet_board_v0_0_1.aleo/get_ip r3.owner r3.gates r41 into r48;
    output r47 as zenet_board_v0_0_1.aleo/Board.record;
    output r48 as zenet_board_v0_0_1.aleo/InvisiblePieces.record;
