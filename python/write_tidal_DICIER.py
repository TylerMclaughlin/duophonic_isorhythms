def print_linear_ecr(L,R,K,N):
    l_sequence = " ".join([str(x) for x in list(range(0,L))])
    r_sequence = " ".join([str(x) for x in list(range(0,R))])
    code_prefix = 'let p = stack $ ['
    euclidean = f'"t({K},{N})"'
    l_code = f'struct {euclidean} $ nT "left" {L} (tScale _ "{l_sequence}"),'
    l_code = code_prefix + l_code
    r_code = f'         struct (inv {euclidean}) $ nT "right" {R} (tScale _ "{r_sequence}")]'
    print('\n'.join([l_code,r_code]))

def test_first_example():
    print_linear_ecr(3,4,3,8)

if __name__ == '__main__':
    import sys
    l = int(sys.argv[1])
    r = int(sys.argv[2])
    k = int(sys.argv[3])
    n = int(sys.argv[4])
    print_linear_ecr(l,r,k,n)
