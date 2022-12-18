def gcd(x, y):
    assert isinstance(x, int)
    assert isinstance(y, int)
    assert x > 0 
    assert y > 0 
    smaller = min(x,y) 
    for i in range(1, smaller + 1):
        if((x % i == 0) and (y % i == 0)):
            gcd = i
             
    return gcd

def iso_period(Nc, Nt):
    return int(Nc/gcd(Nc, Nt))

def period_formula(L,R,K,J):
    #result = L*R*K*J/gcd(L,R)/gcd(L,K)/gcd(R,J)
    #result = L*R/gcd(L,R)
    # * explains 9957/11625. result = L*R/gcd(L,R)/gcd(L,K)/gcd(R,J)
    # result = L*R/gcd(L,R)/gcd(L,K)/gcd(R,J)
    #result = iso_period(L,K)*iso_period(R,J)/iso_period(int(iso_period(L,K)),int(iso_period(R,J)))
    result = iso_period(L,K)*iso_period(R,J)
    result = result / gcd(iso_period(L,K), iso_period(R,J)) 
    return result

if __name__ == '__main__':
    import pandas as pd
    r = pd.read_csv('results.csv')
    #k_1 = r[r.K == 1]
    k_1 = r
    k_1['LRKJ_gcd'] = k_1.apply(lambda x : period_formula(x.L,x.R,x.K,x.J), axis = 1)
    k_1['LRKJ_gcd_nc_quo'] = k_1.apply(lambda x : x.num_cycles/x.LRKJ_gcd, axis = 1)
    print(k_1.shape[0])
    print(f'total number: {k_1.shape[0]}')
    explained = k_1[k_1.LRKJ_gcd == k_1.num_cycles]
    print(f'number explained: {explained.shape[0]}')
    not_explained = k_1[k_1.LRKJ_gcd != k_1.num_cycles]
    print('not explaned by gcd')
    print(not_explained[['L','R','K','J','LRKJ_gcd','euclidean_cycle_length','num_cycles']])
    print(not_explained['LRKJ_gcd_nc_quo'].value_counts())
