program zenet_bitwise_v0_0_1.aleo;



closure get_bit_external:
    input r0 as u32;
    input r1 as u8;
    sub r1 1u8 into r2;
    shl 1u32 r2 into r3;
    and r0 r3 into r4;
    gt r4 0u32 into r5;
    output r5 as boolean;


closure set_bit_external:
    input r0 as u32;
    input r1 as u8;
    input r2 as boolean;
    sub r1 1u8 into r3;
    shl 1u32 r3 into r4;
    or r0 r4 into r5;
    not r4 into r6;
    and r0 r6 into r7;
    ternary r2 r5 r7 into r8;
    output r8 as u32;
