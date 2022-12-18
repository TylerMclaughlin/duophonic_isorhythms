def bjorklund(k, n):
    """
    Brian House's code for euclidean rhythms.
    Usage:  bjorklund(3,8) returns [1, 0, 0, 1, 0, 0, 1, 0]
    """
    k = int(k)
    n = int(n)
    if k > n:
        raise ValueError    
    pattern = []    
    counts = []
    remainders = []
    divisor = n - k
    remainders.append(k)
    level = 0
    while True:
        counts.append(divisor // remainders[level])
        remainders.append(divisor % remainders[level])
        divisor = remainders[level]
        level = level + 1
        if remainders[level] <= 1:
            break
    counts.append(divisor)
    
    def build(level):
        if level == -1:
            pattern.append(0)
        elif level == -2:
            pattern.append(1)         
        else:
            for i in range(0, counts[level]):
                build(level - 1)
            if remainders[level] != 0:
                build(level - 2)
    
    build(level)
    i = pattern.index(1)
    pattern = pattern[i:] + pattern[0:i]
    return pattern

def invert(bjorklund_list):
    return [1 - x for x in bjorklund_list]

def split_bjorklund(steps, pulses, i_subonsets, j_suboffset): 
    """ Turns a euclidean rhythm similar to 'distrib' function in TidalCycles
    Inverts the rhythm, and then subdivides with further euclidean rhythms.
    """
    # checks that we can subdivide i_subonsets < onsets (< 3 in bjorklund(8,3))and
    # j_suboffsets < offsets (< 5 in bjorklund(8,3)) 
    n_off_pulses = (steps - pulses)
    assert i_subonsets <= pulses
    assert j_suboffsets <= n_off_pulses
    e = bjorklund(steps, pulses)
    bjorklund_list_inv = invert(bjorklund_list) 
    
if __name__ == '__main__':
    import sys
    k = sys.argv[1]
    n = sys.argv[2]
    b = bjorklund(k,n)
    print(f'E({k},{n}):     {b}')
    print(f'inv E({k},{n}): {invert(b)}')
