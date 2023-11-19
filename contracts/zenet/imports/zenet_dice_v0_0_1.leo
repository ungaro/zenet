program zenet_dice_v0_0_1.aleo {
    mapping dicerolls: u8 => u8;
/*
// Function to roll the dice and return the number of moves (white count).
transition roll_dice_internal() -> u8 {
    let white_count: u8 = 0u8;

  for i: u8 in 0u8..4u8 {
     if get_random_bit() {
            white_count += 1u8;
        }
  }

    // If all sticks are black (white_count is 0), return 0, 
    // otherwise return the count of white sides.
    return white_count;
}
*/


    transition get_random_bit() -> bool {
        // Authenticate proposer.


        // Return a new record for the proposal.
        return true
        then finalize();
    }
    // Create a new proposal in the "tickets" mapping.
    finalize get_random_bit() {

        let current_value: u8 = Mapping::get_or_use(dicerolls, 0u8, 0u8);
let result:u8 = 0u8;



      // Update the appropriate entry with the given move.
        if (ChaCha::rand_bool()==true) {
           result+=1u8;
        }
      // Update the appropriate entry with the given move.
        if (ChaCha::rand_bool()==true) {
           result+=1u8;
        }

      // Update the appropriate entry with the given move.
        if (ChaCha::rand_bool()==true) {
           result+=1u8;
        }
              // Update the appropriate entry with the given move.
        if (ChaCha::rand_bool()==true) {
           result+=1u8;
        }
        Mapping::set(dicerolls, 0u8,result);
    }



}