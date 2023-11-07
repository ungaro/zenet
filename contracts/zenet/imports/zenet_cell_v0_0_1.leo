program zenet_cell_v0_0_1.aleo {




    // // This struct allows us to pass the state and occupant of a cell
    // // with a single variable.
struct Cells {
    state: u32,
    occupant: u32,
}




    // Function to get the occupant of the i-th cell according to the following convention:
    // i-th cell is empty: returns 0u8
    // i-th cell is occupied by player 1: returns 1u8
    // i-th cell is occupied by player 2: returns 2u8
    transition get_cell(state:u32,occupant:u32) -> Cells {
 
return Cells {
    state: state,
    occupant: occupant,
};

    }



    // Auxiliary function that returns true if i-th bit of 'number' is '1'
    inline get_bit(number: u32, i: u8) -> bool {
        let mask: u32 = 1u32 << i-1u8;
        return number.and(mask) > 0u32;
    }

    // Auxiliary function that sets the i-th bit of 'number' to 'bit'
    inline set_bit(number: u32, i: u8, bit: bool) -> u32{
        let mask: u32 = 1u32 << i-1u8;
        if bit {
            return number.or(mask);
        } else {
            return number.and(mask.not());
        }
    }

    // Function to get the occupant of the i-th cell according to the following convention:
    // i-th cell is empty: returns 0u8
    // i-th cell is occupied by player 1: returns 1u8
    // i-th cell is occupied by player 2: returns 2u8
    inline get_cell_occupant(cells: Cells, i: u8) -> u8 {
        let is_occupied: bool = get_bit(cells.state, i);
        if is_occupied {
            return get_bit(cells.occupant, i) ? 2u8 : 1u8;
        } else {
            return 0u8;
        }
    }



    // Function to get the occupant of the i-th cell according to the following convention:
    // i-th cell is empty: returns 0u8
    // i-th cell is occupied by player 1: returns 1u8
    // i-th cell is occupied by player 2: returns 2u8
    function get_cell_occupant_external(cells: Cells, i: u8) -> u8 {
        let is_occupied: bool = get_bit(cells.state, i);
        if is_occupied {
            return get_bit(cells.occupant, i) ? 2u8 : 1u8;
        } else {
            return 0u8;
        }
    }


    // Function to set the occupant of a cell. Takes care of setting both the 'state' and
    // 'occupant' fields accordingly.
    inline set_cell_occupant(cells: Cells, cell: u8, occ: u8) -> Cells {
        // if occ==1u8 (player1) then bit=0, if occ==2u8 (player2) then bit=1;
        let bit: bool = occ == 2u8;
        return Cells {
            state: set_bit(cells.state, cell, true), // the cell is now occupied by a player, thus state = 1
            occupant: set_bit(cells.occupant, cell, bit),
        };
    }

    // Function to clear a cell.
    inline clear_cell(cells: Cells, cell: u8) -> Cells {
        return Cells {
            state: set_bit(cells.state, cell, false),
            occupant: set_bit(cells.occupant, cell, false),
        };
    }

    // Function to clear a cell.
    function clear_cell_external(cells: Cells, cell: u8) -> Cells {
        return Cells {
            state: set_bit(cells.state, cell, false),
            occupant: set_bit(cells.occupant, cell, false),
        };
    }

    // In Zenet, an opponent's protected piece cannot be the target of a move,
    // which means that it cannot be exchanged for the current player's piece.
    // This function returns true if the piece located at a given cell is protected.
    function piece_is_protected(cells: Cells, cell: u8) -> bool {
        // Pieces on cells 26 through 30 are always protected
        if (26u8 <= cell && cell <= 30u8) {
            return true;    
        }
        // If the cell is empty, it makes no sense to ask for protectedness, so
        // we return false.
        let occ: u8 = get_cell_occupant(cells, cell);
        if occ == 0u8 {
            return false;
        }
        // If any of the two adjacent cells contain a piece from the same
        // player, then the piece is protected.
        let prev_cell_occ: u8 = get_cell_occupant(cells, cell - 1u8);
        let next_cell_occ: u8 = get_cell_occupant(cells, cell + 1u8);
        if (prev_cell_occ == occ || next_cell_occ == occ) {
            return true;
        } else {
            return false;
        }
    }


    // This function moves a piece from one cell to another.
    function move_or_exchange_piece(cells: Cells, origin_cell: u8, target_cell: u8, empty:bool) -> Cells {
        if (empty){
        let occ: u8 = get_cell_occupant(cells, origin_cell);
        cells = set_cell_occupant(cells, target_cell, occ);
        cells = clear_cell(cells, origin_cell);
        return cells;
        }else{
               let origin_cell_occ: u8 = get_cell_occupant(cells, origin_cell);
        let target_cell_occ: u8 = get_cell_occupant(cells, target_cell);
        cells = set_cell_occupant(cells, origin_cell, target_cell_occ);
        cells = set_cell_occupant(cells, target_cell, origin_cell_occ);
        return cells;
        }
    }


    // This function moves a piece from one cell to another.
    function move_piece(cells: Cells, origin_cell: u8, target_cell: u8) -> Cells {
        let occ: u8 = get_cell_occupant(cells, origin_cell);
        cells = set_cell_occupant(cells, target_cell, occ);
        cells = clear_cell(cells, origin_cell);
        return cells;
    }

    // This function exchanges the positions of two pieces.
    function exchange_pieces(cells: Cells, origin_cell: u8, target_cell: u8) -> Cells {
        let origin_cell_occ: u8 = get_cell_occupant(cells, origin_cell);
        let target_cell_occ: u8 = get_cell_occupant(cells, target_cell);
        cells = set_cell_occupant(cells, origin_cell, target_cell_occ);
        cells = set_cell_occupant(cells, target_cell, origin_cell_occ);
        return cells;
     }




    function clear_invisible_pieces(cells: Cells, ip_positions: u32) -> Cells {
        let cell_state: u32 = cells.state.and(ip_positions.not());
        let cell_occ: u32 = cells.occupant.and(ip_positions.not());
        return Cells {
            state: cell_state,
            occupant: cell_occ
        };
    }

    // Returns true if the piece that the current player chose to move
    // in fact belongs to the current player.
    function piece_is_valid(origin_cell: u8, owner: address, p1: address, p2: address, cells: Cells) -> bool {
        let player: u8 = get_cell_occupant(cells, origin_cell);
        if player == 1u8 {
            return owner == p1;
        } else if player == 2u8 {
            return owner == p2;
        } else {
            return false;
        }
    }





}