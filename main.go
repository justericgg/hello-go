package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {
	port := "9999"

	log.Printf("Service start at %v", port)
	http.HandleFunc("/", helloHandler)

	err := http.ListenAndServe(":"+port, nil)
	log.Fatal(err)

}

func helloHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, GO!\n")
}
