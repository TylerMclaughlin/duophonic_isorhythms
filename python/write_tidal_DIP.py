def print_dip(L,R,K,J):
    l_sequence = " ".join([str(x) for x in list(range(0,L))])
    r_sequence = " ".join([str(x) for x in list(range(0,R))])
    code_prefix = 'let p = stack $ ['
    l_code = f'struct "t*{K}" $ nT "left" {L} (tScale _ "{l_sequence}"),'
    l_code = code_prefix + l_code
    r_code = f'         struct "t*J" $ nT "right" {R} (tScale _ "{r_sequence}")]'
    print('\n'.join([l_code,r_code]))

def test_first_example():
    print_dip(3,4,3,8)

if __name__ == '__main__':
    import sys
    l = int(sys.argv[1])
    r = int(sys.argv[2])
    k = int(sys.argv[3])
    j = int(sys.argv[4])
    print_dip(l,r,k,j)
