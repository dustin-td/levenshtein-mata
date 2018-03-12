program levenshtein
		mata: levenshtein("`1'", "`2'")
		di as txt "Levenshtein distance between `1' and `2' is `r(ld)'"
end	
		
mata:

real scalar min3(real scalar a, real scalar b, real scalar c)
{
	mi = a
	if (b < mi) {
		mi = b
	}
	if (c < mi) {
		mi = c
	}
	return(mi)
}

real scalar levenshtein(string scalar s, string scalar t)
{
	real matrix D
	real scalar n
	real scalar m
	real scalar cost
	
	// Step 1
	
	n = strlen(s)
	m = strlen(t)
	
	if (n == 0) {
		return(m)
	}
	if (m == 0) {
		return(n)
	}
	
	D = J(n+1,m+1,.)
	
	// Step 2
	
	D[1,1] = 0
	for (i = 1; i <= n; i++) {
		D[i+1,1] = i
	}
	for (j = 1; j <= m; j++) {
		D[1,j+1] = j
	}
	
	// Step 3
	
	for (i = 2; i <= n; i++) {
		s_i = uchar(ascii(s)[i-1])
		
		// Step 4
		
		for (j = 2; j <= m; j++) {
			t_j = uchar(ascii(t)[j-1])
			
			// Step 5
			
			if (s_i == t_j) {
				cost = 0
			}
			else {
				cost = 1
			}
			
			// Step 6
			
			D[i,j] = min3(D[i-1,j]+1, D[i,j-1]+1, D[i-1,j-1]+cost)
		}
	}
	
	// Step 7
	st_rclear()
	st_numscalar("r(ld)", D[n,m])
	return(D[n,m])
	
}

end