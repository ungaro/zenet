program zenet_dice.aleo {


struct DiceArray {
    stick1: field,
    stick2: field,
    stick3: field,
    stick4: field,
}


    // Stores player's stage during initial stage
    struct PlayerInit {
        player_addr: address;
        user_secret_hash: field;
    }

    // Stores player's state after initial stage
    struct Player {
        user: address;
        game_hash: field;
        user_secret_hash: field;
    }

    // Store dice roll state
    struct DiceRolls {
        user: address;
        game_hash: field;
        dice_values: DiceArray;
        current_turn: field;
    }
 // Maps game hash to turn counter
    mapping game_hash_to_turn_counter: field => field;

    // Initialize game hash and first DiceRolls record using player's secret hashes
    transition init_game_hash(
        public player_init_1: PlayerInit,
        public player_init_2: PlayerInit
    ) -> (Player, Player, DiceRolls) {
        // Ensure user secret hash is not 0
        assert_neq(player_init_1.user_secret_hash, 0field);
        assert_neq(player_init_2.user_secret_hash, 0field);
        
        // Initial game hash is the summation of both players' secret hashes
        let game_hash: field = player_init_1.user_secret_hash + player_init_2.user_secret_hash;

        // Create Player structs for each player
        let player_1: Player = Player {
            user: player_init_1.player_addr,
            game_hash,
            user_secret_hash: player_init_1.user_secret_hash
        };
        let player_2: Player = Player {
            user: player_init_2.player_addr,
            game_hash,
            user_secret_hash: player_init_2.user_secret_hash
        };

        // Create initial DiceRolls struct
        let starting_record: DiceRolls = DiceRolls {
            user: player_1.user, // Start with Player 1
            game_hash, 
            dice_values: DiceArray{stick1:0field, stick2:0field, stick3:0field, stick4:0field}, // Initial dice values
            current_turn: 0field // Start from turn 0
        };
        
        return (player_1, player_2, starting_record) then finalize(game_hash);
    }
 finalize init_game_hash(game_hash: field) {
        Mapping::set(game_hash_to_turn_counter, game_hash, 0field);
    }
// Compute new dice rolls using the previous rolls, game hash, and player's secret
    transition roll_dice(last_rolls: DiceRolls, player: Player, secret: field) -> (DiceRolls, bool) {

        // Ensure the caller is not the last player who just generated the game hash
        
        // remove for debug purposes / add for the real game
        //assert_neq(last_rolls.user, self.caller);  
        
        assert_eq(last_rolls.game_hash, player.game_hash); // Ensure game hash matches
        assert_neq(last_rolls.game_hash, 0field); // Ensure game hash is not 0
        
        // Compute secret hash and ensure it's valid
        let computed_user_hash: field = Poseidon2::hash_to_field(secret);
        assert_eq(player.user_secret_hash, computed_user_hash);
      
        // Increment current turn by 1 (similar to a nonce)
        let current_turn: field = last_rolls.current_turn + 1field;
 
        let new_dice_values: DiceArray = 
        DiceArray{
            stick1: roll_stick(current_turn, last_rolls.dice_values.stick1, secret),
            stick2: roll_stick(current_turn, last_rolls.dice_values.stick2, secret),
            stick3: roll_stick(current_turn, last_rolls.dice_values.stick3, secret),
            stick4: roll_stick(current_turn, last_rolls.dice_values.stick4, secret)
            };
        


        let total_roll:field = calculate_total_roll(new_dice_values);

        // Check if the player gets an extra turn
        let extra_turn : bool = (total_roll == 1field || total_roll == 4field || total_roll == 0field);

        return (DiceRolls {
            user: player.user,
            game_hash: last_rolls.game_hash,
            dice_values: new_dice_values,
            current_turn: current_turn
        }, extra_turn) then finalize(last_rolls.game_hash, current_turn, extra_turn);
    }

    finalize roll_dice(game_hash: field, current_turn: field, extra_turn: bool) {
        let last_turn: field = Mapping::get(game_hash_to_turn_counter, game_hash);
        assert_eq(current_turn, last_turn + 1field); // Ensure turn is incremented correctly

        if extra_turn {
            // If extra turn, do not increment the turn counter in the mapping
            Mapping::set(game_hash_to_turn_counter, game_hash, last_turn);
        } else {
            // Increment turn counter in the mapping
            Mapping::set(game_hash_to_turn_counter, game_hash, current_turn);
        }
    }
    
    // Simulate rolling a stick
     function roll_stick(turn: field, previous_value: field, secret: field) -> field {
        // Generate a pseudo-random seed by hashing turn, previous roll, and secret
       let random_seed: u8 = Poseidon2::hash_to_u8(turn + previous_value + secret);

        // Simulate bias: 0field for flat (0-62) and 1field for curved (63-99)
        if (random_seed < 63u8) {
            return 0field; // Flat
        } else {
            return 1field; // Curved
        }
    }
    // Calculate the total value of the dice rolls
    function calculate_total_roll(dice_values: DiceArray) -> field {
        let total: field = 0field;
        total = dice_values.stick1 + dice_values.stick2 + dice_values.stick3 + dice_values.stick4;
      
        return total;
    }

}