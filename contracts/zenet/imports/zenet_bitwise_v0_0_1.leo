program zenet_bitwise_v0_0_1.aleo {

    // Auxiliary function that returns true if i-th bit of 'number' is '1'
    function get_bit_external(number: u32, i: u8) -> bool {
        let mask: u32 = 1u32 << i-1u8;
        return number.and(mask) > 0u32;
    }

    // Auxiliary function that sets the i-th bit of 'number' to 'bit'
    function set_bit_external(number: u32, i: u8, bit: bool) -> u32{
        let mask: u32 = 1u32 << i-1u8;
        if bit {
            return number.or(mask);
        } else {
            return number.and(mask.not());
        }
    }



}