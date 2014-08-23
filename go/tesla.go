package main

import ( "fmt")

type row [12] float64

var revs row


func main() {
	revs[0] = 1328.7
	rgr := linic(0.7, 0.0275)	
	for i:= 1; i< 12; i++ { revs[i] = revs[i-1] * (1.0 + rgr[i]) }
	//for i := 1; i< 13; i++ { 
	//	revs[i] = revs[i-1] * 1.7
	//	if i>5 { 	
	fmt.Println(rgr)
	fmt.Println(revs)
	fmt.Println("Finished")
}


func linic(a float64, b float64) row {
	var r row
	for i:= 0; i< 6; i++ { r[i] = a }
	for i:= 0; i< 5; i++ { r[i+6] = a + (b-a) * float64(i+1)/5.0 }
	r[11] = b
	return r
}

