"""
R. Tyler McLaughlin
November 14th, 2022.
"""

import string
import pandas as pd
from itertools import cycle
from bjorklund import bjorklund, invert

"""
Define the default values.

 K is the number of onsets in the Euclidean Rhythm, N is the total number of grid points., 

 the Tresillo, denoted by t(3,8) in TidalCycles,

 K is 3, and N is 8.  Silent notes (the False values) in this are calculated by N - K.

# Given left and right hands on a piano, we set the maximum L and R values to be 5. 
L is the number of notes in the arpeggio in the left hand.
R is the number of notes in the arpeggio in the right hand.
"""

"""
L      
0--1--2-0--1--2-0--1--2-0--1--2-|0--1--2-
-01-23-0-12-30-1-23-01-2-30-12-3|-01-23-0-
R
"""

def get_two_hand_cycle_length(L, R, K, N):
    # this function calculates for L being associated with K and R being associated with N - K.
    # K (onset number) starts on beat 0.
    searching = True
    n_grids = 0
    L_pos = 0
    R_pos = 0
    while searching:     
        L_pos = (L_pos + K) % L
        R_pos = (R_pos + (N - K)) % R
        n_grids += 1
        if (R_pos == 0) and (L_pos == 0):
            break
    return n_grids*N

# test:  expected amount is 32
#test_result = get_cycle_length(3, 4, 3, 8)
#print(test_result)


alphabet = list(string.ascii_lowercase)

def isorhythmize(onsets_list, isorhythm_sequence_len, rest_symbol = '.'):
    """ replaces each successive occurrence of 1
    in onsets_list with the next isorhythm letter (labeled alphabetically)
    """
    isorhythm_cycle = cycle(range(isorhythm_sequence_len))
    i_list = []
    for o in onsets_list:
        if o == 1:
            i_val = alphabet[next(isorhythm_cycle)]
        elif o == 0:
            i_val = rest_symbol
        else:
            raise ValueError('isorhythmize can only accept values equal to 0 or 1.')
        i_list.append(i_val)
    return "".join(i_list)
        
def test_isorhythmize():
    i = isorhythmize([1,0,0,0,1,1,0,1,0,1,1,0,0,1, 0, 0, 0, 0, 1, 0, 1, 1], 5) 
    print(i)

def euclidean_isorhythm_string(l, r, k, n, cycle_length = None):
    euclidean = bjorklund(k, n) 
    inv_euclidean = invert(euclidean) 

    if cycle_length is not None:
        assert (cycle_length % n) == 0
        # string multiplication to extend the rhythm part of the string
        repeats = int(cycle_length/n)
    else:
        repeats = 1
    euclidean = euclidean*repeats
    inv_euclidean = inv_euclidean*repeats
    estring = "".join([str(o) for o in euclidean])
    inv_estring = "".join([str(o) for o in inv_euclidean])
    isostringl = isorhythmize(euclidean, l)
    isostringr = isorhythmize(inv_euclidean, r)
    return estring, inv_estring, isostringl, isostringr

def test_string_representation():
    string_results = euclidean_isorhythm_string(3,4,3,8, cycle_length = 32)
    #string_results = euclidean_isorhythm_string(4,5,13,27, cycle_length = 54)
    for s in string_results:
        print(s)
    

def get_data_dict(l,r,k,n, get_strings = True):
    if (l == 1) or (r == 1) or (k == 1) or ((n - k) == 1):
        is_trivial = 'trivial'
    else:
        is_trivial = 'nontrivial'
    cycle_length = get_two_hand_cycle_length(l, r, k, n)
    assert (cycle_length % n) == 0
    num_cycles = int(cycle_length / n)
    
    data_dict = {'L' : l, 'R' : r,
                   'K' : k, 'N' : n,'J' : (n - k),
                   'is_trivial' : is_trivial,
                   'euclidean_cycle_length' : cycle_length,
                   'num_cycles' : num_cycles,
                   }
    if get_strings:
        string_rep = euclidean_isorhythm_string(l, r, k, n,\
                                  cycle_length = cycle_length)
        string_dict = { 'euclidean_string' : string_rep[0],
                        'inv_euclidean_string' : string_rep[1],
                        'isorhythm_string_l' : string_rep[2],
                        'isorhythm_string_r' : string_rep[3]}
        data_dict = {**data_dict, **string_dict}
    return data_dict


min_grid_default = 2 
max_grid_default = 32 
max_per_hand_default = 5 

def enumerate_two_hand_rhythms(n_min = min_grid_default, n_max = max_grid_default, h_max =  max_per_hand_default, get_strings = True  ):
    assert n_min >= 2
    pd_row_list = []
    # make this a tensor if it's really slow!!
    for n in range(min_grid_default, n_max + 1): 
        print(n)
        for k in range(1, n - 1):
            for l in range(1, h_max + 1 ):
                for r in range(1, h_max + 1 ):
                    row_dict_lr = get_data_dict(l,r,k,n, get_strings)
                    row_dict_rl = get_data_dict(r,l,k,n, get_strings)
                    pd_row_list.append(row_dict_lr)
                    pd_row_list.append(row_dict_rl)
    df = pd.DataFrame(pd_row_list)
    df = df.drop_duplicates(subset = ['L','R','K','N']) 
    return df 

def main_table():
    results_df = enumerate_two_hand_rhythms()
    results_df.to_csv('results.csv', index = None)

if __name__ == '__main__':
    #main_table()

    # tests
    #test_isorhythmize()
    #test_string_representation()

    # insanity
    #results_df = enumerate_two_hand_rhythms(h_max = 30, get_strings = False)
    #results_df.to_csv('results_LR_30.csv', index = None)

    results_df = enumerate_two_hand_rhythms(h_max = 200, n_max = 3, get_strings = False)
    results_df.to_csv('results_LR_200_nmax3.csv', index = None)
